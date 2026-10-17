#!/bin/bash
#
# danik_hybrid_ports - starts the game of a MiSTer hybrid port when its core is loaded
#
# https://github.com/ItsDanik/Hybrid_MiSTer
#
# A hybrid port is a game that runs on the MiSTer's ARM CPU, with a small FPGA
# core for its picture, sound and controls. This script is what connects the
# two: a small daemon watches which core is loaded (/tmp/CORENAME) and runs
# the game's launch script, games/dnk/<engine>/danik_hybrid_launch.sh, while
# it is. The launch script is stopped when another core is loaded.
#
#   Run it once from the MiSTer's Scripts menu. That starts the daemon and
#   adds it to /media/fat/linux/user-startup.sh, so it also runs after a
#   reboot. Running it again is harmless.
#
#   It takes over from danik_hybrid_cores.sh, the launcher before it (version
#   2): stops it, takes it out of user-startup.sh and deletes it. A running
#   version 2 does not wait for that: it finds version 3 of itself, which
#   comes with the ports as games/dnk/danik_hybrid_cores.sh, and that one runs
#   "danik_hybrid_ports.sh takeover", so Scripts never keeps both.
#
#   A port's files: _Other/dnk-<Game>.mgl (its menu entries, which load the
#   engine's core with a set name, <engine>_<game>, for games of a core with
#   several), _Other/dnk/dnk-<engine>_YYYYMMDD.rbf (the core), games/dnk/
#   <engine>/ (the game, its data, settings and saved games), logs/dnk/
#   <engine>/. Ports installed the way of version 2 (_Other/<engine>_*.rbf,
#   games/<engine>/) still start, and are moved into that layout as soon as
#   their new files are there and no game is running (see "migration").
#
#   Ports ship this file twice: in Scripts/ and as a copy in their games
#   folder. The copy with the highest VERSION is the one that runs: the daemon
#   installs it over the file in Scripts by itself, so an older port installed
#   later doesn't bring an old launcher back.
#
# usage: danik_hybrid_ports.sh            set up and choose the ports (as from the Scripts menu)
#        danik_hybrid_ports.sh start      start the daemon (what user-startup.sh calls)
#        danik_hybrid_ports.sh stop       stop the daemon and the running game
#        danik_hybrid_ports.sh remove     stop it and take it out of user-startup.sh
#        danik_hybrid_ports.sh migrate    move ports of the old layout now
#        danik_hybrid_ports.sh takeover   set up without the screen (what version 3 of
#                                         danik_hybrid_cores.sh runs when it hands over)
#        danik_hybrid_ports.sh status
#
# Choosing the ports: a screen with a tickbox for each port and each of its
# games the database has (the catalogue below), and the launcher on or off. The ports come
# through update_all, from the database danik_hybrid_ports, whose section is
# a drop-in file of Downloader (2.4 and later): /media/fat/
# downloader_danik_hybrid_ports.ini, which the player copies there to begin
# with (filter = launcher: the launcher alone). Apply writes its filter, which
# says what is ticked, and runs Downloader for this database alone (update.sh
# --run-only danik_hybrid_ports): what is ticked is installed, what is not is
# removed (the player's own files stay). That file is the only one written;
# a section of ours in downloader.ini itself, which would win over it, is
# moved into it. The screen is danik_hybrid_ports_ui, next to this file in
# .danik_hybrid_ports/; over SSH, or without it, dialog does the same.
#
# For a danik_hybrid_launch.sh:
#   - it is run with bash in its own session; its output goes to the log below
#   - MISTER_HYBRID_SET is what was loaded: the set name of the menu entry
#     (ECWolf_SOD), or the engine's name when the core was loaded directly
#   - on a core switch its whole process group gets SIGTERM, and SIGKILL two
#     seconds later if it is still there
#   - when it exits it is not started again until the core is loaded again
#     (to leave, a launcher loads the menu core)
#
# The whole script is read before anything runs (see the last line), so it can
# be replaced while the daemon is running; the daemon restarts itself with the
# new file as soon as no game is running.
#
# The way of launching a hybrid core (a daemon registered in user-startup.sh
# that watches /tmp/CORENAME and runs a script from the core's games folder)
# comes from MiSTer Frontier's Master_Daemon by MiSTer Organize:
# https://github.com/MiSTerOrganize/MiSTer_Frontier (GPL-3.0). Thank you for
# the inspiration. This script is written from scratch and does not need
# MiSTer Frontier.
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, version 3 of the License.

