NBlood for MiSTer
=================

Blood, Cryptic Passage, Redneck Rampage, Redneck Rampage: Rides Again and
PowerSlave on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/NBlood_MiSTer

Game files
  Copy everything in each game's folder into a folder of its own in this
  folder, /media/fat/games/dnk/NBloodD/, all the files as they are:
    Blood                       Blood/: version 1.21, BLOOD.RFF, GUI.RFF,
                                SOUNDS.RFF, SURFACE.DAT, TILES0*.ART,
                                VOXEL.DAT
    Blood: Cryptic Passage      Blood/, with Blood: also CRYPTIC.INI, CP0*.MAP
    Redneck Rampage             Redneck/: REDNECK.GRP of 141,174,222 bytes
    Redneck Rampage: Rides      Redneck/: its GRP of 191,798,609 bytes,
    Again                       whatever its name (rename it RA.GRP if it is
                                REDNECK.GRP too)
    PowerSlave (Exhumed)        PowerSlave/: STUFF.DAT (the DOS game or its
                                demo)
  They can go on a USB drive instead, in /media/usb0/games/dnk/NBloodD/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Blood, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define NBloodD buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/NBlood_MiSTer/issues

Credits and licenses
  NBlood by Nuke.YKT and its contributors: GPL-2.0
  (LICENSE-nblood.txt); the Build engine by Ken Silverman: its own licence
  (LICENSE-build.txt). GeneralUser GS by S. Christian Collins: its licence
  in games/dnk/SoundFonts/. SDL by Sam Lantinga and contributors: zlib
  (LICENSE-sdl.txt). MiSTer by Sorgelig and the MiSTer-devel contributors.
  Inspired by MiSTer Frontier by MiSTer Organize. The launcher: GPL-3.0
  (LICENSE-gpl3.txt); the FPGA core: GPL-2.0. Source:
  https://github.com/ItsDanik/NBlood_MiSTer

Support the project: https://www.patreon.com/itsdanik
