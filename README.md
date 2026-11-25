# VideoStudio-Leo

视频工作室的项目根目录。包含三个声音技能、Vibe Motion 动效技能合集、2D 和 3D 脚手架，以及字幕成片工作流。

## 在 Windows 上恢复工作室

在装有 Git 的 Windows x64 电脑上，用 PowerShell 运行：

```powershell
git clone https://github.com/we58117762/video-studio.git VideoStudio-Leo
cd VideoStudio-Leo
.\restore-studio.ps1
```

一次普通克隆即可取得四个动效项目的全部版本化文件。恢复脚本校验仓库内的运行包，解压 Python 3.12.14、声音依赖、Node.js 24.22.3、pnpm 11.25.0、FFmpeg 及 FFprobe，然后创建技能目录链接并准备本地 2D 模板。克隆完成后，恢复过程可离线运行。以这个目录为项目根目录打开 Codex 即可使用。

## 动效项目来源

| 本仓库目录 | 收录时的上游版本 |
| --- | --- |
| [vibe-motion/create-vibe-motion](vibe-motion/create-vibe-motion) | [2657ae9](https://github.com/vibe-motion/create-vibe-motion/commit/2657ae9abadb89714bdabf0d3aef210e60ce1223) |
| [vibe-motion/create-vibe-motion-3d](vibe-motion/create-vibe-motion-3d) | [b88aa99](https://github.com/vibe-motion/create-vibe-motion-3d/commit/b88aa9999ab37b6202b5d7370a91e85ded0e1919) |
| [vibe-motion/auto-motion](vibe-motion/auto-motion) | [17ead62](https://github.com/vibe-motion/auto-motion/commit/17ead629d010f7e5495f645d46fafd6876482c32) |
| [vibe-motion/skills](vibe-motion/skills) | [f558ec4](https://github.com/vibe-motion/skills/commit/f558ec411484b7b20893dff0a1d4408dd386044c) |

## 声音工具

三个声音技能来自 [sxhzju/sound](https://github.com/sxhzju/sound)，源码在 `.agents/skills`。可直接使用随仓库恢复的 Python：

```powershell
.\tools\python\python.exe .\.agents\skills\procedural-audio\scripts\audio_kit.py doctor
```

运行包分卷位于 `runtime-win-x64/`，恢复后 FFmpeg 与 FFprobe 位于 `tools/ffmpeg/bin/`。联网素材检索需要访问相应网站。新建动效工程首次渲染按项目说明安装依赖和浏览器。可选乐器和采样库的配置见 [声音技能安装指南](.agents/skills/procedural-audio/references/setup.md)。Codex 与 Claude Code 使用者在各自电脑登录。

工作室的目录和工具用法见 [AGENTS.md](AGENTS.md)。
