> **Language Note / Uwaga językowa:** This document contains the exact same documentation in two languages: **English** (below) and **Polish** (further down). / Ten dokument zawiera dokładnie tę samą dokumentację w dwóch językach: **angielskim** (poniżej) oraz **polskim** (niżej).

---

# [ENGLISH VERSION] Warcraft I: Remastered - Polish Translation Installer (Inno Setup)

Source script for the automated installer of the Polish localization (`Spolszczenie PL`) for **Warcraft I: Remastered**.

## What the installer does
1. Automatically detects the **Warcraft I: Remastered** installation folder via Windows Registry or drive scanning (`Warcraft.exe`).
2. Creates `.bak` backup copies of the 3 original English files (`BLQ55.ttf`, `NotoSans-Regular.ttf`, `enUS.json`).
3. Copies the modified Polish font and localization files into the `data` directory.
4. Creates an uninstaller shortcut (`Usunięcie spolszczenia` / *Remove Polish Translation*) in the main game folder that restores the original `.bak` files upon removal.

## How to build the executable
1. Download and install [Inno Setup 6](https://jrsoftware.org) (or newer, e.g. Inno Setup 7).
2. Open the `InstalatorSpolszczenieWarcraftIRemaster.iss` script file from this repository in **Inno Setup Compiler**.
3. Update the `Source:` path under `[Files]` to point to the `data` folder from the manual mod release.
4. Press `F9` (**Build -> Compile**) to generate `Warcraft_I_Remastered_Spolszczenie_v1.0.exe`.

---

# [POLISH VERSION / WERSJA POLSKA] Warcraft I: Remastered - Instalator Spolszczenia (Inno Setup)

*(To jest dokładne tłumaczenie powyższej dokumentacji angielskiej na język polski / Exact Polish translation of the English documentation above.)*

Skrypt źródłowy automatycznego instalatora polskiej wersji językowej (`Spolszczenie PL`) do gry **Warcraft I: Remastered**.

## Co robi instalator
1. Automatycznie wykrywa folder instalacyjny **Warcraft I: Remastered** w rejestrze systemu Windows lub poprzez skanowanie dysków w poszukiwaniu pliku `Warcraft.exe`.
2. Tworzy kopie zapasowe `.bak` 3 oryginalnych plików angielskich (`BLQ55.ttf`, `NotoSans-Regular.ttf`, `enUS.json`).
3. Kopiuje zmodyfikowane polskie czcionki oraz plik lokalizacyjny do folderu `data`.
4. Tworzy w głównym katalogu gry skrót deinstalatora (`Usunięcie spolszczenia`), który po uruchomieniu przywraca oryginalne pliki z kopii `.bak`.

## Jak skompilować plik wykonywalny (.exe)
1. Pobierz i zainstaluj program [Inno Setup 6](https://jrsoftware.org) (lub nowszy, np. Inno Setup 7).
2. Otwórz plik `InstalatorSpolszczenieWarcraftIRemaster.iss` z tego repozytorium w programie **Inno Setup Compiler**.
3. Zaktualizuj ścieżkę `Source:` w sekcji `[Files]`, wskazując na folder `data` z manualnej paczki spolszczenia.
4. Naciśnij klawisz `F9` (**Build -> Compile**), aby wygenerować gotowy plik `Warcraft_I_Remastered_Spolszczenie_v1.0.exe`.