VERSION=3
SELF=$(readlink -f "$0")
# DANIK_HYBRID_ROOT and DANIK_HYBRID_TMP: another SD card and /tmp, for testing
ROOT=${DANIK_HYBRID_ROOT:-/media/fat}
TMP=${DANIK_HYBRID_TMP:-/tmp}
GAMES=$ROOT/games
DNK=$GAMES/dnk
OTHER=$ROOT/_Other
LOGS=$ROOT/logs
CONFIG=$ROOT/config
LAUNCHER=danik_hybrid_launch.sh
CORENAME=$TMP/CORENAME
RBFNAME=$TMP/RBFNAME
STARTUP=$ROOT/linux/user-startup.sh
PIDFILE=$TMP/danik_hybrid_ports.pid
LOG=$TMP/danik_hybrid_ports.log
# what was moved and taken over, kept on the SD card
HISTORY=$LOGS/dnk/danik_hybrid_ports.log
MARK="danik_hybrid_ports.sh"
DB_ID=danik_hybrid_ports
DB_URL=https://raw.githubusercontent.com/ItsDanik/dnk_Distribution_MiSTer/db/db.json.zip
DOWNLOADER_INI=$ROOT/downloader.ini
DROP_IN=$ROOT/downloader_$DB_ID.ini
UI=$(dirname "$SELF")/.danik_hybrid_ports/danik_hybrid_ports_ui
# DANIK_HYBRID_UI_ARGS: more for it, for testing (--fb FILE --geometry WxHxBPP)
UI_ARGS=${DANIK_HYBRID_UI_ARGS:-}

# The catalogue: the games of the ports in the database, those that have a
# menu entry, a line each: engine|game|title. A game's id is its menu entry's
# set name after "<engine>_" (dnk-<title>.mgl); a port with one game has one
# line. It is not written here: it comes with the launcher, from the database
# (tag launcher), made by launcher/distribution.py from the games.txt of
# every published port (a port's package/games.txt, in its zip as
# games/dnk/<engine>/games.txt). So the screen offers what the database
# has, no more, and a new port or game needs no new launcher. Without it (a launcher from a zip, before update_all
# ran), the ports on the SD card: their games.txt, or one line for a port
# of the old layout. The database's tags: the engine's name for all its
# files, <engine>_<game> for a game's (lower case; Downloader ignores - and
# _, so these must differ without them).
CATALOGUE=$ROOT/Scripts/.danik_hybrid_ports/catalogue.txt
# version 2, which this one takes over from
OLD_MARK="danik_hybrid_cores.sh"
OLD_PIDFILE=$TMP/danik_hybrid_cores.pid

log() {
    echo "$(date '+%H:%M:%S') $*" >> "$LOG"
}

# in the log and in the history on the SD card
note() {
    log "$*"
    mkdir -p "$(dirname "$HISTORY")" 2>/dev/null
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >> "$HISTORY"
}

daemon_pid() {
    local pid
    pid=$(cat "$PIDFILE" 2>/dev/null)
    [ -n "$pid" ] && grep -qs "$MARK" "/proc/$pid/cmdline" && echo "$pid"
}

