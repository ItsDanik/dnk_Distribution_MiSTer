CrispyDoom for MiSTer - Doom, Doom II, Final Doom, Heretic, Hexen and Strife
as a hybrid port
==============================================================================

The game (Crispy Doom, Crispy Heretic, Crispy Hexen and Crispy Strife, the
source ports by Fabian Greffrath) runs on the MiSTer's ARM CPU; the CrispyDoom FPGA core provides native 15kHz video (CRT,
VGA and HDMI) at 320x200, 640x200, 320x240 or 640x240, audio with the music
on an FM chip in the core, and input.

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
  - Game data. It is not included: your own copy of Doom (or The Ultimate
    Doom), Doom II or Final Doom (TNT: Evilution, The Plutonia Experiment),
    their expansions (SIGIL, SIGIL II, No Rest for the Living, the Master
    Levels), Heretic, Hexen (and Deathkings of the Dark Citadel), Strife,
    or the shareware of Doom, Heretic or Strife: the game's .WAD file.

Install
  With update_all (Downloader 2.4 or newer): copy
  downloader_danik_hybrid_ports.ini to /media/fat/, run update_all, run
  danik_hybrid_ports from the Scripts menu, tick the games, X: Apply.
  By hand:
  1. Extract the zip to the root of the SD card (/media/fat): _Other/,
     games/dnk/CrispyDoom/, Scripts/ and downloader_danik_hybrid_ports.ini
     (with which update_all keeps the ports up to date from then on).
  2. Copy everything in your games' folders to
     /media/fat/games/dnk/CrispyDoom/, all the files as they are (files the
     port does not use do no harm). Each game is known by its file:
       Doom, The Ultimate Doom    DOOM.WAD (shareware: DOOM1.WAD)
       SIGIL                      SIGIL_v1_21.wad (or SIGIL_V1_23.wad,
                                  SIGIL_V1_23_REG.wad, SIGIL_v1_2.wad,
                                  SIGIL.wad) and DOOM.WAD of The Ultimate
                                  Doom (the one with episode 4)
       SIGIL II                   SIGIL_II_V1_0.WAD (or
                                  SIGIL_II_MP3_V1_0.WAD) and DOOM.WAD of The
                                  Ultimate Doom
       Doom II                    DOOM2.WAD
       No Rest for the Living     NERVE.WAD and DOOM2.WAD
       Master Levels              MASTERLEVELS.WAD (or the 20 WADs of the
                                  Master Levels CD: ATTACK.WAD, CANYON.WAD
                                  and so on) and DOOM2.WAD
       TNT: Evilution             TNT.WAD (and TNT31.WAD, id's fix of
                                  MAP31, where your copy has it)
       The Plutonia Experiment    PLUTONIA.WAD
       Heretic                    HERETIC.WAD (shareware: HERETIC1.WAD)
       Hexen                      HEXEN.WAD
       Deathkings of the Dark     HEXDD.WAD and HEXEN.WAD of Hexen 1.1
       Citadel
       Strife                     STRIFE1.WAD and VOICES.WAD (the voices)
                                  (shareware: STRIFE0.WAD)
  3. Run danik_hybrid_ports from the Scripts menu, if you have not done so
     before (see Requirements).
  4. Load the game from the Other menu, e.g. dnk-Doom II.
  The game data can go on a USB drive instead, into the same folder there
  (/media/usb0/games/dnk/CrispyDoom/): the game looks for it there first, and
  then keeps its settings and saved games there as well. Everything else
  stays on the SD card.
  Each expansion has its own menu entry, starts at its own levels and
  keeps its saved games apart (savegames/sigil/ and so on). The menu entries
  of Doom, Heretic and Strife start the shareware when the full game is not
  there. When a game's file is missing, the core says which file to copy
  where. The core file itself (_Other/dnk/dnk-CrispyDoom_*.rbf, or from
  Recent) lists the games that are there; quitting a game then returns to
  the list.

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
                width. Not there with forced_scandoubler=1. HUD (Top) /
                HUD (Bottom): in 240 lines, how many lines the messages sit
                below the top edge and the status bar above the bottom one,
                0 to 24 (10 by default); greyed out in 200 lines.
  Resolution    320x240 (default), 640x240, 320x200 (as the original) or
                640x200. The 640-wide ones show the same picture with twice
                the detail across. In 240 lines the view fills all 240, the
                status bar drawn over it at the HUD (Bottom) margin; it
                shows what the original's full screen does, nothing
                stretched. Menus, title screens and the intermission keep
                their 200 lines, centred. Applies at once. 640x240 is the
                heaviest and can miss a picture in the busiest scenes.
  Music         MIDI (default): the music as General MIDI, played by the
                core's synthesizer with a SoundFont, or by an MT32-pi when
                one is connected and on. FM chip: as the original's.
  SoundFont     Default: GeneralUser GS, which comes with the port
                (games/dnk/SoundFonts/GeneralUser-GS.sf2). 1 to 7: your
                own .sf2 files in that folder, by name, or as the MIDI
                Player core sets them. A SoundFont missing, damaged or too
                big (over 64 MB of samples) is said in the MiSTer's info
                box, and the music goes to the FM chip.
  FM Music      With Music on the FM chip. FPGA (default): the music on
                the YM3812 chip in the core;
                Software: worked out on the ARM. Applies at once.
  Rumble        On (default): the controller rumbles when you are hurt,
                as hard as the hit, when you fire (the heavier the
                weapon, the harder), when you land from a fall, and in
                Hexen's earthquakes. Off: never.
  Cheats        God Mode, No Clipping, No Target, Infinite Ammo, Buddha
                (never below 1% health) while on; Give All (IDKFA; in
                Heretic and Hexen all weapons, keys and artifacts, in Strife
                weapons, ammo, armor and keys, the Sigil kept), Kill All
                Monsters, Next Level (in Strife RIFT to the map with the
                next number), Full Map (IDDT: map, things, off) each time
                selected. Not in demos or multiplayer.

