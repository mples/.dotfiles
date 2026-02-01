if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_key_bindings fish_default_key_bindings

function fish_prompt
    # Save the status of the last command immediately
    set -l last_status $status

    # Show the current directory in blue
    set_color blue
    echo -n (prompt_pwd)

    # Decide the color of the '>' based on the status
    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end

    # Print the symbol and reset color
    echo -n ' > '
    set_color normal
end
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
