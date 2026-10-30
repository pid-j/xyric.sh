#!/usr/bin/env bash

XYRIC_REWRITE=0
declare -i XYRIC_REWRITE

XYRIC_POINTER=0
declare -i XYRIC_POINTER

XYRIC_POINTER_WATCH_LATER=-1
declare -i XYRIC_POINTER_WATCH_LATER

# set to 0 to hide controls by default;
# set to 1 to show controls by default
XYRIC_SHOW_CONTROLS=0
declare -i XYRIC_SHOW_CONTROLS

XYRIC_SELECTION=(
    'The Blueberry Virus'
    'elemelontol'
    'Lord of the Rings'
    'Sonic the Hedgehog'
    'red.'
)

XYRIC_WATCH_LATER=()

_xyric-change-ptr() {
    if [[ $XYRIC_POINTER_WATCH_LATER -eq -1 ]]; then
        ((XYRIC_POINTER += $1))

        if [[ $XYRIC_POINTER -lt 0 ]]; then
            XYRIC_POINTER=0
            XYRIC_REWRITE=0
            return
        fi

        [[ $XYRIC_POINTER -ge ${#XYRIC_SELECTION[@]} ]] || return

        if [[ ${#XYRIC_WATCH_LATER[@]} -gt 0 ]]; then
            XYRIC_POINTER=-1
            XYRIC_POINTER_WATCH_LATER=0
            return
        fi

        XYRIC_POINTER=$(( ${#XYRIC_SELECTION[@]} - 1 ))
        XYRIC_REWRITE=0

        return
    fi

    ((XYRIC_POINTER_WATCH_LATER += $1))

    if [[ $XYRIC_POINTER_WATCH_LATER -lt 0 ]]; then
        XYRIC_POINTER=$(( ${#XYRIC_SELECTION[@]} - 1 ))
        XYRIC_POINTER_WATCH_LATER=-1
        return
    fi

    [[ $XYRIC_POINTER_WATCH_LATER -ge ${#XYRIC_WATCH_LATER[@]} ]] || return

    XYRIC_POINTER_WATCH_LATER=$(( ${#XYRIC_WATCH_LATER[@]} - 1 ))
    XYRIC_REWRITE=0
}

_xyric-init-altbuf() {
    printf -- '\e[?1049h' # enter altbuf
    printf -- '\e[1;1H'   # move to top-left
    printf -- '\e[0J'     # clear screen
}

_xyric-deinit-altbuf() {
    printf -- '\e[?1049l' # leave altbuf
}

_xyric-current-hovered() {
    if [[ $XYRIC_POINTER -gt -1 ]]; then
        printf -- '%s' "${XYRIC_SELECTION[$XYRIC_POINTER]}"
        return
    fi

    printf -- '%s' "${XYRIC_WATCH_LATER[$XYRIC_POINTER_WATCH_LATER]}"
}

_xyric-logo() {
    if [[ $COLORTERM = 'truecolor' ]]; then
        printf -- '  \e[38;2;255;136;11m██████      ████████████████████████    \e[0m\n'
        printf -- '  \e[38;2;255;130;17m████████      ████████████████████      \e[0m\n'
        printf -- '  \e[38;2;255;124;22m██████████      ████████████████        \e[0m\n'
        printf -- '  \e[38;2;255;117;27m████████████      ████████████          \e[0m\n'
        printf -- '  \e[38;2;255;110;32m██████████████        ████          ████\e[0m\n'
        printf -- '  \e[38;2;255;105;37m████████████████                  ██████\e[0m\n'
        printf -- '  \e[38;2;255;97;042m██████████████████            ██████████\e[0m\n'
        printf -- '  \e[38;2;255;92;047m██████████████████          ████████████\e[0m\n'
        printf -- '  \e[38;2;255;85;053m████████████████        ████████████████\e[0m\n'
        printf -- '  \e[38;2;255;78;057m██████████████        ██████████████████\e[0m\n'
        printf -- '  \e[38;2;255;72;063m██████████████        ██████████████████\e[0m\n'
        printf -- '  \e[38;2;255;65;068m████████████████        ████████████████\e[0m\n'
        printf -- '  \e[38;2;255;60;074m██████████████████          ████████████\e[0m\n'
        printf -- '  \e[38;2;255;53;078m██████████████████            ██████████\e[0m\n'
        printf -- '  \e[38;2;255;46;083m████████████████                  ██████\e[0m\n'
        printf -- '  \e[38;2;255;40;089m██████████████        ████          ████\e[0m\n'
        printf -- '  \e[38;2;255;33;094m████████████      ████████████          \e[0m\n'
        printf -- '  \e[38;2;255;27;099m██████████      ████████████████        \e[0m\n'
        printf -- '  \e[38;2;255;21;104m████████      ████████████████████      \e[0m\n'
        printf -- '  \e[38;2;255;14;109m██████      ████████████████████████    \e[0m\n'
    else
        printf -- '  ██████      ████████████████████████    \n'
        printf -- '  ████████      ████████████████████      \n'
        printf -- '  ██████████      ████████████████        \n'
        printf -- '  ████████████      ████████████          \n'
        printf -- '  ██████████████        ████          ████\n'
        printf -- '  ████████████████                  ██████\n'
        printf -- '  ██████████████████            ██████████\n'
        printf -- '  ██████████████████          ████████████\n'
        printf -- '  ████████████████        ████████████████\n'
        printf -- '  ██████████████        ██████████████████\n'
        printf -- '  ██████████████        ██████████████████\n'
        printf -- '  ████████████████        ████████████████\n'
        printf -- '  ██████████████████          ████████████\n'
        printf -- '  ██████████████████            ██████████\n'
        printf -- '  ████████████████                  ██████\n'
        printf -- '  ██████████████        ████          ████\n'
        printf -- '  ████████████      ████████████          \n'
        printf -- '  ██████████      ████████████████        \n'
        printf -- '  ████████      ████████████████████      \n'
        printf -- '  ██████      ████████████████████████    \n'
    fi
}

_xyric-goto-logo-end() {
    printf -- '\e[21;1H'
}

_xyric-handle-input() {
    local input=

    read -r -n1 -s input
    [[ -z "$input" ]] && return 1

    if [[ "$input" = $'\e' ]]; then
        # if read fails due to timeout we can be sure only ESC was outputted to stdin
        if read -r -n2 -s -t0.05 input; then
            input='^['"$input"
        else
            input='^['
        fi
    elif [[ "$input" = $'\x7f' ]]; then
        input='^?'
    fi

    case "$input" in
        '^[[A'|w|W)
            # up arrow or W
            _xyric-change-ptr -1;;
        '^[[B'|s|S)
            # down arrow or S
            _xyric-change-ptr 1;;
        '^[[C'|d|D)
            # right arrow or D
            # Source - https://stackoverflow.com/a/47541882
            # Posted by Jellicle, modified by community. See post 'Timeline' for change history
            # Retrieved 2026-10-29, License - CC BY-SA 4.0
            if ! printf -- '%s\0' "${XYRIC_WATCH_LATER[@]}" | grep -Fxqz -- "$(_xyric-current-hovered)"; then
                XYRIC_WATCH_LATER+=("$(_xyric-current-hovered)")
                XYRIC_REWRITE=1
            fi;;
        '^[[D'|a|A)
            # left arrow or A
            local delindex

            for delindex in "${!XYRIC_WATCH_LATER[@]}"; do
                if [[ "${XYRIC_WATCH_LATER[$delindex]}" = "$(_xyric-current-hovered)" ]]; then
                    unset -- "XYRIC_WATCH_LATER[$delindex]"
                    [[ $XYRIC_POINTER_WATCH_LATER -gt -1 ]] && _xyric-change-ptr -1

                    XYRIC_REWRITE=1
                    break
                fi
            done;;
        '^['|'^?'|q|Q)
            # backspace, delete, escape, or Q
            local state

            _xyric-goto-logo-end
            printf -- '\e[0J'  # clear screen
            printf -- '\n'

            read -p $'  Are you sure you want to exit (\e[1;92mY\e[0m/\e[1;91mn\e[0m)? ' -r -N1 -s state || return 1

            if [[ $state = 'y' ]] || [[ $state = 'Y' ]]; then
              _xyric-deinit-altbuf # we don't have to do this because we trapped exit but just to make sure
              exit
            fi;;
        r|R)
            # R - fully refresh screen
            _xyric-init-altbuf

            _xyric-logo
            printf '\n'

            XYRIC_REWRITE=1;;
        c|C)
            # C - view credits
            _xyric-goto-logo-end
            printf -- '\e[0J'
            printf -- '\n'

            printf -- '  Xyric originally by \e[1;92m@DeafyLeaf\e[0m:\n'
            printf -- '    \e[1;94mhttps://scratch.mit.edu/projects/894909530\e[0m\n'

            printf -- '\n'

            printf -- '  Xyric for Bash:\n'
            printf -- '    inspired by \e[1;92m@cat_Eatacat\e[0m'"'"'s Xyric ports:\n'
            printf -- '      \e[1;94mhttps://scratch.mit.edu/studios/35530438\e[0m\n'
            printf -- '    developed by \e[1;92m@0x1194\e[0m:\n'
            printf -- '      \e[1;94mhttps://pid-j.github.io/xyric.sh\e[0m\n'

            printf -- '\n'

            read -p '  Press any key to return.' -r -N1 -s
            XYRIC_REWRITE=1;;
        h|H)
            # H - toggle controls visibility
            XYRIC_SHOW_CONTROLS=$((1 - XYRIC_SHOW_CONTROLS))
            XYRIC_REWRITE=1;;
        $'\n'|' ')
            # enter key or space - not impl'd because xyric doesn't have playback
            # would be cool if xyric actually had real movies...
            # ...but we probably aren't getting that soon
            return;;
        *) return 1;;
    esac
}

_xyric-rewrite() {
    _xyric-goto-logo-end
    printf -- '\e[0J' # clear screen

    printf -- '\n'

    printf -- '  \e[1;92mXyric'"'"'s Picks\e[0m\n'

    local index value
    for index in "${!XYRIC_SELECTION[@]}"; do
        value="${XYRIC_SELECTION[$index]}"

        printf -- '  '

        if [[ $XYRIC_POINTER -eq $index ]] && [[ $XYRIC_POINTER_WATCH_LATER -eq -1 ]]; then
            printf -- '\e[1;94m>> %s\e[0m' "$value"
            printf -- '\e7' # save cursor position so the cursor can go there
        else
            printf -- '- %s' "$value"
        fi

        printf -- '\n'
    done

    printf -- '\n  \e[1;92mWatch Later\e[0m\n'

    if [[ ${#XYRIC_WATCH_LATER[@]} -eq 0 ]]; then
        printf -- '  None yet...\n'
    fi

    for index in "${!XYRIC_WATCH_LATER[@]}"; do
        value="${XYRIC_WATCH_LATER[$index]}"
        printf -- '  '

        if [[ $XYRIC_POINTER_WATCH_LATER -eq $index ]]; then
            printf -- '\e[1;94m>> %s\e[0m' "$value"
            printf -- '\e7' # save cursor position so the cursor can go there
        else
            printf -- '- %s' "$value"
        fi

        printf -- '\n'
    done

    printf -- '\n'

    if [[ $XYRIC_SHOW_CONTROLS -gt 0 ]]; then
      printf -- '  \e[7mW/^Up\e[0m: Scroll up\n'
      printf -- '  \e[7mS/^Dn\e[0m: Scroll down\n'
      printf -- '  \e[7mD/^Rt\e[0m: Add to watch later\n'
      printf -- '  \e[7mA/^Lf\e[0m: Remove from watch later\n'
      printf -- '  \e[7mQ/ESC\e[0m: Quit\n'
      printf -- '  \e[7mR\e[0m: Full refresh\n'
      printf -- '  \e[7mC\e[0m: View credits\n'
      printf -- '  \e[7mH\e[0m: Hide controls\n'
    else
      printf -- '  Press \e[7mH\e[0m to show controls\n'
    fi

    printf -- '\e8' # go to the cursor position we saved
}

xyric() {
    trap _xyric-deinit-altbuf EXIT
    _xyric-init-altbuf

    _xyric-logo
    printf '\n'

    trap _xyric-rewrite WINCH
    _xyric-rewrite

    while true; do
        XYRIC_REWRITE=1
        _xyric-handle-input

        [[ $XYRIC_REWRITE -gt 0 ]] && _xyric-rewrite
    done
}

xyric "$@"
