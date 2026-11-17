# Warcraft I: Remastered - Polish Translation Installer (Inno Setup)

Source script for the automated installer of the Polish localization (`Spolszczenie PL`) for **Warcraft I: Remastered**.

## What the installer does
1. Automatically detects the **Warcraft I: Remastered** installation folder via Windows Registry or drive scanning (`Warcraft.exe`).
2. Creates `.bak` backup copies of the 3 original English files (`BLQ55.ttf`, `NotoSans-Regular.ttf`, `enUS.json`).
3. Copies the modified Polish font and localization files into the `data` directory.
4. Creates an uninstaller shortcut (`Usunięcie spolszczenia`) in the main game folder that restores the original `.bak` files upon removal.

## How to build the executable
1. Download and install [Inno Setup 6](https://jrsoftware.org).
2. Open the `.iss` script file from this repository in **Inno Setup Compiler**.
3. Update the `Source:` path under `[Files]` to point to the `data` folder from the manual mod release.
4. Press `F9` (**Build -> Compile**) to generate `Warcraft_I_Remastered_Spolszczenie_v1.0.exe`.
# warcraft1-remastered-spolszczenie-installer
Inno Setup source script for Warcraft I: Remastered Polish translation installer
