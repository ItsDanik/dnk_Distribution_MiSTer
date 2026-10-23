DXXRebirth for MiSTer - Descent and Descent II as a hybrid port
================================================================

The games (DXX-Rebirth, the source port of the Descent and Descent II
engines, with its software renderer) run on the MiSTer's ARM CPU; the
DXXRebirth FPGA core provides native 15kHz video (CRT, VGA and HDMI) at
320x200 or 320x240, audio, the music on its FM chip or MIDI synthesizer,
and input with rumble.

Disclaimer: AI is being used to speed up development of this project.

Requirements
  - danik_hybrid_ports, the launcher that comes with this release
    (Scripts/danik_hybrid_ports.sh): run it ONCE from the MiSTer's Scripts
    menu. It starts the game whenever its menu entry is loaded, keeps
    running after a reboot, and serves all our hybrid ports; its screen
    picks which ports and games to have, and can keep them up to date
    through update_all. It replaces danik_hybrid_cores, the launcher before
    it, and moves ports installed the old way into the new folders by
    itself. Without it the core says "Game not running".
  - Game data. It is not included: your own copy of Descent and/or
    Descent II (the versions sold by GOG and Steam work), or the free
    shareware and demo versions. One of the two games is enough.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick the games, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/DXXRebirth/, games/dnk/SoundFonts/, Scripts/ and
     downloader_danik_hybrid_ports.ini (with which update_all keeps the
     ports up to date from then on).
  2. Copy the game data to /media/fat/games/dnk/DXXRebirth/: everything in
     the folder of your Descent, of your Descent II, or of both, into that
     one folder. Among the files are:
       Descent           descent.hog descent.pig
                         (the shareware version has the same file names)
       Descent II        descent2.hog descent2.ham descent2.s11
                         descent2.s22 alien1.pig alien2.pig fire.pig
                         groupa.pig ice.pig water.pig
                         the movies: intro-l.mvl other-l.mvl robots-l.mvl
       Descent II demo   d2demo.hog d2demo.ham d2demo.pig
     Of the Descent II movies the low resolution ones (-l.mvl) are the size
     of the screen; if only the high resolution ones (-h.mvl) are there,
     they are scaled down. Missions (.hog with .msn or .mn2) go into
     games/dnk/DXXRebirth/descent/missions/ (Descent) and
     descent2/missions/ (Descent II).
  3. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  4. Load dnk-Descent or dnk-Descent II from the Other menu.
  The game data can go on a USB drive instead, into the same folder there
  (/media/usb0/games/dnk/DXXRebirth/): the game looks for it there first,
  and then keeps its settings and saved games there as well. Everything
  else stays on the SD card.
  Loaded by itself (_Other/dnk/), the core shows a list of the games whose
  data is there. The data of the first versions of this port, in
  games/d1x-rebirth/ and games/d2x-rebirth/, is moved into the new folders
  by the launcher.

OSD options
  Aspect ratio, Scale, Scandoubler Fx, Stereo Mix as in other cores.
  FPS Counter   shows the pictures per second in the top left corner.
  HDMI Only     Yes if no CRT is connected: resolutions of 640x400 and
                more are then progressive instead of interlaced, and the
                analog output is switched off while one is shown, so that a
                15kHz screen can never get such a signal. Nothing changes
                at lower resolutions. Not needed with forced_scandoubler=1
                (VGA monitor); not there with direct_video=1.
  CRT Options   for a 15kHz screen: Horizontal Size, Horizontal Pos and
                Vertical Pos fit the picture to it. The pixels stay as they
                are; HDMI is not affected. The size is for the game's
                picture: the core's own, with its messages, keeps its
                width. Not there with forced_scandoubler=1. HUD (Top) and
                HUD (Bottom): in 320x240, how far the HUD is from the top
                and the bottom edge of the screen, to keep it out of a
                CRT's overscan.
  Sound Volume, Music Volume
                on top of the volumes in the game's own "Sound effects &
                music" options.
  Resolution    320x200, the games' own, or 320x240: the view fills all 240
                lines from edge to edge, with the cockpit, the status bar
                and the HUD drawn over it at the HUD margins. Menus,
                briefings and movies stay 320x200 in the middle.
  Music         MIDI: the music is played by an MT32-pi when one is
                connected and on, else by the core's MIDI synthesizer with
                the SoundFont below. FM chip: by the core's OPL2, as on a
                Sound Blaster.
  SoundFont     the synthesizer's SoundFont: Default (GeneralUser GS, which
                comes with the port) or one of your own, 1 to 7: the .sf2
                files in games/dnk/SoundFonts/, in the order of their names.
  MT32-pi       only while one is connected: on or off, its synth, ROM and
                SoundFont.
  Rumble        the controller rumbles when the ship is hit, fires, hits a
                wall or explodes, while the fusion cannon charges and while
                the mine shakes.
  Cheats        the games' own cheats, for one player: Invulnerability,
                Robots Don't Fire, Rapid Fire, Ghost (No Clipping), Turbo,
                and in Descent II Homing Weapons, Bouncy Weapons, Robots
                Kill Robots; Give All (all weapons and keys, full shields
                and energy; in Descent II the accessories too), Kill
                Reactor, Next Level, Exit Path. As with the typed cheats,
                the score goes to 0.
  Save Diagnostic Report
                the last line: see "If something is wrong" below.

