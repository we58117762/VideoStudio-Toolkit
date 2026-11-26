# VideoStudio-Toolkit

VideoStudio 的制作工具仓库。包含三个声音技能、Vibe Motion 动效技能合集、2D 和 3D 脚手架，以及字幕成片工作流。

工作室入口是 [VideoStudio](https://github.com/we58117762/VideoStudio)（私有仓库，需相应访问权限）。在那里发起新项目，由 `project-init` 建立独立项目仓库；实际制作在项目仓库中开展，按需使用这里的工具。主仓库、工具库与项目仓库可以在本地工作空间中平级存放，通过 README 关联。

## 在 Mac 上按需使用

在选定的工作空间中克隆本仓库；已有副本则继续使用：

```sh
git clone https://github.com/we58117762/VideoStudio-Toolkit.git
```

从项目目录开展制作时，让 AI 先读取本仓库的 [AGENTS.md](AGENTS.md)，再根据实际任务读取所需 Skill：

- 声音：`.agents/skills/audio-mixing/SKILL.md`、`.agents/skills/procedural-audio/SKILL.md`、`.agents/skills/sfx-sources/SKILL.md`。
- 动效：先看 [技能索引](vibe-motion/skills/README.md)，再读取 `vibe-motion/skills/<技能名>/SKILL.md`。
- 2D / 3D 工程：需要代码制作视频时，再读取下方对应脚手架的 README。

Mac 使用本机对应架构的 Python、Node.js、FFmpeg 等工具，按选中的任务检查和补齐依赖。`restore-studio.ps1` 和 `runtime-win-x64/` 专用于 Windows x64，不在 Mac 上运行。声音插件与采样库按 [声音技能安装指南](.agents/skills/procedural-audio/references/setup.md) 配置。

Skill 原文中可能使用 `.claude/skills/...` 或 Windows 路径；AI 应根据实际源码位置和本机环境调整调用路径，将工作文件与输出保存在视频项目中。普通克隆不会自动注册全部 Skill，也不代表工具已经在本机验证可用。

音乐视频按具体创意选择工具。`auto-motion` 当前是 Codex 调度 Claude Code 的字幕动效流程，默认产出无音轨的 1080×1440 视频；它不是音乐视频的默认起点。

## 在 Windows 上恢复工作室

在装有 Git 的 Windows x64 电脑上，用 PowerShell 运行：

```powershell
git clone https://github.com/we58117762/VideoStudio-Toolkit.git
cd VideoStudio-Toolkit
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

三个声音技能来自 [sxhzju/sound](https://github.com/sxhzju/sound)，源码在 `.agents/skills`。Windows 恢复后可使用随仓库恢复的 Python：

```powershell
.\tools\python\python.exe .\.agents\skills\procedural-audio\scripts\audio_kit.py doctor
```

运行包分卷位于 `runtime-win-x64/`，恢复后 FFmpeg 与 FFprobe 位于 `tools/ffmpeg/bin/`。联网素材检索需要访问相应网站。新建动效工程首次渲染按项目说明安装依赖和浏览器。可选乐器和采样库的配置见 [声音技能安装指南](.agents/skills/procedural-audio/references/setup.md)。Codex 与 Claude Code 使用者在各自电脑登录。

工具库的目录和调用约定见 [AGENTS.md](AGENTS.md)，新项目入口见 [VideoStudio README](https://github.com/we58117762/VideoStudio/blob/main/README.md)。
