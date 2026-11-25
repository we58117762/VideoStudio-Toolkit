# VideoStudio-Leo

视频工作室的项目根目录。包含三个声音技能、Vibe Motion 动效技能合集、2D 和 3D 脚手架，以及字幕成片工作流。

## 在 Windows 上恢复工作室

准备 Git 和 Node.js，在 PowerShell 中运行：

```powershell
git clone --recurse-submodules https://github.com/we58117762/video-studio.git VideoStudio-Leo
cd VideoStudio-Leo
.\restore-studio.ps1
```

脚本恢复四个上游仓库的锁定版本、工作室内的技能目录链接和本地 2D 模板。然后以这个目录为项目根目录打开 Codex。

## 声音工具

三个声音技能来自 [sxhzju/sound](https://github.com/sxhzju/sound)，源码在 `.agents/skills`。在新电脑上可用 Python 3.12 创建本地环境：

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r .agents/skills/procedural-audio/requirements.txt curl_cffi
```

将 Windows 版的 `ffmpeg.exe` 和 `ffprobe.exe` 放入 `tools/ffmpeg/bin/`。可从 [FFmpeg 下载页](https://ffmpeg.org/download.html) 选择 Windows 构建。可选乐器和采样库的配置见 [声音技能安装指南](.agents/skills/procedural-audio/references/setup.md)。

工作室的目录和工具用法见 [AGENTS.md](AGENTS.md)。
