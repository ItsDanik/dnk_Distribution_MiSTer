YQuake2 for MiSTer
==================

Quake II on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/YQuake2_MiSTer

Game files
  Copy everything in your game's folders into this folder,
  /media/fat/games/dnk/YQuake2/, all the files as they are, next to the
  game.so files that are already in its folders:
    baseq2/          Quake II: everything in its baseq2 folder (a CD
                     version needs the 3.20 patch; the demo works too)
    baseq2/music/    the soundtrack, optional: 02.ogg to 11.ogg (GOG's
                     music/ folder goes next to baseq2/ instead)
    xatrix/          The Reckoning, optional: everything in its folder
    rogue/           Ground Zero, optional: everything in its folder
  They can go on a USB drive instead, in /media/usb0/games/dnk/YQuake2/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Quake II.
  Buttons are changed in the OSD under "Define YQuake2 buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/YQuake2_MiSTer/issues

Credits and licenses
  Yamagi Quake II by Yamagi Burmeister and contributors, on Quake II by id
  Software, and the mission pack code of yquake2/xatrix and yquake2/rogue:
  GPL-2.0 (LICENSE-yquake2.txt, LICENSE-xatrix.txt, LICENSE-rogue.txt).
  SDL by Sam Lantinga and contributors: zlib (LICENSE-sdl.txt). MiSTer by
  Sorgelig and the MiSTer-devel contributors. Inspired by MiSTer Frontier
  by MiSTer Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA
  core: GPL-2.0. Source: https://github.com/ItsDanik/YQuake2_MiSTer

Support the project: https://www.patreon.com/itsdanik
