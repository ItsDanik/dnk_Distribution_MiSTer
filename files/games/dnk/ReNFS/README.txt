ReNFS for MiSTer
================

Need for Speed SE on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/ReNFS_MiSTer

Game files
  Copy everything on the game's CD (The Need for Speed Special Edition),
  all its files and folders as they are, into the folder NFSSE here,
  /media/fat/games/dnk/ReNFS/NFSSE/, so that there is
  games/dnk/ReNFS/NFSSE/NFS_DOS.EXE, games/dnk/ReNFS/NFSSE/FRONTEND/ and
  so on. Upper or lower case does not matter.
  They can go on a USB drive instead, in /media/usb0/games/dnk/ReNFS/NFSSE/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Need for Speed SE.
  Buttons are changed in the OSD under "Define ReNFS buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/ReNFS_MiSTer/issues

Credits and licenses
  The Need for Speed SE by Electronic Arts Canada. ReNFS, its program
  written again: GPL-3.0 (LICENSE-renfs.txt). SDL by Sam Lantinga and
  contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/ReNFS_MiSTer

Support the project: https://www.patreon.com/itsdanik
