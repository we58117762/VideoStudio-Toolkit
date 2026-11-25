# VideoStudio-Leo

这个目录是视频工作室的项目根目录。以下路径均相对于这里。

## 声音工具

声音技能使用工作室独立的 Python。PowerShell 中可以直接运行：

```powershell
.\tools\python\python.exe .\.agents\skills\procedural-audio\scripts\audio_kit.py doctor
.\tools\python\python.exe .\.agents\skills\sfx-sources\scripts\sfx.py --help
```

混音和媒体检查使用 `tools/ffmpeg/bin/ffmpeg.exe` 和 `tools/ffmpeg/bin/ffprobe.exe`。需要在当前 PowerShell 会话中按命令名调用工具时，先在工作室根目录运行：

```powershell
$env:Path = "$PWD\tools\python;$PWD\tools\node\bin;$PWD\tools\ffmpeg\bin;$env:Path"
```

Surge XT、sfizz 和采样乐器的配置见 `.agents/skills/procedural-audio/references/setup.md`。基础扫频、低频冲击声和混音可直接在本地运行。

## 动效项目

| 目录 | 用途 |
| --- | --- |
| `vibe-motion/create-vibe-motion` | Remotion 二维动画项目脚手架 |
| `vibe-motion/create-vibe-motion-3d` | Three.js 三维动画项目脚手架 |
| `vibe-motion/auto-motion` | 将 SRT 字幕拆成动画镜头，再拼接成片 |
| `vibe-motion/skills` | 动效合集的源码与演示 |

Codex 的项目技能位于 `.agents/skills`。动效条目链接到合集源码，声音技能安装在该目录下。`.claude/skills` 指向同一目录，作者示例中的相对路径可直接使用。
