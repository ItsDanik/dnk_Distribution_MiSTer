TheForceEngine for MiSTer
=========================

Dark Forces on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/TheForceEngine_MiSTer

Game files
  Copy everything in your game's folder into this folder,
  /media/fat/games/dnk/TheForceEngine/, all the files as they are:
    Dark Forces for DOS: the folder with DARK.GOB, SOUNDS.GOB, SPRITES.GOB,
    TEXTURES.GOB and the folder LFD.
  They can go on a USB drive instead, in
  /media/usb0/games/dnk/TheForceEngine/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Dark Forces, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define TheForceEngine buttons". A
  button left without a name there does not reach the game at all: name
  every button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong:
  https://github.com/ItsDanik/TheForceEngine_MiSTer/issues

Credits and licenses
  The Force Engine by luciusDXL and contributors: GPL-2.0
  (LICENSE-theforceengine.txt). Dark Forces by LucasArts. SDL by Sam
  Lantinga and contributors: zlib (LICENSE-sdl.txt). GeneralUser GS by S.
  Christian Collins, the SoundFont of the core's MIDI synthesizer
  (games/dnk/SoundFonts/GeneralUser-GS-LICENSE.txt). MiSTer by Sorgelig
  and the MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/TheForceEngine_MiSTer

Support the project: https://www.patreon.com/itsdanik
