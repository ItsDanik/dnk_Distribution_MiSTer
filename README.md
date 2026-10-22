# dnk_Distribution_MiSTer

The hybrid ports of [Hybrid_MiSTer](https://github.com/ItsDanik/Hybrid_MiSTer) for update_all: open source
ports of PC games that run on the MiSTer's ARM CPU, with a small FPGA core for their picture, sound and
controls.

1. Copy [downloader_danik_hybrid_ports.ini](https://raw.githubusercontent.com/ItsDanik/Hybrid_MiSTer/main/launcher/downloader_danik_hybrid_ports.ini)
   to the root of your SD card (Downloader 2.4 or newer, which update_all keeps up to date).
2. Run update_all. It installs the launcher, danik_hybrid_ports, in Scripts.
3. Run danik_hybrid_ports from the Scripts menu, tick the games you want and press X: Apply.

The game data is not included: copy the files from your own copy of each game into its port's folder on
the SD card, or into the same folder on a USB drive (`/media/usb0/games/dnk/<Engine>/`), where the port
looks first. Each port's README.txt, which comes with it into the folder on the SD card, says which files
go where; without them, the game says so when it is loaded.

The ports whose games play MIDI music bring the SoundFont [GeneralUser GS](https://www.schristiancollins.com/generaluser.php)
by S. Christian Collins, in `/media/fat/games/dnk/SoundFonts/` with its licence: their cores' synthesizer plays
the music with it. Your own `.sf2` files can go in the same folder.

| Games | Your game files go in | Which files |
|---|---|---|
| Doom, Doom - SIGIL, Doom - SIGIL II, Doom II, Doom II - No Rest for the Living, Doom II - Master Levels, Final Doom - TNT Evilution, Final Doom - Plutonia Experiment, Heretic, Hexen, Hexen - Deathkings, Strife | `/media/fat/games/dnk/CrispyDoom/` | [README.txt](files/games/dnk/CrispyDoom/README.txt) |
| Carmageddon, Carmageddon: Splat Pack | `/media/fat/games/dnk/Dethrace/` | [README.txt](files/games/dnk/Dethrace/README.txt) |
| Wolfenstein 3D, Spear of Destiny, SoD: Return to Danger, SoD: Ultimate Challenge | `/media/fat/games/dnk/ECWolf/` | [README.txt](files/games/dnk/ECWolf/README.txt) |
| Shadow Warrior, SW: Wanton Destruction, SW: Twin Dragon | `/media/fat/games/dnk/jfSW/` | [README.txt](files/games/dnk/jfSW/README.txt) |
| Screamer, Screamer 2 | `/media/fat/games/dnk/OpenScreamer/` | [README.txt](files/games/dnk/OpenScreamer/README.txt) |
| Half-Life, HL: Opposing Force, HL: Blue Shift | `/media/fat/games/dnk/Xash3D/` | [README.txt](files/games/dnk/Xash3D/README.txt) |
| Quake II, Q2: The Reckoning, Q2: Ground Zero | `/media/fat/games/dnk/YQuake2/` | [README.txt](files/games/dnk/YQuake2/README.txt) |

`ports.txt` lists the ports in the database; `files/` is what it installs. Published with
`launcher/distribution.py` of Hybrid_MiSTer; the database itself is on the `db` branch.
