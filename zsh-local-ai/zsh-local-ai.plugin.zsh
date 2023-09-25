#!/bin/zsh

create_completion() {
    text=${BUFFER}
    text_before_cursor=${text:0:$CURSOR}
    text_after_cursor=${text:$CURSOR}
    spinner="/-\|"
    i=0
    set +m
    echo -ne "|"
    while [ true ]
    do
        i=$(( (i+1) %4 ))
        echo -ne "\b${spinner:$i:1}"
        sleep .1
    done &
    spinner_pid=$!
    completion=$(echo -n "$text" | $ZSH_CUSTOM/plugins/zsh-local-ai/create_completion.py $CURSOR)
    kill $spinner_pid
    wait $spinner_pid 2>/dev/null
    echo -ne "\b"
    BUFFER="${text_before_cursor}${completion}${text_after_cursor}"
    prefix_and_completion="${text_before_cursor}${completion}"
    CURSOR=${#prefix_and_completion}
}

zle -N create_completion