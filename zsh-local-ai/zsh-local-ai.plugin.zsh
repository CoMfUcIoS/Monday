#!/bin/zsh

create_completion() {
    text=${BUFFER}
    completion=$(echo -n "$text" | $ZSH_CUSTOM/plugins/zsh-local-ai/create_completion.py $CURSOR)
    text_before_cursor=${text:0:$CURSOR}
    text_after_cursor=${text:$CURSOR}
    BUFFER="${text_before_cursor}${completion}${text_after_cursor}"
    prefix_and_completion="${text_before_cursor}${completion}"
    CURSOR=${#prefix_and_completion}
}

zle -N create_completion
