# Awesomeness for for todo lists

# Disables todo checkmark in prompt
function disable_todo_prompt() {
    export _ZSH_TODO_PROMPT=false
}

# Enables todo checkmark in prompt
function enable_todo_prompt() {
    export _ZSH_TODO_PROMPT=true
}

# Set todo executable to `t` if it exists.
if [ -z "$__ZSH_TODO_EXEC" ] && which t &>/dev/null; then
    export __ZSH_TODO_EXEC="t"
fi

# If the todo executable exists and can be ran, enable it.
if [ -n "$__ZSH_TODO_EXEC" ] && which $__ZSH_TODO_EXEC &>/dev/null; then
    export _ZSH_TODO_PROMPT=true
fi

# Print a summary of the todo list.
function todo_summary() {
    lines=$(t | wc -l)

    word="are"
    plural="s"

    if [ "$lines" -eq 1 ]; then
      word="is"
      plural=""
    fi

    if [ "$lines" -gt 0 ]; then
        echo "There ${word} ${lines} item${plural} in your todo list. Run \`t´ to view them."
    fi
}

