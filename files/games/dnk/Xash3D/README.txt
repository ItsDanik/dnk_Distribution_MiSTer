Xash3D for MiSTer
=================

Half-Life and its expansions Opposing Force and Blue Shift on MiSTer FPGA
as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/Xash3D_MiSTer

Game files
  Copy each game's whole folder, with everything in it, into this folder,
  /media/fat/games/dnk/Xash3D/, over the folders that are there (they only
  hold the port's code for each game):
    Half-Life             valve
    HL: Opposing Force    gearbox, next to valve
    HL: Blue Shift        bshift, next to valve
  They can go on a USB drive instead, in /media/usb0/games/dnk/Xash3D/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Half-Life, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define Xash3D buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/Xash3D_MiSTer/issues

Credits and licenses
  Xash3D FWGS by Uncle Mike and the FWGS team: GPL-3.0 (LICENSE-gpl3.txt).
  hlsdk-portable by the FWGS team, after Valve's Half-Life SDK: Valve's
  Half-Life SDK license (LICENSE-hlsdk.txt). Half-Life by Valve; Opposing
  Force and Blue Shift by Gearbox Software. SDL by Sam Lantinga and
  contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/Xash3D_MiSTer

Support the project: https://www.patreon.com/itsdanik
