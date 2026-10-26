ChocolateQuake for MiSTer
=========================

Quake and its mission packs on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/ChocolateQuake_MiSTer

Game files
  Copy everything in your game's folder into this folder,
  /media/fat/games/dnk/ChocolateQuake/, all the files as they are:
    Quake                     id1 (pak0.pak and pak1.pak)
    Quake shareware           id1 (pak0.pak alone)
    Scourge of Armagon        hipnotic, next to the full game's id1
    Dissolution of Eternity   rogue, next to the full game's id1
  From Steam or GOG (the 2021 re-release): the folders of the install
  folder itself (Quake/id1, and hipnotic and rogue where it has them), not
  those in its rerelease folder, which do not run here.
  They can go on a USB drive instead, in
  /media/usb0/games/dnk/ChocolateQuake/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Quake, or from the Hybrid
     Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define ChocolateQuake buttons". A
  button left without a name there does not reach the game at all: name
  every button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong:
  https://github.com/ItsDanik/ChocolateQuake_MiSTer/issues

Credits and licenses
  Chocolate Quake by Henrique Barateli and contributors, based on the
  Quake source by id Software: GPL-2.0-or-later
  (LICENSE-chocolatequake.txt). SDL by Sam Lantinga and contributors: zlib
  (LICENSE-sdl.txt). MiSTer by Sorgelig and the MiSTer-devel contributors.
  Inspired by MiSTer Frontier by MiSTer Organize. The launcher: GPL-3.0
  (LICENSE-gpl3.txt); the FPGA core: GPL-2.0. Source:
  https://github.com/ItsDanik/ChocolateQuake_MiSTer

Support the project: https://www.patreon.com/itsdanik
