DXXRebirth for MiSTer
=====================

Descent and Descent II on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/DXXRebirth_MiSTer

Game files
  Copy everything in the folder of your Descent, of your Descent II, or of
  both into this folder, /media/fat/games/dnk/DXXRebirth/, all the files
  as they are:
    Descent           descent.hog, descent.pig (full game or shareware)
    Descent II        descent2.hog, descent2.ham, descent2.s11,
                      descent2.s22, alien1.pig, alien2.pig, fire.pig,
                      groupa.pig, ice.pig, water.pig; the movies
                      intro-l.mvl, other-l.mvl, robots-l.mvl
    Descent II demo   d2demo.hog, d2demo.ham, d2demo.pig
  Missions go into descent/missions/ and descent2/missions/ there.
  They can go on a USB drive instead, in /media/usb0/games/dnk/DXXRebirth/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the game from the Other menu, e.g. dnk-Descent, or from the
     Hybrid Ports folder if you moved the games there in the launcher.
  Buttons are changed in the OSD under "Define DXXRebirth buttons". A
  button left without a name there does not reach the game at all: name
  every button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/DXXRebirth_MiSTer/issues

Credits and licenses
  DXX-Rebirth by Kp, Christian Beckhauser and the DXX-Rebirth
  contributors, from the Descent source code by Parallax Software: the
  Parallax license and GPL-3.0 (LICENSE-dxxrebirth.txt,
  LICENSE-dxxrebirth-gpl3.txt). PhysicsFS: zlib (LICENSE-physfs.txt).
  SDL_image: zlib (LICENSE-sdl_image.txt). SDL_mixer: zlib
  (LICENSE-sdl_mixer.txt). libADLMIDI by Vitaly Novichkov and Joel
  Yliluoma: LGPL-3.0 (LICENSE-libadlmidi.txt). GeneralUser GS by S.
  Christian Collins, the SoundFont of the core's MIDI synthesizer
  (games/dnk/SoundFonts/GeneralUser-GS-LICENSE.txt). SDL by Sam Lantinga
  and contributors: zlib (LICENSE-sdl.txt). MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/DXXRebirth_MiSTer

Support the project: https://www.patreon.com/itsdanik
