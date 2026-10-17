#!/bin/bash
#
# danik_hybrid_cores - starts the game of a MiSTer hybrid core when its core is loaded
#
# https://github.com/ItsDanik/Hybrid_MiSTer
#
# A hybrid core is an FPGA core whose game runs on the MiSTer's ARM CPU. This
# script is what connects the two: a small daemon watches which core is loaded
# (/tmp/CORENAME) and runs /media/fat/games/<core name>/danik_hybrid_launch.sh while it is.
# The launcher is stopped when another core is loaded.
#
#   Run it once from the MiSTer's Scripts menu. That starts the daemon and
#   adds it to /media/fat/linux/user-startup.sh, so it also runs after a
#   reboot. Running it again is harmless.
#
#   Every hybrid core ships this file twice: as Scripts/danik_hybrid_cores.sh
#   and as a copy in its games folder. The copy with the highest VERSION is
#   the one that runs: the daemon installs it over the file in Scripts by
#   itself, so an older core installed later doesn't bring an old launcher
#   back and nothing has to be run again after an update.
#
#   Version 3 is the last. The hybrid ports have a new launcher,
#   danik_hybrid_ports.sh (Scripts/, and a copy in each port's games/dnk/
#   <engine>/), and bring this version along as games/dnk/danik_hybrid_cores.sh,
#   where a running version 2 finds it (games/*/) and installs it over itself.
#   As soon as the new launcher is there it hands over to it: run from the
#   Scripts menu it runs it instead; as the daemon, or started with the
#   MiSTer, it starts "danik_hybrid_ports.sh takeover" and leaves. That one
#   takes this script out of user-startup.sh and Scripts and puts itself in.
#   Without the new launcher it works as version 2 did.
#
# usage: danik_hybrid_cores.sh            set up (as from the Scripts menu)
#        danik_hybrid_cores.sh start      start the daemon (what user-startup.sh calls)
#        danik_hybrid_cores.sh stop       stop the daemon and the running game
#        danik_hybrid_cores.sh remove     stop it and take it out of user-startup.sh
#        danik_hybrid_cores.sh status
#
# For a danik_hybrid_launch.sh:
#   - it is run with bash in its own session; its output goes to the log below
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
LAUNCHER=danik_hybrid_launch.sh
CORENAME=$TMP/CORENAME
STARTUP=$ROOT/linux/user-startup.sh
PIDFILE=$TMP/danik_hybrid_cores.pid
LOG=$TMP/danik_hybrid_cores.log
MARK="danik_hybrid_cores.sh"
# the launcher that takes over from this one
NEW=$ROOT/Scripts/danik_hybrid_ports.sh

log() {
    echo "$(date '+%H:%M:%S') $*" >> "$LOG"
}

daemon_pid() {
    local pid
    pid=$(cat "$PIDFILE" 2>/dev/null)
    [ -n "$pid" ] && grep -qs "$MARK" "/proc/$pid/cmdline" && echo "$pid"
}

# Launcher of a core name, if it is a hybrid core
launcher_of() {
    case "$1" in
        "" | */* | .*) return 1 ;;
    esac
    [ -f "$GAMES/$1/$LAUNCHER" ] && echo "$GAMES/$1/$LAUNCHER"
}

# VERSION of a copy of this script
version_of() {
    sed -n 's/^VERSION=\([0-9][0-9]*\)$/\1/p' "$1" 2>/dev/null | head -n 1
}

# Installs the newest copy the hybrid cores brought along (games/*/) over this
# file, if one is newer than it. True if the file was replaced.
adopt_newest() {
    local f v best bestv
    bestv=$(version_of "$SELF")
    bestv=${bestv:-0}
    best=
    for f in "$GAMES"/*/"$MARK"; do
        [ -f "$f" ] || continue
        v=$(version_of "$f")
        if [ -n "$v" ] && [ "$v" -gt "$bestv" ]; then
            best=$f
            bestv=$v
        fi
    done
    [ -n "$best" ] || return 1
    bash -n "$best" 2>/dev/null || return 1
    cp -f "$best" "$SELF.new" && chmod +x "$SELF.new" && mv -f "$SELF.new" "$SELF" || return 1
    log "installed version $bestv from $best"
}

# The new launcher, from a port's copy if Scripts has none yet; true if it
# is there
new_launcher() {
    local f
    if [ ! -f "$NEW" ]; then
        for f in "$GAMES"/dnk/*/danik_hybrid_ports.sh; do
            [ -f "$f" ] && bash -n "$f" 2>/dev/null || continue
            cp -f "$f" "$NEW.new" && chmod +x "$NEW.new" && mv -f "$NEW.new" "$NEW" && break
        done
    fi
    [ -f "$NEW" ] && bash -n "$NEW" 2>/dev/null
}

