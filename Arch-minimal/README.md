<div align="center">
  <h1>ARCH LINUX MINIMAL</h1>
  <p align="center">       
        There’s more behind the code. Explore my ideas, experiments, and thoughts on the <a href="https://use-root.github.io/zeroot.github.io/"><b>BLOG</b></a>
  </p>
<ul>
</div>
</ul>

## Statusline

[<kbd> <br> Install <br> </kbd>](#-installation)

|                                                                                   |                                                                                   |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| <img src="./Images/bspwm/environment.png" alt="dark" style="border-radius:15%"/>  | <img src="./Images/bspwm/environment2.png" alt="dark" style="border-radius:15%"/> |
| <img src="./Images/bspwm/environment3.png" alt="dark" style="border-radius:15%"/> | <img src="./Images/bspwm/environmentw.png" alt="dark" style="border-radius:15%"/> |

This is my workflow for develoment and hacking. <br>

## Features

- Base minimal: `bspwm`, `sxhkd`, Xorg y `startx`.
- Work-Tools: Alacritty, Neovim y Obsidian.
- Machines: KVM (Kernel-based Virtual Machine) and Virt-Manager
- Themes 31:
  - Additional themes on nvim and Alacritty

## Neovim Setup

Note: **This configuration is constantly updated**

**State Now:**
---------------------------------------------------------

`Total plugins: 9`
<details>
<summary>Summary</summary>

- markdown Package's:
  - Lazy (Plugins)
  - Mason (Linters,Formatters...)
    - JavaScript
    - TypeScript
    - HTML
    - CSS
    - JSON
    - Python
    - C
    - C++
    - Java
- LSP:
  - Mason-LSP
  - LSP
- Formater:
  - Conform
- Movement
  - Telescope
- Style
  - Emmet
  - Statusline

</details>

---

PHILOSOPHY
---------------------------------------------------------

```bash

󰈸 ~ ❯ cat ide_minimal_conf.txt | rg -Ue "^Summary:[\n+\w\-:\s()]+\n$"

Summary:

Included:
- LSP
- Formatter conform
- Telescope
- Emmet
- Mason
- Statusline personalizada
- Transparencia

Not included:
- Autocomplete (nvim-cmp)
- Snippets
- Lateral Menu
- Dashboard
- Git UI
- DAP (debugger)
```

## Quick Keybindigs

# Instalation

> [!CAUTION]
> ⚠️⚠️⚠️ My dotfiles are designed for a **** resolution with **96 DPI** on a single monitor.
> Some elements may appear different on higher or lower resolutions. You may need to make adjustments to adapt them to your preferences and setup. ⚠️⚠️⚠️

> [!important]
> ✏️✏️✏️ The installer assumes you already have a **functional** Arch Linux installation, whether it’s a fresh install or an existing setup.
>
> A login manager of your choice is required; **lightdm** is recommended.
>
> The rofi connection manager applet, works with **NetworkManager**
>
> If using a virtual machine, be sure to change the Picom backend from **glx** to **xrender** before rebooting, and verify that hardware acceleration is correctly configured in your VM. ✏️✏️✏️

> [!warning]
> :wrench::wrench::wrench: I have tested the installation and functionality of these dotfiles on both high- and low-end machines.
>
> Some adjustments may still be needed, such as changing the Picom backend or VSync settings to ensure compatibility with your graphics card.
>
> If you encounter any issues, feel free to open an [issue](https://github.com/gh0stzk/dotfiles/issues). :wrench::wrench::wrench:

---

## 💾 Installation:

> Works for **ARCH** Linux, and based distros!

- Open a terminal and execute this commands one by one:

```sh
# Download the installer in your $HOME
curl -LO http://gh0stzk.github.io/dotfiles/RiceInstaller

# Give it execution permission
chmod +x arch-minimal.sh

# Run the installer
./arch-minimal.sh
```

# Rerences:

- [madnight:](https://madnight.github.io/bspwm/)
- [gh0stzk:](https://github.com/gh0stzk/dotfiles/)
- [baskerville:](https://github.com/baskerville/bspwm)
