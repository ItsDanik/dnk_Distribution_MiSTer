ScummVM for MiSTer
==================

ScummVM on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/ScummVM_MiSTer

Game files
  Copy each game's folder, whole and as it is, into a folder of its own
  in this folder, /media/fat/games/dnk/ScummVM/ (e.g.
  games/dnk/ScummVM/Monkey Island 2/). Then, in ScummVM's launcher, pick
  Add Game > Mass Add... and confirm this folder: ScummVM finds every game
  in it. Which games ScummVM plays and the files each needs:
  https://wiki.scummvm.org/index.php/Datafiles
  They can go on a USB drive instead, in /media/usb0/games/dnk/ScummVM/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-ScummVM, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define ScummVM buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/ScummVM_MiSTer/issues

Credits and licenses
  ScummVM by the ScummVM Team: GPL-3.0-or-later (LICENSE-scummvm.txt,
  COPYRIGHT-scummvm.txt, and LICENSES-scummvm/ for parts under others).
  The game icons of scummvm-icons by its authors: GPL-2.0
  (icons/LICENSE-icons.txt, icons/AUTHORS-icons.txt). The Cozette font
  by Samhain and contributors: MIT (in data/misterhybrid.zip).
  GeneralUser GS by S. Christian Collins, the SoundFont of the core's
  MIDI synthesizer (games/dnk/SoundFonts/, GeneralUser-GS-LICENSE.txt).
  SDL by Sam Lantinga and contributors: zlib (LICENSE-sdl.txt). MiSTer by
  Sorgelig and the MiSTer-devel contributors. Inspired by MiSTer Frontier
  by MiSTer Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA
  core: GPL-2.0. Source: https://github.com/ItsDanik/ScummVM_MiSTer

Support the project: https://www.patreon.com/itsdanik