# Hands over to the new launcher, if it is there: true if this one is to leave
hand_over() {
    new_launcher || return 1
    log "handing over to $NEW"
    rm -f "$PIDFILE"
    setsid bash "$NEW" takeover > /dev/null 2>&1 < /dev/null &
    return 0
}

installed_cores() {
    local f
    for f in "$GAMES"/*/"$LAUNCHER"; do
        [ -f "$f" ] && basename "$(dirname "$f")"
    done
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
    local cur stamp launcher self_stamp tick changed

    echo $$ > "$PIDFILE"
    trap 'stop_child; rm -f "$PIDFILE"; exit 0' TERM INT
    [ "$(wc -c < "$LOG" 2>/dev/null || echo 0)" -gt 200000 ] && mv -f "$LOG" "$LOG.prev"
    log "daemon started (version $VERSION, pid $$), hybrid cores: $(installed_cores | tr '\n' ' ')"
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
            if launcher=$(launcher_of "$cur"); then
                log "$cur loaded: starting $launcher"
                setsid bash "$launcher" >> "$LOG" 2>&1 < /dev/null &
                CHILD=$!
            fi
        elif child_alive; then
            STAMP=$stamp
        elif [ -n "$CHILD" ]; then
            wait "$CHILD" 2>/dev/null
            log "launcher of $CORE ended (exit code $?)"
            CHILD=
        fi

        # Between games (a hybrid core that is still loaded would be started
        # again): switch to a newer version of this file. It can have been
        # installed over this file or have come with a core, which is looked
        # for every 10 seconds; an older file installed over this one is
        # replaced by the newest copy the same way.
        if [ -z "$CHILD" ] && ! launcher_of "$CORE" > /dev/null; then
            tick=$((tick + 1))
            changed=
            [ "$(stat -c %Y "$SELF" 2>/dev/null)" != "$self_stamp" ] && changed=1
            if [ -n "$changed" ] || [ $((tick % 20)) -eq 0 ]; then
                adopt_newest && changed=1
                [ -z "$changed" ] && hand_over && exit 0
            fi
            if [ -n "$changed" ] && [ -f "$SELF" ]; then
                log "restarting with the new $SELF"
                exec bash "$SELF" daemon
            fi
        fi
        sleep 0.5
    done
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
    [ -f "$STARTUP" ] || printf '#!/bin/sh\n' > "$STARTUP"
    # shellcheck disable=SC2016  # $1 is for user-startup.sh
    printf '\n# Hybrid cores: starts the game when its core is loaded\n[[ -e %s ]] && %s $1\n' "$SELF" "$SELF" >> "$STARTUP"
    chmod +x "$STARTUP" 2>/dev/null
}

unregister() {
    [ -f "$STARTUP" ] || return 0
    sed -i "/# Hybrid cores: starts the game when its core is loaded/d; /$MARK/d" "$STARTUP"
}

status() {
    local pid cores
    pid=$(daemon_pid)
    cores=$(installed_cores | tr '\n' ' ')
    echo "danik_hybrid_cores version $VERSION"
    if [ -n "$pid" ]; then echo "  running (pid $pid)"; else echo "  not running"; fi
    if grep -qsF "$MARK" "$STARTUP"; then echo "  starts with the MiSTer"; else echo "  does not start with the MiSTer"; fi
    echo "  hybrid cores installed: ${cores:-none}"
}

main() {
    # the new launcher is there: it takes over
    case "$1" in
        "")
            new_launcher && exec bash "$NEW"
            ;;
        start | restart | daemon)
            hand_over && exit 0
            ;;
    esac
    # a core brought a newer version: install it and let it do the rest
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
            echo "danik_hybrid_cores is stopped and removed from $STARTUP."
            echo "Hybrid cores no longer start their games."
            ;;
        status)
            status
            ;;
        "")
            # set up; a running daemon is replaced so a new version takes over,
            # unless a game is being played
            register
            if [ -n "$(daemon_pid)" ] && launcher_of "$(cat "$CORENAME" 2>/dev/null)" > /dev/null; then
                : # the daemon switches to the new file by itself after the game
            else
                stop_daemon
            fi
            start_daemon
            status
            echo
            echo "Done. Load a hybrid core and its game starts."
            sleep 3
            ;;
        *)
            echo "usage: $0 [start|stop|restart|remove|status]"
            return 1
            ;;
    esac
}

# keep this on one line: bash must have read the whole file before it runs
main "$@"; exit $?
