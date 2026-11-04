OpenMotoRacer for MiSTer
========================

Moto Racer on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/OpenMotoRacer_MiSTer

Game files
  Copy your game's whole folder into this folder,
  /media/fat/games/dnk/OpenMotoRacer/, all the files as they are:
    Moto Racer/      GOG's copy, as installed: game.EXE, data, 02.wav to
                     13.wav (or the 1997 CD's files: DISK1, DATA, its .cue
                     and .bin)
    Moto Racer CD/   the 1997 CD's files, if you have GOG's as well
  With both there GOG's is played. Options, Game Behaviour in the game picks
  which program's ways the game follows, with either copy.
  They can go on a USB drive instead, in
  /media/usb0/games/dnk/OpenMotoRacer/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Moto Racer, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define OpenMotoRacer buttons". A
  button left without a name there does not reach the game at all: name
  every button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong:
  https://github.com/ItsDanik/OpenMotoRacer_MiSTer/issues

Credits and licenses
  OpenMotoRacer, written anew from the 1997 game by Delphine Software, by
  ItsDanik: GPL-3.0 (LICENSE-gpl3.txt). SDL by Sam Lantinga and
  contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors.
  Inspired by MiSTer Frontier by MiSTer Organize. The launcher: GPL-3.0
  (LICENSE-gpl3.txt); the FPGA core: GPL-2.0. Source:
  https://github.com/ItsDanik/OpenMotoRacer_MiSTer

Support the project: https://www.patreon.com/itsdanik
