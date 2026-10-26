OpenScreamer for MiSTer
=======================

Screamer and Screamer 2 on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/openscreamer_MiSTer

Game files
  Copy everything in each game's folder (the one that holds DATA and GFX)
  into its folder here, /media/fat/games/dnk/OpenScreamer/, all the files
  and folders as they are:
    Screamer      screamer/   (screamer/DATA/GEN.DAT, screamer/GFX/...)
    Screamer 2    screamer2/  (screamer2/DATA/GEN.DAT, screamer2/ANIMS/...)
  Screamer 2's music is the CD's audio tracks, as screamer2/music/
  track_02.ogg .. track_09.ogg (.mp3 or .wav do as well).
  They can go on a USB drive instead, in the same folders under
  /media/usb0/games/dnk/OpenScreamer/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Screamer, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define OpenScreamer buttons". A
  button left without a name there does not reach the game at all: name
  every button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/openscreamer_MiSTer/issues

Credits and licenses
  Screamer and Screamer 2 by Graffiti, published by Virgin Interactive.
  OpenScreamer, the reimplementation: GPL-3.0 (LICENSE-openscreamer.txt).
  Nuked OPL3 by Nuke.YKT: LGPL-2.1-or-later (LICENSE-nuked-opl3.txt).
  stb_vorbis by Sean Barrett, dr_mp3 / dr_wav by David Reid. SDL by Sam
  Lantinga and contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig
  and the MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/openscreamer_MiSTer

Support the project: https://www.patreon.com/itsdanik
