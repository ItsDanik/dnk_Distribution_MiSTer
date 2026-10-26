CrispyDoom for MiSTer
=====================

Doom, Doom II, Final Doom, their expansions, Heretic, Hexen and Strife on
MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/CrispyDoom_MiSTer

Game files
  Copy everything in your games' folders into this folder,
  /media/fat/games/dnk/CrispyDoom/, all the files as they are:
    Doom, The Ultimate Doom     DOOM.WAD
    Doom shareware              DOOM1.WAD
    SIGIL                       SIGIL_v1_21.wad (or another SIGIL WAD) and
                                The Ultimate Doom's DOOM.WAD
    SIGIL II                    SIGIL_II_V1_0.WAD (or SIGIL_II_MP3_V1_0.WAD)
                                and The Ultimate Doom's DOOM.WAD
    Doom II                     DOOM2.WAD
    No Rest for the Living      NERVE.WAD and DOOM2.WAD
    Master Levels               MASTERLEVELS.WAD (or the 20 WADs of the CD)
                                and DOOM2.WAD
    TNT: Evilution              TNT.WAD (and TNT31.WAD, if you have it)
    The Plutonia Experiment     PLUTONIA.WAD
    Heretic                     HERETIC.WAD (shareware: HERETIC1.WAD)
    Hexen                       HEXEN.WAD
    Deathkings                  HEXDD.WAD and the HEXEN.WAD of Hexen 1.1
    Strife                      STRIFE1.WAD and VOICES.WAD
                                (shareware: STRIFE0.WAD)
  They can go on a USB drive instead, in /media/usb0/games/dnk/CrispyDoom/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Doom, or from the Hybrid
     Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define CrispyDoom buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/CrispyDoom_MiSTer/issues

Credits and licenses
  Crispy Doom (and Crispy Heretic, Hexen and Strife) by Fabian Greffrath
  and contributors, based on Chocolate Doom by Simon Howard and
  contributors: GPL-2.0-or-later (LICENSE-crispydoom.txt). GeneralUser GS
  by S. Christian Collins, the SoundFont of the core's MIDI synthesizer
  (games/dnk/SoundFonts/, GeneralUser-GS-LICENSE.txt). SDL by Sam Lantinga
  and contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/CrispyDoom_MiSTer

Support the project: https://www.patreon.com/itsdanik
