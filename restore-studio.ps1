$ErrorActionPreference = 'Stop'
$studio = $PSScriptRoot

if ($env:OS -ne 'Windows_NT' -or ![Environment]::Is64BitOperatingSystem) {
    throw 'These runtime archives are for Windows x64.'
}
Add-Type -AssemblyName System.IO.Compression.FileSystem
$archives = Join-Path $studio 'runtime-win-x64'
$tools = Join-Path $studio 'tools'
New-Item -ItemType Directory -Force -Path $tools | Out-Null
foreach ($bundle in (Get-Content -Raw -LiteralPath (Join-Path $archives 'manifest.json') | ConvertFrom-Json)) {
    $dest = Join-Path $tools $bundle.name
    $archive = [IO.Path]::GetTempFileName()
    try {
        $output = [IO.File]::OpenWrite($archive)
        try {
            foreach ($part in $bundle.parts) {
                $inputStream = [IO.File]::OpenRead((Join-Path $archives $part))
                try { $inputStream.CopyTo($output) } finally { $inputStream.Dispose() }
            }
        } finally { $output.Dispose() }
        if ((Get-FileHash -LiteralPath $archive).Hash -ne $bundle.sha256) {
            throw "Runtime checksum mismatch: $($bundle.name)"
        }
        $zip = [IO.Compression.ZipFile]::OpenRead($archive)
        try {
            foreach ($entry in $zip.Entries) {
                $file = [IO.Path]::GetFullPath((Join-Path $dest $entry.FullName))
                if (!$file.StartsWith(($dest + '\'), [StringComparison]::OrdinalIgnoreCase)) { throw "Invalid archive path: $file" }
                if ([IO.File]::Exists($file)) {
                    $stream = $entry.Open()
                    try { $hash = (Get-FileHash -InputStream $stream).Hash } finally { $stream.Dispose() }
                    if ((Get-FileHash -LiteralPath $file).Hash -ne $hash) { throw "Different file already exists: $file" }
                } else {
                    [IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($file)) | Out-Null
                    [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $file)
                }
            }
        } finally { $zip.Dispose() }
    } finally { [IO.File]::Delete($archive) }
}
$env:Path = "$tools\python;$tools\node\bin;$tools\ffmpeg\bin;$env:Path"

function Connect-SkillDirectory([string]$Path, [string]$Target) {
    $existing = Get-Item -Force -LiteralPath $Path -ErrorAction SilentlyContinue
    if ($existing) {
        if ($existing.LinkType -eq 'Junction' -and $existing.Target -eq $Target) { return }
        throw "Path already in use: $Path"
    }
    New-Item -ItemType Junction -Path $Path -Target $Target | Out-Null
}

$skills = Join-Path $studio '.agents\skills'
$collection = Join-Path $studio 'vibe-motion\skills'
foreach ($entry in Get-ChildItem -Directory -LiteralPath $collection) {
    if (Test-Path -LiteralPath (Join-Path $entry.FullName 'SKILL.md')) {
        Connect-SkillDirectory (Join-Path $skills $entry.Name) $entry.FullName
    }
}
New-Item -ItemType Directory -Force -Path (Join-Path $studio '.claude') | Out-Null
Connect-SkillDirectory (Join-Path $studio '.claude\skills') $skills

$twoD = Join-Path $studio 'vibe-motion\create-vibe-motion'
if (!(Test-Path -LiteralPath (Join-Path $twoD 'packages\create-vibe-motion\template'))) {
    node (Join-Path $twoD 'scripts\sync-template-to-cli.mjs')
    if ($LASTEXITCODE -ne 0) { throw '2D template preparation failed.' }
}