Controls
  Keyboard and mouse:
    Arrows move and turn, Ctrl fires, Space uses (doors, switches), Shift
    runs (Caps Lock: always run), Alt + Left / Right or , / . strafe, 1 to 7
    weapons, Tab automap, Esc menu. The mouse turns; its left button fires,
    the right one strafes, the middle one moves forward, the wheel changes
    weapon.
  Gamepad (default mapping):
    Left stick                          move and strafe
    Right stick                         turn (look up and down with
                                        "Allow Free Look" on)
    D-pad                               move and turn
    A (Xbox B / PlayStation Circle)     run (held)
    B (Xbox A / PlayStation Cross)      use (doors, switches)
    X (Xbox Y / PlayStation Triangle)   previous weapon
    Y (Xbox X / PlayStation Square)     next weapon
    L (LB / L1)                         strafe (held)
    R (RB / R1), R2                     fire
    L2                                  run (held)
    Select                              automap
    Start                               Menu
  In Heretic, Hexen and Strife the d-pad is for the inventory (move with
  the left stick):
    D-pad Left / Right                  choose an artifact or item
    D-pad Down                          use it
    D-pad Up                            Heretic, Hexen: fly up; Strife:
                                        the mission objectives (held)
    L2                                  Heretic, Hexen: fly down;
                                        Strife: run (held)
    X (Xbox Y / PlayStation Triangle)   Hexen, Strife: jump (Next Weapon
                                        alone goes round the weapons; the
                                        OSD still calls it Prev Weapon)
  Keyboard in Hexen and Strife: [ / ] choose an item, Enter uses it, / jumps
  (Strife: A); Strife's W shows the objectives, K the keys, Z the inventory.
  Strife asks for a name when a game starts: an empty slot comes with
  PLAYER 1 (2, 3...) filled in, so Menu OK starts it.
  In the game's menus the buttons that confirm and go back are the ones of
  your MiSTer menu, whatever they do in the game: its Menu OK / Menu Back if
  you set them in "Define joystick buttons", else its A / B. A controller
  never set up in MiSTer confirms and goes back as on its console: Cross /
  Circle on PlayStation, A / B on Xbox and on Nintendo.
  Change the buttons in the OSD under "Define CrispyDoom buttons". "Menu OK"
  and "Menu Back" there are only needed for a spare button without a game
  function. While the OSD is open, the game gets no input.

If something is wrong
  If the game stutters, the sound breaks up or something else is wrong,
  open the OSD while it happens and pick Save Diagnostic Report, the last
  line of the menu. The game keeps running; MiSTer's info box says the
  report is saved in games/dnk/diagnostics/. Send that file
  (CrispyDoom_<date>_<time>.zip) with a few words on what went wrong. It
  has the setup, how the last 60 seconds went, the game's log and a
  screenshot; no network settings, addresses, saved games or lists of
  your files.

Files
  games/dnk/CrispyDoom/default.cfg, crispy-doom.cfg   settings
  games/dnk/CrispyDoom/savegames/                   saved games
  games/dnk/CrispyDoom/heretic.cfg, crispy-heretic.cfg, hticsav*.hsg
                                                    Heretic's settings and
                                                    saved games
  games/dnk/CrispyDoom/hexen.cfg, crispy-hexen.cfg    Hexen's settings
  games/dnk/CrispyDoom/strife.cfg, crispy-strife.cfg  Strife's settings
  /media/fat/logs/dnk/CrispyDoom/crispydoom.log   the game's log
  games/dnk/SoundFonts/GeneralUser-GS.sf2         the SoundFont, shared
                                                  with the other ports
                                                  with MIDI music

Credits
  Crispy Doom, Crispy Heretic, Crispy Hexen and Crispy Strife by Fabian
  Greffrath and contributors, based on Chocolate Doom by Simon Howard and
  contributors (Chocolate Strife: Strife reconstructed by James Haley and
  Samuel Villarreal), and on the Doom, Heretic and Hexen source code
  released by id Software and Raven Software. JTOPL by Jose Tejada (the FM chip), Nuked OPL3 by nukeykt.
  GeneralUser GS by S. Christian Collins (the SoundFont,
  https://www.schristiancollins.com/generaluser.php; its licence in
  games/dnk/SoundFonts/GeneralUser-GS-LICENSE.txt).
  SDL by Sam Lantinga and contributors.
  MiSTer by Sorgelig and the MiSTer-devel contributors.
  MiSTer Frontier by MiSTer Organize
  (https://github.com/MiSTerOrganize/MiSTer_Frontier): thank you for the
  inspiration. Hybrid cores on the MiSTer, and the way their game is
  launched, come from MiSTer Frontier. Our launcher is a separate
  implementation and does not need MiSTer Frontier installed.

License
  Crispy Doom, Heretic, Hexen, Strife: GPL-2.0-or-later
  (LICENSE-crispydoom.txt)
  SDL: zlib (LICENSE-sdl.txt)
  The launcher scripts: GPL-3.0 (LICENSE-gpl3.txt)
  The FPGA core: GPL-2.0
  Source: https://github.com/ItsDanik/CrispyDoom_MiSTer
          https://github.com/ItsDanik/Hybrid_MiSTer (launcher, framework)
