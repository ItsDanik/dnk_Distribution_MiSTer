MIDIPlayer for MiSTer
=====================

MIDI Player on MiSTer FPGA as a hybrid port.

Everything about it (options, controls, help):
  https://github.com/ItsDanik/MIDIPlayer_MiSTer

Songs and SoundFonts
  Copy your MIDI files (.mid, .midi, .kar and Doom's .mus), in folders if
  you like, into this folder, /media/fat/games/dnk/MIDIPlayer/. The music
  of the installed hybrid ports' games is found by itself.
  Your own SoundFonts (.sf2) go into /media/fat/games/dnk/SoundFonts/.
  GeneralUser GS comes with the player.
  They can go on a USB drive instead, in /media/usb0/games/dnk/MIDIPlayer/
  and /media/usb0/games/dnk/SoundFonts/.

Playing
  1. Run danik_hybrid_ports once from the MiSTer's Scripts menu. It starts
     the game whenever its menu entry is loaded.
  2. Load the player from the Other menu: dnk-MIDI Player, or from the
     Hybrid Ports folder if you moved the hybrid ports there in the
     launcher.
  Buttons are changed in the OSD under "Define MIDIPlayer buttons". A button
  left without a name there does not reach the game at all: name every
  button, or leave the definition as it is.

If something is wrong
  Open the OSD while it happens and pick Save Diagnostic Report, the last
  line. Send the file it saves in games/dnk/diagnostics/ with a few words
  on what went wrong: https://github.com/ItsDanik/MIDIPlayer_MiSTer/issues

Credits and licenses
  MIDI Player: GPL-3.0 (LICENSE-gpl3.txt); its synthesizer is modelled on
  FluidSynth, its reverb is Freeverb by Jezar at Dreampoint. GeneralUser GS
  by S. Christian Collins (games/dnk/SoundFonts/GeneralUser-GS-LICENSE.txt).
  The Doom music titles are the Doom Wiki's. MiSTer by Sorgelig and the
  MiSTer-devel contributors. Inspired by MiSTer Frontier by MiSTer
  Organize. The launcher: GPL-3.0 (LICENSE-gpl3.txt); the FPGA core:
  GPL-2.0. Source: https://github.com/ItsDanik/MIDIPlayer_MiSTer

Support the project: https://www.patreon.com/itsdanik
