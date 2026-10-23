MIDIPlayer for MiSTer - MIDI Player as a hybrid port
====================================================

MIDI Player plays MIDI files, and the music in the games of the installed
hybrid ports, on the core's MIDI synthesizer with any SoundFont, or on an
MT32-pi when one is connected. It is also where the SoundFonts are chosen:
it sets the 8 slots of the SoundFont line that every hybrid port with MIDI
music has in its OSD. The program runs on the MiSTer's ARM CPU; the
MIDIPlayer FPGA core provides the synthesizer, native 15kHz video (CRT, VGA
and HDMI) at 640x480, audio and input.

Disclaimer: AI is being used to speed up development of this project.

Requirements
  - danik_hybrid_ports, the launcher that comes with this release
    (Scripts/danik_hybrid_ports.sh): run it ONCE from the MiSTer's Scripts
    menu. It starts the player whenever its menu entry is loaded, keeps
    running after a reboot, and serves all our hybrid ports; its screen
    picks which ports and games to have, and can keep them up to date
    through update_all. It replaces danik_hybrid_cores, the launcher before
    it, and moves ports installed the old way into the new folders by
    itself. Without it the core says "Game not running".
  - A SoundFont (.sf2) in /media/fat/games/dnk/SoundFonts/ for the
    synthesizer: GeneralUser GS (GeneralUser-GS.sf2, the default) comes
    with the player, its licence next to it, and your own .sf2 files can
    go in the same folder. Without one the player still starts, and can
    play on an MT32-pi.
  - Songs: your own MIDI files (below), or the music of the installed ports
    CrispyDoom (Doom, Doom II, Final Doom, Heretic, Hexen, Strife) and jfSW
    (Shadow Warrior), read from their games' files where they are.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick MIDI Player, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/MIDIPlayer/, Scripts/ and downloader_danik_hybrid_ports.ini
     (with which update_all keeps the ports up to date from then on).
  2. Copy your MIDI files, in folders if you like, to
       /media/fat/games/dnk/MIDIPlayer/
     .mid, .midi, .kar and Doom's .mus files are played.
  3. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  4. Load dnk-MIDI Player from the Other menu.
  The songs can go on a USB drive instead, into the same folder there
  (/media/usb0/games/dnk/MIDIPlayer/): the player looks there first, and
  then keeps its settings there as well. SoundFonts can be on a USB drive
  too (/media/usb0/games/dnk/SoundFonts/), whose folder then wins over the
  SD card's for every core.

The Player page
  On the left the songs: "My songs" first, then a folder for each game of
  the installed ports. Doom's music is named by map and title ("E1M1  At
  Doom's Gate"), Hexen's by map. On the right what plays: where it comes
  from, the time, where it plays and with which SoundFont, the play order,
  repeat, and the 16 channels with their instruments and levels. A channel
  can be muted (a click, or 1..0 on the keyboard) or soloed (a right-click,
  or Shift with 1..0). The song goes on while you move through other
  folders or the SoundFonts page.
  With an MT32-pi connected, P or a click on the "On:" line switches the
  music between the synthesizer and the MT32-pi. The MT32-pi's own
  settings are in the OSD.

The SoundFonts page
  On the left the 8 slots of the OSD line SoundFont (Default and 1 to 7),
  on the right the fonts of games/dnk/SoundFonts/ with their slots, size
  and number of presets. A font over 64 MB of samples, or a damaged one,
  cannot be chosen.
  - A on a font while music plays: the music goes on with that font, and
    the player keeps it as its own.
  - A on a font while nothing plays (stopped or paused): choose a slot for
    it on the left, and A puts it there. Or choose a slot first (Left /
    Right move between the lists) and press A: the font selected on the
    right goes in it. X clears a slot. A font can be in several slots.
  Every core reads the slots when its game loads a SoundFont, so a change
  reaches a game the next time it starts. They are stored in
  games/dnk/SoundFonts/slots.txt.

OSD options
  Aspect ratio, Scale, Scandoubler Fx, Stereo Mix as in other cores.
  FPS Counter   shows the pictures per second in the top left corner.
  HDMI Only     Yes if no CRT is connected: resolutions of 640x400 and
                more are then progressive instead of interlaced, and the
                analog output is switched off while one is shown, so that a
                15kHz screen can never get such a signal. Not needed with
                forced_scandoubler=1 (VGA monitor); not there with
                direct_video=1.
  CRT Options   for a 15kHz screen: Horizontal Pos and Vertical Pos fit the
                picture to it. HDMI is not affected. Not there with
                forced_scandoubler=1.
  MT32-pi       only there while an MT32-pi answers on the MiSTer's user
                port: its synth (SoundFont or MT-32), its MT-32 ROM, its
                SoundFont (Pi's own, or 0 to 7 of its card) and Reset
                Hanging Notes. Whether the music goes to it is the
                player's choice (P).
  Save Diagnostic Report   the last line: see "If something is wrong".

Controls
                          Pad              Keyboard              Mouse
  Move                    d-pad, stick     arrows, PgUp / PgDn,  wheel
                                           Home / End
  Select                                                         click
  Play / open             A                Enter                 double-click
  Back up a folder        B                Backspace             ".."
  Pause / play            A on the song    Space                 A button
                          playing
  Previous / next song    L / R            , / .                 buttons
  Repeat (off/one/all)    X                R                     button
  Shuffle                 Y                S                     button
  Go to the song playing  Start            G                     button
  Switch page             Select           Tab                   the tabs
  Synthesizer / MT32-pi                    P                     "On:" line
  Seek 5 s                                 Left / Right          progress bar
  Mute / solo a channel                    1..0, Shift+1..0      click /
                                                                 right-click
  The pad buttons by the default mapping: A is Xbox B / PlayStation
  Circle, B is Xbox A / PlayStation Cross, X is Xbox Y / PlayStation
  Triangle, Y is Xbox X / PlayStation Square, L and R are LB / L1 and
  RB / R1.
  The buttons of your MiSTer menu confirm and go back as well: its Menu OK
  / Menu Back if you set them in "Define joystick buttons", else its A / B.
  A controller never set up in MiSTer confirms and goes back as on its
  console: Cross / Circle on PlayStation, A / B on Xbox and on Nintendo.
  Change the buttons in the OSD under "Define MIDIPlayer buttons". While
  the OSD is open, the player gets no input.

Files
  games/dnk/MIDIPlayer/midiplayer.cfg   what the player remembers: the
      folder, the song selected, its SoundFont, play order, repeat, and
      synthesizer or MT32-pi
  games/dnk/SoundFonts/slots.txt        the OSD's SoundFont slots
  /media/fat/logs/dnk/MIDIPlayer/midiplayer.log   the player's log

If something is wrong
  If the sound breaks up or something else is wrong, open the OSD while it
  happens and pick Save Diagnostic Report, the last line of the menu. The
  player keeps running; MiSTer's info box says the report is saved in
  games/dnk/diagnostics/ on the SD card. Send that file
  (MIDIPlayer_<date>_<time>.zip) with a few words on what went wrong.
  The report has the setup (versions, the video and audio lines of
  MiSTer.ini, the OSD settings), how the last 60 seconds went, the log and
  a screenshot. Nothing else: no network settings, addresses, saved games
  or lists of your files.

Credits
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid cores on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.
  The synthesizer is modelled on FluidSynth; its reverb is Freeverb by
  Jezar at Dreampoint.
  GeneralUser GS by S. Christian Collins.
  The Doom music titles are the Doom Wiki's.

License
  MIDI Player and the launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0
  Source: https://github.com/ItsDanik/MIDIPlayer_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