valid_name() {
    case "$1" in
        "" | */* | .* | *" "*) return 1 ;;
    esac
}

# The launch script of what /tmp/CORENAME names: the engine's, in games/dnk/
# (the name itself, or the engine of its set: /tmp/RBFNAME, the core's own
# name, else the name up to its first "_"), or one of a port of the old
# layout (games/<name>/). Sets LAUNCH.
launcher_of() {
    local name=$1 engine
    LAUNCH=
    valid_name "$name" || return 1
    engine=$(cat "$RBFNAME" 2>/dev/null)
    if [ -f "$DNK/$name/$LAUNCHER" ]; then
        LAUNCH=$DNK/$name/$LAUNCHER
    elif valid_name "$engine" && [ "${name#"$engine"_}" != "$name" ] && [ -f "$DNK/$engine/$LAUNCHER" ]; then
        LAUNCH=$DNK/$engine/$LAUNCHER
    elif [ -f "$DNK/${name%%_*}/$LAUNCHER" ]; then
        LAUNCH=$DNK/${name%%_*}/$LAUNCHER
    elif [ "$name" != dnk ] && [ -f "$GAMES/$name/$LAUNCHER" ]; then
        LAUNCH=$GAMES/$name/$LAUNCHER
    fi
    [ -n "$LAUNCH" ]
}

# VERSION of a copy of this script
version_of() {
    sed -n 's/^VERSION=\([0-9][0-9]*\)$/\1/p' "$1" 2>/dev/null | head -n 1
}

# Installs the newest copy the ports brought along (games/dnk/*/) over this
# file, if one is newer than it. True if the file was replaced.
adopt_newest() {
    local f v best bestv
    bestv=$(version_of "$SELF")
    bestv=${bestv:-0}
    best=
    for f in "$DNK"/*/"$MARK"; do
        [ -f "$f" ] || continue
        v=$(version_of "$f")
        if [ -n "$v" ] && [ "$v" -gt "$bestv" ]; then
            best=$f
            bestv=$v
        fi
    done
    [ -n "$best" ] || return 1
    bash -n "$best" 2>/dev/null || return 1
    # its screen came with it: that one first
    if [ -f "$(dirname "$best")/danik_hybrid_ports_ui" ]; then
        mkdir -p "$(dirname "$UI")"
        cp -f "$(dirname "$best")/danik_hybrid_ports_ui" "$UI.new" && chmod +x "$UI.new" && mv -f "$UI.new" "$UI"
    fi
    cp -f "$best" "$SELF.new" && chmod +x "$SELF.new" && mv -f "$SELF.new" "$SELF" || return 1
    log "installed version $bestv from $best"
}

installed_ports() {
    local f
    for f in "$DNK"/*/"$LAUNCHER"; do
        [ -f "$f" ] && basename "$(dirname "$f")"
    done
}

# ports of the old layout: games/<engine>/ with a launch script
old_ports() {
    local f
    for f in "$GAMES"/*/"$LAUNCHER"; do
        [ -f "$f" ] || continue
        f=$(basename "$(dirname "$f")")
        [ "$f" != dnk ] && echo "$f"
    done
}

# ── migration ────────────────────────────────────────────────────────
#
# A port of the old layout (games/<engine>/ with a launch script) is moved
# once its new files are there (_Other/dnk/dnk-<engine>_*.rbf and games/dnk/
# <engine>/danik_hybrid_launch.sh) and no game is running:
#   - _Other/<engine>_YYYYMMDD.rbf: deleted
#   - games/<engine>/: what the player put there (data, settings, saved games)
#     is moved into games/dnk/<engine>/; a file the new port has as well is
#     one of the port's own, the new one stays and the old one goes; the old
#     folder is gone then
#   - logs/<engine>/: into logs/dnk/<engine>/
#   - a port with several games (menu entries with set names): the core's
#     settings and button mappings (config/<engine>.CFG, <engine>_volume.cfg,
#     config/inputs/<engine>_input_*, <engine>_advanced_input_*) are copied to
#     each game's name, where it has none yet; the originals stay
#   - DXXRebirth: the data of games/d1x-rebirth/ and games/d2x-rebirth/ (the
#     folders of its first versions) into games/dnk/DXXRebirth/, their
#     missions into descent/missions/ and descent2/missions/ there
# Nothing else is touched: a folder without our launch script is not ours.

# Moves the files of `from` into `to`, the same paths; where `to` has a file
# already, the one of `from` goes. Empty folders of `from` go.
merge_into() {
    local from=$1 to=$2 f rel
    [ -d "$from" ] || return 0
    mkdir -p "$to" || return 1
    while IFS= read -r -d '' f; do
        rel=${f#"$from"/}
        if [ -e "$to/$rel" ] || [ -L "$to/$rel" ]; then
            rm -f "$f"
        else
            mkdir -p "$(dirname "$to/$rel")" && mv -f "$f" "$to/$rel"
        fi
    done < <(find "$from" \( -type f -o -type l \) -print0)
    find "$from" -depth -type d -empty -delete 2>/dev/null
}

# Like merge_into, but a file `to` has already stays where it was in `from`:
# for data that is the player's on both sides
merge_keep() {
    local from=$1 to=$2 f rel
    [ -d "$from" ] || return 0
    mkdir -p "$to" || return 1
    while IFS= read -r -d '' f; do
        rel=${f#"$from"/}
        if [ -e "$to/$rel" ] || [ -L "$to/$rel" ]; then
            note "  kept $f: games/dnk has a $rel already"
        else
            mkdir -p "$(dirname "$to/$rel")" && mv -f "$f" "$to/$rel"
        fi
    done < <(find "$from" \( -type f -o -type l \) -print0)
    find "$from" -depth -type d -empty -delete 2>/dev/null
}

# the set names of an engine's menu entries: <setname>s of the MGLs that load
# _Other/dnk/dnk-<engine>
sets_of() {
    local engine=$1 f
    for f in "$OTHER"/*.mgl; do
        [ -f "$f" ] || continue
        grep -qi "<rbf>_Other/dnk/dnk-$engine</rbf>" "$f" || continue
        sed -n 's/.*<setname[^>]*>\([^<]*\)<\/setname>.*/\1/p' "$f" | head -n 1
    done | sort -u
}

