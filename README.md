# dnk_Distribution_MiSTer

The hybrid ports of [Hybrid_MiSTer](https://github.com/ItsDanik/Hybrid_MiSTer) for update_all: open source
ports of PC games that run on the MiSTer's ARM CPU, with a small FPGA core for their picture, sound and
controls.

1. Copy [downloader_danik_hybrid_ports.ini](https://raw.githubusercontent.com/ItsDanik/Hybrid_MiSTer/main/launcher/downloader_danik_hybrid_ports.ini)
   to the root of your SD card (Downloader 2.4 or newer, which update_all keeps up to date).
2. Run update_all. It installs the launcher, danik_hybrid_ports, in Scripts.
3. Run danik_hybrid_ports from the Scripts menu, tick the games you want and press X: Apply.

The game data is not included: each port's README says which files of your own copy go where.

`ports.txt` lists the ports in the database; `files/` is what it installs. Published with
`launcher/distribution.py` of Hybrid_MiSTer; the database itself is on the `db` branch.
