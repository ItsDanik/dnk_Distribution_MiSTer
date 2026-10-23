Xash3D for MiSTer - Half-Life as a hybrid port
====================================================

Half-Life and its expansions Opposing Force and Blue Shift. The game (Xash3D
FWGS, with the games' code from hlsdk-portable) runs on the MiSTer's ARM
CPU; the Xash3D FPGA core provides native 15kHz video (CRT, VGA and HDMI)
at 320x200 or 320x240, 640x480 in the menus, audio and input.

Disclaimer: AI is being used to speed up development of this project.

Requirements
  - danik_hybrid_ports, the launcher that comes with this release
    (Scripts/danik_hybrid_ports.sh): run it ONCE from the MiSTer's Scripts
    menu. It starts the game whenever its menu entry is loaded, keeps
    running after a reboot, and serves all our hybrid ports; its screen
    picks which ports and games to have, and can keep them up to date
    through update_all. It replaces danik_hybrid_cores, the launcher before
    it, and moves ports installed the old way (games/Xash3D/) into the new
    folders by itself. Without it the core says "Game not running".
  - Game data. It is not included: the folder "valve" of Half-Life, from
    Steam or the CD (not Half-Life: Source). For the expansions also their
    folder: "gearbox" (Opposing Force) or "bshift" (Blue Shift).
  - A twin stick gamepad (two analog sticks, like an Xbox or PlayStation
    controller): the left stick moves, the right stick looks around, and
    the d-pad is for weapons.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick the games, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/Xash3D/, Scripts/ and downloader_danik_hybrid_ports.ini
     (with which update_all keeps the ports up to date from then on).
  2. Copy the game data to /media/fat/games/dnk/Xash3D/, over the folders
     that are there (they only hold our code for each game):
       valve      the whole folder of Half-Life (liblist.gam,
                  halflife.wad, maps, sound and the rest)
       gearbox    optional: the whole folder of Opposing Force
       bshift     optional: the whole folder of Blue Shift
  3. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  4. Load dnk-Half-Life, dnk-HL Opposing Force or dnk-HL Blue Shift from
     the Other menu.
  The game data can go on a USB drive instead, into the same folder there
  (/media/usb0/games/dnk/Xash3D/, with valve and the expansions' folders in
  it): the game looks for it there first, and then keeps its settings and
  saved games there as well. Everything else stays on the SD card, the
  games' code in its valve, gearbox and bshift folders too.
  Opposing Force and Blue Shift need Half-Life's folder valve as well. When
  a game's files are missing, the core says which files to copy where.
  Each game keeps its own OSD settings and button mappings. The core file
  itself (_Other/dnk/dnk-Xash3D_*.rbf, or from Recent) lists the games that
  are there; quitting a game then returns to the list.

OSD options
  Aspect ratio, Scale, Scandoubler Fx, Stereo Mix as in other cores.
  FPS Counter   shows the pictures per second in the top left corner.
  HDMI Only     Yes if no CRT is connected: resolutions of 640x400 and
                more are then progressive instead of interlaced, and the
                analog output is switched off while one is shown, so that a
                15kHz screen can never get such a signal. Here that is the
                menus (640x480); the game itself is not affected. Not
                needed with forced_scandoubler=1 (VGA monitor); not there
                with direct_video=1.
  CRT Options   for a 15kHz screen: Horizontal Size, Horizontal Pos and
                Vertical Pos fit the picture to it. The pixels stay as they
                are; HDMI is not affected. The size is for the game's
                picture: the core's own, with its messages, keeps its
                width. Not there with forced_scandoubler=1.
                HUD (Top), HUD (Bottom): at 320x240, how many lines the HUD
                keeps from the top and bottom edges of the screen, 0 to 24
                (0 by default, the very edge, for HDMI), so that a CRT's
                overscan does not hide it. They move at once. Greyed out at
                320x200.
  Resolution    the game in 320x200 (default) or 320x240. At 320x240 the
                view fills all 240 lines and the HUD is drawn over it at
                the HUD margins. The menus are always 640x480. Applies at
                once.
  Lock to 30 FPS
                On: a picture every second field, an even 30 per second
                where the game cannot keep up with 60. Off (default): up
                to 60.
  Rumble        On (default) / Strong / Off: the gamepad shakes with your
                shots (each weapon its own way; the egon's beam and the
                gauss charging for as long as they last), the damage you
                take (the more, the stronger), explosions near you and when
                the screen shakes (earthquakes, the tram crash, the big
                monsters' stomps). Strong is twice as strong.
  Cheats        God Mode, No Clip (fly through walls) and Invisible to
                Monsters stay on while they are on, through saved games
                and level changes, and are gone when turned off. Give All
                Weapons gives the suit, armour, every weapon of the game and
                ammo for them, once each time it is selected. Long Jump
                Module gives the long jump module (with the suit only).
  Save Diagnostic Report
                the last line: see "If something is wrong" below.

Controls
  Keyboard and mouse: Half-Life's own keys (the game's Configuration,
  Controls menu changes them):
    W, S, A, D (or the arrow keys)      walk, sidestep
    Mouse                               turn and look around
    Left / right mouse button           primary / secondary attack
    Space, Ctrl, Shift                  jump, duck, walk
    E, R, F                             use, reload, flashlight
    1 - 5, mouse wheel, Q               weapons, last weapon used
    T                                   spray your logo
    F6, F7                              quick save, quick load
    Esc                                 menu
  Gamepad (default mapping):
    Left stick                          move and strafe
    Right stick                         look around
    Left stick click (L3)               walk / run, toggles
    Right stick click (R3)              flashlight on / off
    D-pad left / right                  previous / next weapon
    D-pad up                            last weapon used
    D-pad down                          spray your logo
    A (Xbox B / PlayStation Circle)     jump, swim up
    B (Xbox A / PlayStation Cross)      duck, swim down
    X (Xbox Y / PlayStation Triangle)   use
    Y (Xbox X / PlayStation Square)     reload
    L (LB / L1), L2                     secondary attack
    R (RB / R1), R2                     primary attack
    Select                              next weapon
    Start                               menu
  The stick clicks and the analog triggers are read straight from the
  controller, so they work without being assigned in MiSTer's button setup
  (the stick clicks with controllers that report them as standard gamepad
  buttons, as Xbox and PlayStation controllers do). The game's own Controls
  menu changes the buttons too, and keeps what you set there.
  In the game's menus the buttons that confirm and go back are the ones of
  your MiSTer menu, whatever they do in the game: its Menu OK / Menu Back if
  you set them in "Define joystick buttons", else its A / B. A controller
  never set up in MiSTer confirms and goes back as on its console: Cross /
  Circle on PlayStation, A / B on Xbox and on Nintendo.
  Change the buttons in the OSD under "Define Xash3D buttons". "Menu OK" and
  "Menu Back" there are only needed for a spare button without a game
  function. While the OSD is open, the game gets no input.

If something is wrong
  If the game stutters, the sound breaks up or something else is wrong,
  open the OSD while it happens and pick Save Diagnostic Report, the last
  line of the menu. The game keeps running; MiSTer's info box says the
  report is saved in games/dnk/diagnostics/ on the SD card. Send that file
  (Xash3D_<date>_<time>.zip) with a few words on what went wrong. The
  report has the setup (versions, the video and audio lines of MiSTer.ini,
  the OSD settings), how the last 60 seconds went, the game's log and a
  screenshot. Nothing else: no network settings, addresses, saved games or
  lists of your files.

Files
  /media/fat/games/dnk/Xash3D/<game>/config.cfg   settings of each game
                                                  (valve, gearbox, bshift)
  /media/fat/games/dnk/Xash3D/<game>/save/        its saved games
  /media/fat/logs/dnk/Xash3D/xash3d.log           the game's log
  (the settings and saved games on the USB drive, if the game data is there)

Credits
  Xash3D FWGS by Uncle Mike (Xash3D) and the FWGS team, and hlsdk-portable
  by the FWGS team, after Valve's Half-Life SDK
  (https://github.com/FWGS/xash3d-fwgs, https://github.com/FWGS/hlsdk-portable).
  Half-Life by Valve; Opposing Force and Blue Shift by Gearbox Software.
  SDL by Sam Lantinga and contributors.
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid cores on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.
  This project is in no way associated with or endorsed by Valve or
  Gearbox Software. It does not include any game data.

License
  The engine (Xash3D FWGS): GPL-3.0 (LICENSE-gpl3.txt)
  The games' code (hlsdk-portable): Valve's Half-Life SDK license
  (LICENSE-hlsdk.txt)
  SDL: zlib (LICENSE-sdl.txt)
  The launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0
  Source: https://github.com/ItsDanik/Xash3D_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
