YQuake2 for MiSTer - Quake II as a hybrid port
====================================================

The game (Yamagi Quake II, with the mission packs The Reckoning and Ground
Zero) runs on the MiSTer's ARM CPU; the YQuake2 FPGA core provides native
15kHz video (CRT, VGA and HDMI) at 320x200 or 320x240, audio and input.

Disclaimer: AI is being used to speed up development of this project.

Requirements
  - danik_hybrid_ports, the launcher that comes with this release
    (Scripts/danik_hybrid_ports.sh): run it ONCE from the MiSTer's Scripts
    menu. It starts the game whenever its menu entry is loaded, keeps
    running after a reboot, and serves all our hybrid ports; its screen
    picks which ports and games to have, and can keep them up to date
    through update_all. It replaces danik_hybrid_cores, the launcher before
    it, and moves ports installed the old way (games/YQuake2/) into the new
    folders by itself. Without it the core says "Game not running".
  - Game data. It is not included: Quake II from the CD (patched to 3.20),
    Steam or GOG, or the free demo. The original game files, not those of
    the 2023 remaster.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick the games, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/YQuake2/, Scripts/ and downloader_danik_hybrid_ports.ini
     (with which update_all keeps the ports up to date from then on).
  2. Copy the game data to /media/fat/games/dnk/YQuake2/, next to the
     game.so files that are already in its folders:
       baseq2/        pak0.pak, pak1.pak, pak2.pak and the folders players/
                      and video/ from the baseq2 folder of your Quake II.
                      A CD version needs the 3.20 patch for pak1.pak and
                      pak2.pak. The demo has only pak0.pak and players/.
       baseq2/music/  the soundtrack, optional: 02.ogg to 11.ogg, ripped
                      from the CD. The GOG version's music/ folder
                      (Track02.ogg ...) goes next to baseq2/ instead.
       xatrix/        The Reckoning, optional: pak0.pak and video/
       rogue/         Ground Zero, optional: pak0.pak and video/
  3. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  4. Load dnk-Quake II, dnk-Q2 The Reckoning or dnk-Q2 Ground Zero from the
     Other menu.
  The menu entry of Quake II starts the demo when the full game is not
  there; the mission packs need the full game. When a game's files are
  missing, the core says which files to copy where. Each game keeps its own
  OSD settings and button mappings. The core file itself
  (_Other/dnk/dnk-YQuake2_*.rbf, or from Recent) lists the games that are
  there; quitting a game then returns to the list.

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
                width. Not there with forced_scandoubler=1.
                HUD (Top), HUD (Bottom): at 320x240, how many lines the
                messages at the top and the status bar at the bottom keep
                from the edges of the screen, 0 to 24 (10 by default), so
                that a CRT's overscan does not hide them. 0 is the very
                edge, for HDMI. Greyed out at 320x200.
  Resolution    320x200 (default) or 320x240: the game's picture, switched
                at once. At 320x240 the view fills all 240 lines and the
                status bar is drawn over it at the HUD margin; it shows a
                little more and is a little slower.
  Cheats        single player only. God Mode, No Clipping (fly through
                walls), Invisible to Monsters and Infinite Ammo stay on
                while they are on, through saved games and level changes,
                and are gone when turned off. Once each time they are
                selected: Give All (every weapon with full ammo, armour,
                the power shield, keys and items), Quad Damage and
                Invulnerability (one in the inventory, used like one picked
                up), Next Level (the level is left through its exit: the
                first one that does not lead back to the level you came
                from).
  Menu OK, Menu Back
                the gamepad button that confirms / goes back in the game's
                menus, whatever it does in the game. MiSTer (default) uses
                the OK/Back buttons of your MiSTer menu.

Controls
  Keyboard and mouse:
    W / S                               forward / back
    A / D                               step left / right
    Mouse                               look around (always)
    Mouse 1                             fire
    Space                               jump, swim up
    Ctrl                                crouch, swim down
    Shift                               walk while held (the game always
                                        runs)
    1 to 0, -                           Blaster, Shotgun, Super Shotgun,
                                        Machinegun, Chaingun, Grenades,
                                        Grenade Launcher, Rocket Launcher,
                                        HyperBlaster, Railgun, BFG10K
  The mission packs' weapons are on the key of the weapon they go with;
  pressed again, the key switches between them: 1 Chainfist, 4 ETF Rifle,
  6 Tesla and Trap, 7 Prox Launcher, 8 Phalanx, 9 Ion Ripper and Plasma
  Beam, - Disruptor. The other keys are as in Quake II: the arrow keys move
  and turn, Tab is the inventory, Enter uses the selected item, [ and ]
  select, ' drops it, F1 is the field computer, F6 / F9 quick save / load
  and Esc the menu. Change them in the game's Options menu.
  Gamepad (default mapping):
    Left stick                          move
    Right stick                         look around
    D-pad                               left / right: previous / next
                                        weapon, up / down: previous / next
                                        item
    A (Xbox B / PlayStation Circle)     jump, swim up
    B (Xbox A / PlayStation Cross)      crouch, swim down
    X (Xbox Y / PlayStation Triangle)   inventory
    Y (Xbox X / PlayStation Square)     use the selected item
    L (LB / L1), L2                     walk while held
    R (RB / R1), R2                     fire
    L3 (left stick click)               drop the selected item
    Select                              field computer (help)
    Start                               Menu
  In the game's menus the d-pad and left stick move and Menu OK / Menu Back
  confirm and go back. Rebind the keyboard and gamepad in the game's Options
  menu; the game keeps your changes. L2 and R2 work on controllers with
  analog triggers, L3 on those whose stick clicks Linux reports as such (a
  DualSense does).
  Change the buttons in the OSD under "Define YQuake2 buttons". "Menu OK" and
  "Menu Back" there are only needed for a button without a game function;
  MiSTer doesn't let you assign a button twice, so to confirm with a button
  that also has a game function, pick it in the OSD's Menu OK/Menu Back
  options instead.

Files
  baseq2/config.cfg                     settings
  baseq2/save/                          saved games (xatrix/, rogue/ for
                                        the mission packs)
  /media/fat/logs/dnk/YQuake2/yquake2.log   the game's log

Credits
  Yamagi Quake II (https://github.com/yquake2/yquake2) by Yamagi
  Burmeister and contributors, and Quake II by id Software. The mission
  pack code from yquake2/xatrix and yquake2/rogue.
  SDL by Sam Lantinga and contributors.
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid cores on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.

License
  Yamagi Quake II: GPL-2.0 (LICENSE-yquake2.txt; LICENSE-xatrix.txt and
  LICENSE-rogue.txt for the mission pack code)
  SDL: zlib (LICENSE-sdl.txt)
  The launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0
  Source: https://github.com/ItsDanik/YQuake2_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
