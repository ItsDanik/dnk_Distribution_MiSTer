jfSW for MiSTer
===============

Shadow Warrior and its addons Wanton Destruction and Twin Dragon on MiSTer
FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/jfSW_MiSTer

Game files
  Copy everything in your game's folder (the one with SW.GRP) into this
  folder, /media/fat/games/dnk/jfSW/, with its folders as they are:
    Shadow Warrior        SW.GRP (full game or shareware)
    The music             Track02.ogg to Track14.ogg, the audio of the
                          game's CD, there or in a folder music
    Wanton Destruction    WT.GRP, there or in a folder addons
    Twin Dragon           TD.GRP, there or in a folder addons
  The whole folder of Shadow Warrior Classic Redux can be copied as it is.
  They can go on a USB drive instead, in /media/usb0/games/dnk/jfSW/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Shadow Warrior, or from
     the Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define jfSW buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/jfSW_MiSTer/issues

Credits and licenses
  JFShadowWarrior, JFBuild, JFAudioLib and JFMACT by Jonathon Fowler and
  contributors, from the Shadow Warrior source code by 3D Realms:
  GPL-2.0-or-later (LICENSE-jfsw.txt). The Build engine by Ken Silverman:
  the Build license (BUILDLIC.TXT). libogg and libvorbis by the Xiph.Org
  Foundation: BSD (LICENSE-vorbis.txt). GeneralUser GS by S. Christian
  Collins, the SoundFont of the core's MIDI synthesizer
  (games/dnk/SoundFonts/GeneralUser-GS-LICENSE.txt). SDL by Sam Lantinga
  and contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/jfSW_MiSTer

Support the project: https://www.patreon.com/itsdanik