copy_settings() {
    local engine=$1 set f base
    for set in $(sets_of "$engine"); do
        valid_name "$set" || continue
        for f in "$CONFIG/$engine.CFG" "$CONFIG/${engine}_volume.cfg" \
                 "$CONFIG/inputs/${engine}_input_"* "$CONFIG/inputs/${engine}_advanced_input_"*; do
            [ -f "$f" ] || continue
            base=$(basename "$f")
            base=$set${base#"$engine"}
            if [ ! -e "$(dirname "$f")/$base" ]; then
                cp -p "$f" "$(dirname "$f")/$base" && note "  $(basename "$f") -> $base"
            fi
        done
    done
}

dxx_folders() {
    local n
    for n in 1 2; do
        [ -d "$GAMES/d${n}x-rebirth" ] || continue
        note "  games/d${n}x-rebirth -> games/dnk/DXXRebirth/"
        merge_keep "$GAMES/d${n}x-rebirth/missions" "$DNK/DXXRebirth/descent$([ $n = 2 ] && echo 2)/missions"
        merge_keep "$GAMES/d${n}x-rebirth" "$DNK/DXXRebirth"
        rmdir "$GAMES/d${n}x-rebirth" 2>/dev/null
    done
}

migrate_port() {
    local engine=$1 rbf
    note "moving $engine to the new layout"
    for rbf in "$OTHER/$engine"_[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].rbf; do
        [ -f "$rbf" ] && rm -f "$rbf" && note "  deleted _Other/$(basename "$rbf")"
    done
    # the old launcher's copy, then the rest (the old launch script with it:
    # the new port has one)
    rm -f "$GAMES/$engine/$OLD_MARK"
    merge_into "$GAMES/$engine" "$DNK/$engine"
    [ -d "$GAMES/$engine" ] && note "  games/$engine is still there" || note "  games/$engine -> games/dnk/$engine"
    if [ -d "$LOGS/$engine" ]; then
        merge_into "$LOGS/$engine" "$LOGS/dnk/$engine"
        note "  logs/$engine -> logs/dnk/$engine"
    fi
    copy_settings "$engine"
    [ "$engine" = DXXRebirth ] && dxx_folders
}

# Every port of the old layout whose new files are there. True if one moved.
migrate_all() {
    local engine new f moved=1
    for engine in $(old_ports); do
        new=
        for f in "$OTHER/dnk/dnk-$engine"_*.rbf; do
            [ -f "$f" ] && new=1
        done
        [ -n "$new" ] && [ -f "$DNK/$engine/$LAUNCHER" ] || continue
        migrate_port "$engine"
        moved=0
    done
    # DXXRebirth's first folders, also after DXXRebirth itself has moved
    if [ -f "$DNK/DXXRebirth/$LAUNCHER" ] && { [ -d "$GAMES/d1x-rebirth" ] || [ -d "$GAMES/d2x-rebirth" ]; }; then
        dxx_folders
        moved=0
    fi
    return $moved
}

# ── daemon ───────────────────────────────────────────────────────────

CHILD=

child_alive() {
    [ -n "$CHILD" ] && kill -0 "$CHILD" 2>/dev/null
}

stop_child() {
    local _
    [ -z "$CHILD" ] && return
    # the launcher leads its own process group (setsid): this reaches the game too
    if kill -TERM -- "-$CHILD" 2>/dev/null; then
        for _ in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
            kill -0 -- "-$CHILD" 2>/dev/null || break
            sleep 0.1
        done
        kill -KILL -- "-$CHILD" 2>/dev/null && log "had to kill the launcher of $CORE"
    fi
    wait "$CHILD" 2>/dev/null
    CHILD=
}

run_daemon() {
    local cur stamp self_stamp tick changed

    echo $$ > "$PIDFILE"
    trap 'stop_child; rm -f "$PIDFILE"; exit 0' TERM INT
    [ "$(wc -c < "$LOG" 2>/dev/null || echo 0)" -gt 200000 ] && mv -f "$LOG" "$LOG.prev"
    log "daemon started (version $VERSION, pid $$), ports: $(installed_ports | tr '\n' ' ')$(old_ports | sed 's/^/ (old) /' | tr '\n' ' ')"
    self_stamp=$(stat -c %Y "$SELF" 2>/dev/null)
    CORE=
    STAMP=
    tick=0

    while :; do
        cur=$(cat "$CORENAME" 2>/dev/null)
        # Main_MiSTer writes the file again whenever a core is loaded
        stamp=$(stat -c %Y "$CORENAME" 2>/dev/null)

        # Another core, or the same core loaded again after its launcher ended
        if [ "$cur" != "$CORE" ] || { [ "$stamp" != "$STAMP" ] && ! child_alive; }; then
            if [ -n "$CHILD" ]; then
                child_alive && log "$CORE -> $cur: stopping its launcher"
                stop_child
            fi
            CORE=$cur
            STAMP=$stamp
            if launcher_of "$cur"; then
                log "$cur loaded: starting $LAUNCH"
                MISTER_HYBRID_SET=$cur setsid bash "$LAUNCH" >> "$LOG" 2>&1 < /dev/null &
                CHILD=$!
            fi
        elif child_alive; then
            STAMP=$stamp
        elif [ -n "$CHILD" ]; then
            wait "$CHILD" 2>/dev/null
            log "launcher of $CORE ended (exit code $?)"
            CHILD=
        fi

        # Between games (a port that is still loaded would be started again):
        # ports of the old layout whose new files have come, every 10 seconds;
        # a newer version of this file, which can have been installed over
        # this file or have come with a port; an older file installed over
        # this one is replaced by the newest copy the same way.
        if [ -z "$CHILD" ] && ! launcher_of "$CORE"; then
            tick=$((tick + 1))
            [ $((tick % 20)) -eq 1 ] && migrate_all
            changed=
            [ "$(stat -c %Y "$SELF" 2>/dev/null)" != "$self_stamp" ] && changed=1
            if [ -n "$changed" ] || [ $((tick % 20)) -eq 0 ]; then
                adopt_newest && changed=1
            fi
            if [ -n "$changed" ] && [ -f "$SELF" ]; then
                log "restarting with the new $SELF"
                exec bash "$SELF" daemon
            fi
        fi
        sleep 0.5
    done
}

# ── choosing the ports ──────────────────────────────────────────────

# a tag as Downloader compares them: lower case, without - and _
norm() {
    echo "$1" | tr 'A-Z' 'a-z' | tr -d '_-'
}

# Our section's filter (empty: none, or no filter): the drop-in file's, or
# one in downloader.ini (which Downloader prefers, when both are there)
section_filter() {
    local f
    for f in "$DOWNLOADER_INI" "$DROP_IN"; do
        awk -v id="[$DB_ID]" '
            /^[ \t]*\[/ { line = tolower($0); sub(/^[ \t]+/, "", line); inside = (index(line, tolower(id)) == 1); if (inside) found = 1; next }
            inside && /^[ \t]*filter[ \t]*=/ { sub(/^[ \t]*filter[ \t]*=[ \t]*/, ""); print; exit }
            END { if (!found) exit 1 }' "$f" 2>/dev/null && return 0
    done
    return 1
}
in_main_ini() {
    grep -qiF "[$DB_ID]" "$DOWNLOADER_INI" 2>/dev/null
}
has_section() {
    in_main_ini || grep -qiF "[$DB_ID]" "$DROP_IN" 2>/dev/null
}

# The drop-in file with the filter $1; a section of ours in downloader.ini
# moves out of it (the rest of that file is left as it is)
write_section() {
    local tmp="$DOWNLOADER_INI.danik_hybrid_ports.tmp"
    printf '%s (Scripts menu): its screen writes the filter\n[%s]\ndb_url = %s\nfilter = %s\n' \
        "$CHOSEN" "$DB_ID" "$DB_URL" "$1" > "$DROP_IN.tmp" && mv -f "$DROP_IN.tmp" "$DROP_IN"
    if in_main_ini; then
        awk -v id="[$DB_ID]" '
            /^[ \t]*\[/ { line = tolower($0); sub(/^[ \t]+/, "", line); skip = (index(line, tolower(id)) == 1) }
            !skip' "$DOWNLOADER_INI" > "$tmp"
        # no empty lines left at the end
        sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$tmp"
        mv -f "$tmp" "$DOWNLOADER_INI"
        note "moved [$DB_ID] from downloader.ini into $(basename "$DROP_IN")"
    fi
}

# The games to offer, engine|game|title: the catalogue, or without it the
# ports there are
catalogue() {
    local f engine
    if [ -s "$CATALOGUE" ]; then
        grep -v '^#' "$CATALOGUE" | grep '|'
        return
    fi
    for f in "$DNK"/*/games.txt; do
        [ -f "$f" ] || continue
        engine=$(basename "$(dirname "$f")")
        grep -v '^#' "$f" | grep '|' | sed "s/^/$engine|/"
    done
    for f in "$DNK"/*/"$LAUNCHER" "$GAMES"/*/"$LAUNCHER"; do
        [ -f "$f" ] || continue
        engine=$(basename "$(dirname "$f")")
        [ -f "$DNK/$engine/games.txt" ] && continue
        [ "$f" = "$GAMES/$engine/$LAUNCHER" ] && [ -f "$DNK/$engine/$LAUNCHER" ] && continue
        echo "$engine|$engine|$engine"
    done
}

# What to show: the settings, then every game of the catalogue, ticked as the
# filter has it once the player has chosen (CHOSEN in the drop-in file, which
# the file as it is shipped does not have); before, the ports there are
# (either layout).
CHOSEN="# chosen with danik_hybrid_ports.sh"
make_table() {
    local filter terms engine game title t found
    filter=$(section_filter)
    { grep -qsF "$CHOSEN" "$DROP_IN" || in_main_ini; } && found=1
    terms=" $(for t in $filter; do norm "$t"; done | tr '\n' ' ') "
    printf 'S\tlauncher\t%d\tLauncher\n' "$(grep -qsF "$MARK" "$STARTUP" && echo 1 || echo 0)"
    catalogue | tr -d '\r' | while IFS='|' read -r engine game title; do
        [ -n "$engine" ] || continue
        t=0
        if [ -n "$found" ]; then
            case "$terms" in
                *" $(norm "$engine") "* | *" $(norm "${engine}_$game") "*) t=1 ;;
            esac
        elif [ -f "$DNK/$engine/$LAUNCHER" ] || [ -f "$GAMES/$engine/$LAUNCHER" ]; then
            t=1
        fi
        printf 'G\t%s\t%s\t%d\t%s\n' "$engine" "$game" "$t" "$title"
    done
}

# The filter for what is ticked in a table: launcher, and per port its name
# when all its games are ticked, else the tags of those that are
filter_of() {
    awk -F '\t' '
        $1 == "G" { n[$2]++; if ($4 == 1) { on[$2]++; games[$2] = games[$2] " " tolower($2 "_" $3) } ; if (!($2 in seen)) { seen[$2] = 1; order[++k] = $2 } }
        END {
            out = "launcher"
            for (i = 1; i <= k; i++) { e = order[i]
                if (on[e] == n[e]) out = out " " tolower(e)
                else if (on[e] > 0) out = out games[e] }
            print out }' "$1"
}

setting_of() {
    awk -F '\t' -v k="$2" '$1 == "S" && $2 == k { print $3 }' "$1"
}

# The screen; over SSH, or without the program, dialog. Leaves the table the
# player chose in $1.out; true if they applied.
choose() {
    local table=$1 ui code
    if [ -x "$UI" ]; then
        # from a copy: Downloader may replace the program while it runs
        ui=$TMP/danik_hybrid_ports_ui
        cp -f "$UI" "$ui" 2>/dev/null && chmod +x "$ui"
        "$ui" main --keep $UI_ARGS --table "$table" --out "$table.out"
        code=$?
        [ $code -eq 0 ] && return 0
        [ $code -eq 10 ] && { "$ui" release $UI_ARGS; return 1; }
    fi
    choose_dialog "$table"
}

choose_dialog() {
    local table=$1 items=() kind key t label picked line
    command -v dialog > /dev/null || { echo "No screen to choose on (no framebuffer, no dialog)."; return 1; }
    while IFS=$'\t' read -r kind key t label rest; do
        case "$kind" in
            S) items+=("S:$key" "$label" "$([ "$t" = 1 ] && echo on || echo off)") ;;
            G) items+=("G:$key:$t" "$key: $rest" "$([ "$label" = 1 ] && echo on || echo off)") ;;
        esac
    done < "$table"
    picked=$(dialog --stdout --separate-output --title "Hybrid Ports" \
        --checklist "Space ticks, Enter applies:" 22 70 15 "${items[@]}") || return 1
    : > "$table.out"
    while IFS=$'\t' read -r kind key t label rest; do
        case "$kind" in
            S) line="S:$key"; t=0; echo "$picked" | grep -qxF "$line" && t=1
               printf 'S\t%s\t%d\t%s\n' "$key" "$t" "$label" >> "$table.out" ;;
            G) line="G:$key:$t"; label=0; echo "$picked" | grep -qxF "$line" && label=1
               printf 'G\t%s\t%s\t%d\t%s\n' "$key" "$t" "$label" "$rest" >> "$table.out" ;;
        esac
    done < "$table"
}

# What the player chose: the launcher on or off, the filter written, and
# Downloader run for it
apply() {
    local out=$1 filter updater ui=$TMP/danik_hybrid_ports_ui
    if [ "$(setting_of "$out" launcher)" = 1 ]; then
        register
        start_daemon
    else
        stop_daemon
        unregister
    fi
    filter=$(filter_of "$out")
    write_section "$filter"
    note "$(basename "$DROP_IN"): filter = $filter"
    updater=$ROOT/Scripts/update.sh
    if [ ! -f "$updater" ]; then
        updater=
    fi
    if [ -x "$ui" ] && "$ui" probe $UI_ARGS; then
        if [ -n "$updater" ]; then
            "$ui" run $UI_ARGS -- bash "$updater" --run-only "$DB_ID"
        else
            "$ui" run $UI_ARGS -- sh -c 'echo "Scripts/update.sh is not there. Run update_all to install and remove the ports."; exit 1'
        fi
    elif [ -n "$updater" ]; then
        bash "$updater" --run-only "$DB_ID"
    else
        echo "Scripts/update.sh is not there. Run update_all to install and remove the ports."
    fi
    # what came is moved in at once
    migrate_all
}

configure() {
    local table=$TMP/danik_hybrid_ports.table
    make_table > "$table"
    if choose "$table"; then
        apply "$table.out"
    fi
    rm -f "$table" "$table.out"
}

# ── commands ─────────────────────────────────────────────────────────

start_daemon() {
    [ -n "$(daemon_pid)" ] && return 0
    setsid bash "$SELF" daemon > /dev/null 2>&1 < /dev/null &
    sleep 0.3
}

stop_daemon() {
    local pid _
    pid=$(daemon_pid)
    [ -z "$pid" ] && return 0
    kill -TERM "$pid" 2>/dev/null
    for _ in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30; do
        kill -0 "$pid" 2>/dev/null || break
        sleep 0.1
    done
    kill -KILL "$pid" 2>/dev/null
    rm -f "$PIDFILE"
}

register() {
    grep -qsF "$MARK" "$STARTUP" && return 0
    [ -f "$STARTUP" ] || { mkdir -p "$(dirname "$STARTUP")" && printf '#!/bin/sh\n' > "$STARTUP"; }
    # shellcheck disable=SC2016  # $1 is for user-startup.sh
    printf '\n# Hybrid ports: starts the game when its core is loaded\n[[ -e %s ]] && %s $1\n' "$SELF" "$SELF" >> "$STARTUP"
    chmod +x "$STARTUP" 2>/dev/null
}

unregister() {
    [ -f "$STARTUP" ] || return 0
    sed -i "/# Hybrid ports: starts the game when its core is loaded/d; /$MARK/d" "$STARTUP"
}

# Version 2, danik_hybrid_cores.sh: stopped (with its game), out of
# user-startup.sh, its script gone. Its copies in the ports' old folders go
# with the migration.
take_over() {
    local pid _ found=
    pid=$(cat "$OLD_PIDFILE" 2>/dev/null)
    if [ -n "$pid" ] && grep -qs "$OLD_MARK" "/proc/$pid/cmdline"; then
        kill -TERM "$pid" 2>/dev/null
        for _ in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30; do
            kill -0 "$pid" 2>/dev/null || break
            sleep 0.1
        done
        kill -KILL "$pid" 2>/dev/null
        rm -f "$OLD_PIDFILE"
        found=1
    fi
    if grep -qsF "$OLD_MARK" "$STARTUP"; then
        sed -i "/# Hybrid cores: starts the game when its core is loaded/d; /$OLD_MARK/d" "$STARTUP"
        found=1
    fi
    if [ -f "$ROOT/Scripts/$OLD_MARK" ]; then
        rm -f "$ROOT/Scripts/$OLD_MARK"
        found=1
    fi
    [ -n "$found" ] && note "took over from $OLD_MARK"
}

status() {
    local pid ports old
    pid=$(daemon_pid)
    ports=$(installed_ports | tr '\n' ' ')
    old=$(old_ports | tr '\n' ' ')
    echo "danik_hybrid_ports version $VERSION"
    if [ -n "$pid" ]; then echo "  running (pid $pid)"; else echo "  not running"; fi
    if grep -qsF "$MARK" "$STARTUP"; then echo "  starts with the MiSTer"; else echo "  does not start with the MiSTer"; fi
    echo "  hybrid ports installed: ${ports:-none}"
    [ -n "$old" ] && echo "  of the old layout, moved when their new files come: $old"
}

main() {
    # a port brought a newer version: install it and let it do the rest
    case "$1" in
        "" | start | restart)
            adopt_newest && exec bash "$SELF" "$@"
            ;;
    esac
    case "$1" in
        daemon)
            run_daemon
            ;;
        start)
            start_daemon
            ;;
        stop)
            stop_daemon
            ;;
        restart)
            stop_daemon
            start_daemon
            ;;
        remove)
            stop_daemon
            unregister
            echo "danik_hybrid_ports is stopped and removed from $STARTUP."
            echo "Hybrid ports no longer start their games."
            ;;
        migrate)
            migrate_all || echo "Nothing to move."
            ;;
        status)
            status
            ;;
        "")
            # set up; a running daemon is replaced so a new version takes over,
            # unless a game is being played
            take_over
            register
            if [ -n "$(daemon_pid)" ] && launcher_of "$(cat "$CORENAME" 2>/dev/null)"; then
                : # the daemon switches to the new file by itself after the game
            else
                stop_daemon
                migrate_all
            fi
            start_daemon
            configure
            ;;
        config)
            configure
            ;;
        takeover)
            # as the first run, without the screen
            take_over
            register
            if [ -n "$(daemon_pid)" ] && launcher_of "$(cat "$CORENAME" 2>/dev/null)"; then
                :
            else
                stop_daemon
                migrate_all
            fi
            start_daemon
            ;;
        *)
            echo "usage: $0 [start|stop|restart|remove|migrate|status|config|takeover]"
            return 1
            ;;
    esac
}

# keep this on one line: bash must have read the whole file before it runs
main "$@"; exit $?
