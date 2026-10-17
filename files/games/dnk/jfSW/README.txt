jfSW for MiSTer - Shadow Warrior and its addons as a hybrid port
================================================================

The game (JFShadowWarrior, Jonathon Fowler's port of 3D Realms' Shadow
Warrior) runs on the MiSTer's ARM CPU; the jfSW FPGA core provides native
15kHz video (CRT, VGA and HDMI) at 320x200, 640x200, 320x240 or 640x240,
audio and input.

Disclaimer: AI is being used to speed up development of this project.

Requirements
  - danik_hybrid_ports, the launcher that comes with this release
    (Scripts/danik_hybrid_ports.sh): run it ONCE from the MiSTer's Scripts
    menu. It starts the game whenever its menu entry is loaded, keeps
    running after a reboot, and serves all our hybrid ports; its screen
    picks which ports and games to have, and can keep them up to date
    through update_all. It replaces danik_hybrid_cores, the launcher before
    it, and moves ports installed the old way (games/jfSW/) into the new
    folders by itself. Without it the core says "Game not running".
  - Game data. It is not included: SW.GRP of Shadow Warrior 1.2, from the
    original CD or from Shadow Warrior Classic Complete / Classic Redux
    (GOG, Steam), or of the shareware version. The addons Wanton
    Destruction (WT.GRP) and Twin Dragon (TD.GRP, which needs the full
    game's SW.GRP as well) are optional.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick the games, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/jfSW/, Scripts/ and downloader_danik_hybrid_ports.ini
     (with which update_all keeps the ports up to date from then on).
  2. Copy the game data to /media/fat/games/dnk/jfSW/
       SW.GRP
       Track02.ogg ... Track14.ogg, the music (the audio of the game's
         CD), there or in a folder "music". Without them the full
         game has no music, only its sound effects. The shareware
         version needs none: its music is in its SW.GRP.
       optional: WT.GRP and TD.GRP, there or in a folder "addons".
     The whole folder of Shadow Warrior Classic Redux (the one with
     SW.GRP, "addons" and "classic") can be copied as it is: the addons
     and the music (classic/MUSIC) are found in it.
  3. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  4. Load the game from the Other menu, e.g. dnk-Shadow Warrior.

The game files are known by their contents, whatever their names. The menu
entry of Shadow Warrior starts the shareware when the full game is not
there. When a game's files are missing, the core says which files to copy
where. Each game keeps its own OSD settings and button mappings. The core
file itself (_Other/dnk/dnk-jfSW_*.rbf, or from Recent) lists the games
that are there to pick from; quitting a game then returns to the list.

OSD options
  Aspect ratio, Scale, Scandoubler Fx, Stereo Mix as in other cores.
  FPS Counter   shows the pictures per second in the top left corner.
  HDMI Only     Yes if no CRT is connected: resolutions of 640x400 and more
                are then progressive instead of interlaced, and the analog
                output is switched off while one is shown, so that a 15kHz
                screen can never get such a signal. This game has no such
                resolution, so nothing changes. Not there with
                direct_video=1.
  CRT Options   for a 15kHz screen: Horizontal Size, Horizontal Pos and
                Vertical Pos fit the picture to it. The pixels stay as they
                are; HDMI is not affected. The size is for the game's
                picture: the core's own, with its messages, keeps its
                width. Not there with forced_scandoubler=1. HUD (Bottom):
                in the 240-line resolutions, how many lines the status bar
                (or the mini bar) sits above the bottom edge of the screen,
                0 to 24 (10 by default), so that a CRT's overscan does not
                hide it; greyed out at 200 lines.
  Resolution    what the game renders and the core puts out, always at
                15kHz: 320x200 (default, as the original), 640x200, 320x240
                or 640x240. 640 across is twice the detail in the same
                place. 240 lines are square pixels at 320 across: the 3D
                view fills all of them, from the top edge to the bottom
                one, with the status bar drawn over it at the HUD (Bottom)
                margin and the weapon on top of the bar. Menus and full
                screen pictures are in the middle of the screen with 20
                black lines above and below, never stretched. Applies at
                once in the game and its menu.
  L. Stick Sensitivity, R. Stick Sensitivity
                how fast the gamepad's left stick (walk, strafe) and right
                stick (turn, look) move the player, 25% to 300%. At 100% a
                full tilt walks and turns about as fast as the keys do
                when running. They apply at once and take the place of
                the axis scale in the game's own menu.
  Limit Vertical Look
                how far the view tilts up and down. The Build engine
                shifts the picture instead of turning the camera, which
                distorts it the further you look up or down. On
                (default) leaves half of the game's own range in both
                directions; Off is the whole range. For the keys, the
                mouse and the gamepad alike.
  Cheats        God Mode: nothing hurts you while it is on. No Clipping:
                you walk through walls while it is on. Give All: every
                weapon with full ammo, armor, the inventory items and all
                keys, once each time it is selected. Next Level: the level
                counts as completed, as at its exit, and the next one
                starts (not on the last level).
  Menu OK, Menu Back
                the gamepad button that confirms / goes back in the game's
                menus, whatever it does in the game. MiSTer (default) uses
                the OK/Back buttons of your MiSTer menu.

Controls
  Keyboard and mouse:
    W, S (or up, down)                  Walk forward, back
    A, D                                Sidestep left, right
    Mouse (or left, right)              Turn
    Mouse up, down                      Look up, down
    Left mouse button (or right Ctrl)   Fire
    E (or right mouse button)           Open, use
    Space                               Jump
    Left Ctrl                           Crouch
    Shift                               Run (Caps Lock: always run)
    1 - 0                               Weapons
    R, Q (or mouse wheel)               Next, previous weapon
    F (or Enter), [, ]                  Use the inventory item, previous
                                        and next item
    Page Up, Page Down, Home, End       Look and aim up and down
    Tab                                 Map
    Esc                                 Menu
    This is a modern scheme, the default of this build; with the arrows
    and the right Ctrl the game can be played on a keyboard alone.
    "Options" in the game's menu changes keys, mouse and gamepad
    assignments, and has the keys of the original game ("Apply Classic
    Defaults"). They are saved in sw.cfg, so a sw.cfg from an earlier
    release keeps its keys until "Apply Modern Defaults" is chosen there.
  Gamepad (default mapping):
    Left stick                          Walk and strafe
    Right stick                         Turn, look up and down
    D-pad                               Walk and turn
    R (RB / R1)                         Fire
    B (Xbox A / PlayStation Cross)      Open, use
    A (Xbox B / PlayStation Circle)     Jump
    L (LB / L1)                         Crouch
    Y (Xbox X / PlayStation Square)     Next weapon
    X (Xbox Y / PlayStation Triangle)   Use the inventory item
    Select                              Map
    Start                               Menu
  Change the buttons in the OSD under "Define jfSW buttons". "Menu OK" and
  "Menu Back" there are only needed for a button without a game function;
  MiSTer doesn't let you assign a button twice, so to confirm with a button
  that also has a game function, pick it in the OSD's Menu OK/Menu Back
  options instead.
  Naming a saved game without a keyboard: up/down changes the last
  letter, right adds a letter, left removes one, Menu OK confirms.

Music
  The full game plays its music from the CD. This build plays the same
  tracks from Ogg Vorbis files named Track02.ogg to Track14.ogg (track 1
  of the CD is the data). Classic Redux comes with them; from an original
  CD, rip the audio tracks and encode them.
  The shareware version has no CD: its music is MIDI. This build plays it
  as an AdLib or Sound Blaster card did, on an FM chip (a YM3812) in the
  FPGA core, with the game's own instruments. The game's Music Volume
  sets its level. It needs the core (.rbf) of the same release.

Files
  /media/fat/games/dnk/jfSW/sw.cfg      settings
  /media/fat/games/dnk/jfSW/game*.sav    saved games
  /media/fat/logs/dnk/jfSW/jfsw.log   the game's log

Credits
  JFShadowWarrior, JFBuild, JFAudioLib and JFMACT by Jonathon Fowler and
  contributors (https://github.com/jonof/jfsw).
  Shadow Warrior by 3D Realms Entertainment.
  Build engine by Ken Silverman.
  // "Build Engine & Tools" Copyright (c) 1993-1997 Ken Silverman
  // Ken Silverman's official web site: "http://www.advsys.net/ken"
  // See the included license file "BUILDLIC.TXT" for license info.
  Apogee Sound System by James R. Dose: its AdLib MIDI driver, in the
  form EDuke32 keeps it in, plays the music on the FM chip.
  JTOPL by Jose Tejada (jotego), https://github.com/jotego/jtopl: the FM
  chip in the core.
  libogg and libvorbis by the Xiph.Org Foundation.
  SDL by Sam Lantinga and contributors.
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid cores on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.

License
  JFShadowWarrior: GPL-2.0-or-later (LICENSE-jfsw.txt)
  The Build engine in it: Ken Silverman's Build license (BUILDLIC.TXT),
  free of charge, no commercial use
  libogg, libvorbis: BSD (LICENSE-vorbis.txt)
  SDL: zlib (LICENSE-sdl.txt)
  The launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0, the FM chip in it (JTOPL): GPL-3.0
  Source: https://github.com/ItsDanik/jfSW_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
