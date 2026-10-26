EDuke32 for MiSTer
==================

Duke Nukem 3D and its add-ons Duke It Out in D.C., Life's a Beach,
Nuclear Winter, Duke!ZONE II and Penthouse Paradise on MiSTer FPGA as a
hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/EDuke32_MiSTer

Game files
  Copy everything in your game's folder (the one with DUKE3D.GRP) into this
  folder, /media/fat/games/dnk/EDuke32/, all the files as they are:
    Duke Nukem 3D               DUKE3D.GRP (1.3D, Atomic Edition or
                                shareware)
    Duke It Out in D.C.         DUKEDC.GRP, next to DUKE3D.GRP or in
                                addons/dc
    Life's a Beach              VACATION.GRP, next to DUKE3D.GRP or in
                                addons/vacation
    Nuclear Winter              NWINTER.GRP, next to DUKE3D.GRP or in
                                addons/nw
    Duke!ZONE II                DUKEZONE2.GRP (Raze's release) or the GRP
                                of its CD, next to DUKE3D.GRP
    Penthouse Paradise          PENTHOUS.ZIP, not unpacked, or the GRP of
                                ZOOM Platform's release, next to DUKE3D.GRP
  They can go on a USB drive instead, in /media/usb0/games/dnk/EDuke32/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Duke Nukem 3D, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define EDuke32 buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/EDuke32_MiSTer/issues

Credits and licenses
  EDuke32 by Richard "TerminX" Gobeille, Evan "Hendricks266" Ramos and
  contributors: GPL-2.0 (LICENSE-eduke32.txt); the Build engine in it by
  Ken Silverman: Build license (BUILDLIC.TXT). GeneralUser GS by
  S. Christian Collins, the SoundFont of the core's MIDI synthesizer
  (games/dnk/SoundFonts/, GeneralUser-GS-LICENSE.txt). SDL by Sam Lantinga
  and contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/EDuke32_MiSTer

Support the project: https://www.patreon.com/itsdanik
