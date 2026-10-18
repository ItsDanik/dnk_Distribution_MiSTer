OpenScreamer for MiSTer - Screamer and Screamer 2 as a hybrid port
==================================================================

The game is OpenScreamer (https://github.com/ItsDanik/openscreamer), a
reimplementation of Screamer (Graffiti / Virgin Interactive, 1995, MS-DOS)
and Screamer 2 (1996) written from the original programs. It runs on the
MiSTer's ARM CPU; the OpenScreamer FPGA core provides native 15kHz video
(CRT, VGA and HDMI) at 320x200, 320x240, 640x200 or 640x240, audio,
Screamer's FM music chip and input.

Disclaimer: AI is being used to speed up development of this project.

Requirements
  - danik_hybrid_ports, the launcher that comes with this release
    (Scripts/danik_hybrid_ports.sh): run it ONCE from the MiSTer's Scripts
    menu. It starts the game whenever its menu entry is loaded, keeps
    running after a reboot, and serves all our hybrid ports; its screen
    picks which ports and games to have, and can keep them up to date
    through update_all. It replaces danik_hybrid_cores, the launcher before
    it, and moves ports installed the old way (games/OpenScreamer/) into
    the new folders by itself. Without it the core says "Game not running".
  - Game data. It is not included: your own copy of the original DOS
    Screamer (1995), Screamer 2 (1996), or both. Tested with the retail CD
    versions. The games are still sold.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick the games, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/OpenScreamer/, Scripts/ and downloader_danik_hybrid_ports.ini
     (with which update_all keeps the ports up to date from then on).
  2. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  Then the games' files: copy EVERYTHING in each game's folder (the one
  that holds DATA and GFX), with all its folders as they are, and leave
  nothing out. Nothing has to be unpacked; upper or lower case does not
  matter. Files the port does not use (the .EXEs, the sound drivers) do no
  harm.
  - Screamer: to /media/fat/games/dnk/OpenScreamer/screamer/ (so that
    there is .../screamer/DATA/GEN.DAT, .../screamer/GFX/GAME.DAT and so
    on). If CONFIG/CONTROLS.CFG is there, its keyboard keys are used. If
    you had the first release, your folders straight in the game's folder
    (DATA, GFX, CONFIG) keep working there.
  - Screamer 2: to /media/fat/games/dnk/OpenScreamer/screamer2/ (so that
    there is .../screamer2/DATA/GEN.DAT, .../screamer2/GFX/GAME1.DAT,
    .../screamer2/ANIMS/SCENE011.DAT and so on). Its music is the CD's
    audio tracks: as files in screamer2/music/, named track_02.ogg ..
    track_09.ogg (.mp3 or .wav do as well; track 2 is the menu's, 3 to 9
    the races'). Without them Screamer 2 has no music.
  Load the game from the Other menu: dnk-Screamer or dnk-Screamer 2.

When a game's files are missing, the core says which files to copy where;
each game checks its files every time it starts and says which are missing
or damaged. Each game keeps its own OSD settings and button mappings. The
core file itself (_Other/dnk/dnk-OpenScreamer_*.rbf, or from Recent) lists
the games that are there to pick from; quitting a game then returns to the
list, otherwise to the MiSTer menu.

OSD options
  Aspect ratio, Scale, Scandoubler Fx, Stereo Mix as usual.
  FPS Counter   shows the pictures per second in the top left corner.
  HDMI Only     as in the other hybrid ports, for resolutions of 640x400
                and more: OpenScreamer has none, so nothing changes here.
  CRT Options   for a 15kHz screen: Horizontal Size, Horizontal Pos and
                Vertical Pos fit the picture to it. The pixels stay as they
                are; HDMI is not affected. The size is for the game's
                picture: the core's own, with its messages, keeps its
                width. Not there with forced_scandoubler=1. HUD (Top) and
                HUD (Bottom): in a race with 240 rows, how many lines the
                race's labels and clocks at the top and its instruments at
                the bottom are from the edges of the screen, 0 to 24 (10 by
                default), so that a CRT's overscan does not hide them;
                greyed out with 200 rows. They move at once.
  Resolution    both games. 320x200 (default), the games' own; 320x240:
                more of the road and sky above and below; 640x200 and
                640x240: twice as sharp across, with the games'
                high-resolution pictures for menus and instruments.
                Nothing is stretched: menus sit in the middle of a 240-row
                screen, the race's instruments at its edges. Changes at
                once; a change of width in a menu starts the menu again.
                The 640 modes cannot reach 60 pictures a second (about 35
                to 45): use Lock to 30 FPS with them.
  Lock to 30 FPS  Off (default) / On: a steady 30 pictures a second, for
                the 640 modes.
  Rumble        Off (default) / On / Strong: the controller shakes on wall
                hits, crashes, contact with other cars, grass, skids and
                wheelspin.
  Cheats        what the games' cheat words do, which need a keyboard.
                Screamer: Frozen Countdown, Mirrored, Upside Down (no
                cockpit view), Props (the tracks' second or third set, from
                the next race), Afterburner Difficulty; Unlock the Bullet
                and Unlock All Tracks (the reversed ones too) are kept with
                your records. Screamer 2: Unlock All Tracks, Unlock Fifth
                Cars (each team's fifth car), Unlock All Leagues, kept with
                its settings. Each game shows only its own.
  Menu OK, Menu Back
                the gamepad button that confirms / goes back in the games'
                menus, whatever it does in a race. MiSTer (default) uses
                the OK/Back buttons of your MiSTer menu.

Controls
  Keyboard (the mouse is not used):
    Up / Down             accelerate / brake; in menus: choose a line
    Left / Right          steer; in menus: change an option, car, track
    Alt / Ctrl (A / Z)    gear up / down (cars with manual transmission;
                          Screamer 2: Right Shift / Left Ctrl, or A / Z)
    C                     next view; F1 .. F4 the views one by one
    M                     Screamer: radar zoom. Screamer 2: the mirror (R
                          too)
    P                     Screamer: the CD player (Screamer 2 has it on its
                          pause screen)
    Backspace             Screamer: puts the car back onto the road
    Enter                 confirm
    Esc                   back. In a race: Screamer asks whether to leave,
                          Screamer 2 pauses
    The six driving keys are those of the game's CONFIG/CONTROLS.CFG when
    that file is there. To change one, add a line to saves/openscreamer.cfg:
    key_accelerate=, key_brake=, key_left=, key_right=, key_gear_up= or
    key_gear_down= with a key's name, such as key_brake=Space.
  Gamepad (default mapping), the same in both games:
    Left stick                          steer, analog; in menus: move
    D-pad                               steer; in menus: move
    R2 / L2 (the triggers)              accelerate / brake, analog
    A (Xbox B / PlayStation Circle)     accelerate
    B (Xbox A / PlayStation Cross)      brake
    X (Xbox Y / PlayStation Triangle)   Screamer: radar zoom. Screamer 2:
                                        the mirror
    Y (Xbox X / PlayStation Square)     next view
    L (LB / L1)                         gear down
    R (RB / R1)                         gear up
    Select                              back; in a Screamer race: leave
                                        (it asks first)
    Start                               confirm; in a race: pause, and
                                        again to resume (Screamer: its CD
                                        player screen; Screamer 2: its
                                        pause screen)
  The triggers are read from the controller directly, not through MiSTer's
  button mapping: they need a controller whose triggers are analog (Xbox,
  PlayStation and the like). The stick steers as each game took a joystick:
  Screamer as it is, Screamer 2 through its own curve. Standing on the
  grid, an automatic car in Screamer only takes first gear with the pedal
  nearly all the way down, as in the original.
  Racing wheel: the wheels MiSTer itself knows (Logitech G25, G27, G29,
  Driving Force, Driving Force Pro and GT; Fanatec ClubSport V2.5, Podium
  DD1 and DD2; Thrustmaster T300RS, F430 and FGT, and a few adapters) steer
  with the wheel and drive with the pedals, analog: gas is R2, brake L2.
  Map the wheel's buttons in the OSD as for a gamepad. While a wheel is
  connected, a gamepad's stick pushed up also counts as a pedal, and the
  gas pedal moves the menus' lines like the stick up.
  Change the buttons in the OSD under "Define OpenScreamer buttons". "Menu
  OK" and "Menu Back" there are only needed for a button without a game
  function; MiSTer doesn't let you assign a button twice, so to confirm
  with a button that also has a game function, pick it in the OSD's Menu
  OK/Menu Back options instead.

Files
  /media/fat/games/dnk/OpenScreamer/saves/   settings, best times,
      championships, saved replays and time-attack ghosts of both games.
      A new Screamer has three tracks and twelve cars, a new Screamer 2
      three tracks and the first league: the rest is won in the
      championship, as in the originals.
  /media/fat/logs/dnk/OpenScreamer/openscreamer.log   the game's log

Credits
  Screamer (1995) and Screamer 2 (1996) by Graffiti, published by Virgin
  Interactive.
  OpenScreamer, the reimplementation, by Danik with Claude (Anthropic).
  JTOPL by Jose Tejada (jotego): the FM chip in the FPGA.
  Nuked OPL3 by Nuke.YKT: the same chip in software, for the PC build.
  stb_vorbis by Sean Barrett, dr_mp3 and dr_wav by David Reid: Screamer 2's
  music files.
  SDL by Sam Lantinga and contributors.
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid ports on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.

License
  OpenScreamer: GPL-3.0 (LICENSE-openscreamer.txt)
  Nuked OPL3: LGPL-2.1 or later (LICENSE-nuked-opl3.txt)
  stb_vorbis, dr_mp3, dr_wav: public domain (or MIT / MIT-0)
  SDL: zlib (LICENSE-sdl.txt)
  The launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0
  Source: https://github.com/ItsDanik/openscreamer_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
