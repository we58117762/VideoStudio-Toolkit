$ErrorActionPreference = 'Stop'
$studio = $PSScriptRoot
git -C $studio submodule update --init --recursive
if ($LASTEXITCODE -ne 0) { throw 'Git submodule checkout failed.' }

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
