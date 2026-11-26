# VideoStudio-Toolkit

这里是制作工具仓库。工作室入口为 [VideoStudio](https://github.com/we58117762/VideoStudio)（私有，需访问权限）；新项目从主仓库的 `project-init` 发起，正式制作在独立项目仓库中进行。以下源码路径均相对于 Toolkit 根目录。

## 从项目调用

- 先确认当前视频项目目录及 Toolkit 的真实本地位置。平级布局下，Toolkit 通常是项目旁的 `../VideoStudio-Toolkit`；路径不符时查找已有位置，避免重复克隆。
- 按任务读取所选 `SKILL.md` 及其引用的必要资源。声音源码在 `.agents/skills/<技能名>/`；动效源码在 `vibe-motion/skills/<技能名>/`，索引为 `vibe-motion/skills/README.md`。读取指令文件即可开始判断适用性，不要求预先安装全部 Skill。
- 将原文中的 `.claude/skills/...`、相对脚本路径和 Windows 示例适配到真实源码位置与操作系统。调用脚本前确认工作目录和输出参数；把项目文件、下载素材、渲染产物及项目依赖留在当前项目中。
- 按实际需要使用 2D / 3D 脚手架。项目专属修改放在项目中；维护 Toolkit 本身时再修改公共源码。
- `auto-motion` 当前调用 Claude Code，使用 Bash / `jq`，默认生成 1080×1440、30 fps、无音轨视频。采用前先判断是否符合项目需求，不将它视为默认 MV 流程或现成 Gemini 调度方案。

## Mac 环境

不要在 Mac 上执行 `restore-studio.ps1`，也不要使用 `runtime-win-x64/` 内的 Windows 二进制。按所选 Skill 检查本机原生工具和依赖；只配置当前任务需要的部分。音乐视频立项本身不要求安装渲染器、音频插件或采样库。

声音能力的虚拟环境、插件、采样库和架构匹配说明见 `.agents/skills/procedural-audio/references/setup.md`。其中 `.claude/skills/...` 是示例路径，调用时使用已确认的 Toolkit 源码路径。本机实际运行成功前，不宣称对应工具已经可用。

## Windows 声音工具

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

三个声音技能的源码位于 `.agents/skills`。在 Windows 上执行恢复脚本后，动效条目会通过目录链接加入 `.agents/skills`，`.claude/skills` 也会指向同一目录；此时作者示例中的技能相对路径可以使用。普通克隆以及 Mac 环境不预设这些链接存在。