Controls
  Keyboard and mouse:
    Arrow keys, mouse           Turn and pitch
    W / S                       Accelerate / reverse
    A / D                       Slide left / right
    C / X                       Slide up / down
    Q / E                       Bank left / right
    Left Alt                    Slide: the arrow keys slide while held
    Ctrl, left mouse button     Fire primary weapon
    Space, right mouse button   Fire secondary weapon
    F                           Fire flare
    B                           Drop bomb
    1-5 / 6-0                   Select primary / secondary weapon
    , / .                       Next primary / secondary weapon
    R                           Rear view
    Tab                         Automap
    Left Shift / H / T          Afterburner / headlight / energy to shield
                                (Descent II)
    Esc                         Game menu (automap, options, save, load,
                                abort)
    F2 / Alt+F2 / Alt+F3        Options / save game / load game
    F3                          Cockpit, status bar or full screen view
    F1                          Help: all keys
    All of them can be changed in the game under Options, Controls.
  Gamepad (default mapping):
    Left stick, D-pad                   Turn and pitch
    Right stick                         Slide left / right and up / down
    R2 (RT)                             Fire primary weapon
    L2 (LT)                             Fire secondary weapon
    Y (Xbox X / PlayStation Square)     Fire flare
    X (Xbox Y / PlayStation Triangle)   Drop bomb
    B (Xbox A / PlayStation Cross)      Accelerate
    A (Xbox B / PlayStation Circle)     Reverse
    L (LB / L1)                         Next primary weapon
    R (RB / R1)                         Next secondary weapon
    Select                              Rear view
    Start                               Game menu: automap, options, save,
                                        load, abort. Closes the automap and
                                        the menus too
  In the game's menus the buttons that confirm and go back are the ones of
  your MiSTer menu, whatever they do in the game: its Menu OK / Menu Back if
  you set them in "Define joystick buttons", else its A / B. A controller
  never set up in MiSTer confirms and goes back as on its console: Cross /
  Circle on PlayStation, A / B on Xbox and on Nintendo. They also skip a
  movie, as Start does.
  Nothing needs a keyboard. Where the game asks for text (the name of a
  pilot, the description of a saved game), the D-pad types: up and down
  change the last character, right adds one, left removes one. A game saved
  without a description gets the date and time.
  The actions of the buttons can also be changed in the game under Options,
  Controls, Customize joystick; there, Select clears a binding and holding
  Start resets all of them.
  Change the buttons in the OSD under "Define DXXRebirth buttons". "Menu OK"
  and "Menu Back" there are only needed for a spare button without a game
  function. While the OSD is open, the game gets no input.

If something is wrong
  If the game stutters, the sound breaks up or something else is wrong,
  open the OSD while it happens and pick Save Diagnostic Report, the last
  line of the menu. The game keeps running; MiSTer's info box says the
  report is saved in games/dnk/diagnostics/ on the SD card. Send that file
  (DXXRebirth_<date>_<time>.zip) with a few words on what went wrong. The
  report has the setup (versions, the video and audio lines of MiSTer.ini,
  the OSD settings), how the last 60 seconds went, the game's log and a
  screenshot. Nothing else: no network settings, addresses, saved games or
  lists of your files.

Files
  /media/fat/games/dnk/DXXRebirth/descent/    pilots, settings, saved games
  /media/fat/games/dnk/DXXRebirth/descent2/   and demos of the two games
  /media/fat/logs/dnk/DXXRebirth/dxxrebirth.log   the game's log

Credits
  DXX-Rebirth (https://www.dxx-rebirth.com/) by Kp, Christian Beckhaeuser
  and the DXX-Rebirth contributors, based on the Descent and Descent II
  source code released by Parallax Software.
  PhysicsFS by Ryan C. Gordon. libADLMIDI by Vitaly Novichkov and Joel
  Yliluoma (the music's sequencer and instruments). SDL_image and
  SDL_mixer.
  SDL by Sam Lantinga and contributors.
  GeneralUser GS by S. Christian Collins (the SoundFont,
  https://www.schristiancollins.com/generaluser.php; its licence in
  games/dnk/SoundFonts/GeneralUser-GS-LICENSE.txt).
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid cores on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.

License
  DXX-Rebirth: its own license, the Parallax license for the original
    source and GPL-3.0 for what was added since (LICENSE-dxxrebirth.txt,
    LICENSE-dxxrebirth-gpl3.txt)
  SDL, SDL_image, SDL_mixer, PhysicsFS: zlib (LICENSE-sdl.txt,
    LICENSE-sdl_image.txt, LICENSE-sdl_mixer.txt, LICENSE-physfs.txt)
  libADLMIDI (libADLMIDI.so): LGPL-3.0 (LICENSE-libadlmidi.txt)
  The launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0
  Source: https://github.com/ItsDanik/DXXRebirth_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
