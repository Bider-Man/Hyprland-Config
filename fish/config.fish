if status is-interactive
    # Spider-Man prompt with blue accents
    function fish_prompt
        set_color E30B0B  # Spider-Man red
        echo -n "["
        set_color FFFFFF  # Spider-Man blue
        echo -n (prompt_pwd)
        set_color 00FFFF
        echo -n "]"
        set_color 1E90FF   # Bright Spider-blue
        echo -n " ❯ "
        set_color normal
    end

    # Syntax highlighting with blue theme
    set fish_color_normal FFFFFF     # White text
    set fish_color_command E30B0B    # Spider-Man red
    set fish_color_param 1E90FF      # Bright Spider-blue
    set fish_color_error 8B0000      # Dark red
    set fish_color_autosuggestion 50C878  # Green

    # Spider-Man greeting
    function fish_greeting
        set_color 1E90FF
        echo "🕸️  With great shell power comes great web-slinging responsibility!"
    end

    # Web-swing directory navigation
    function ws
        cd $argv
        set_color FFFFFF
        echo "Web-swinging to "(pwd)
        set_color normal
    end

    # Spider-Sense file search
    function ss
        set_color 1E90FF
        echo "Spider-Sense detecting: $argv"
        find . -name "*$argv*" 2>/dev/null
    end

    # Theme-consistent man pages
    set -x LESS_TERMCAP_mb (printf "\e[38;2;11,61,143m")  # White (FFFFFF)
    set -x LESS_TERMCAP_md (printf "\e[38;2;227,11,11m")   # Spider-red (E30B0B)
    set -x LESS_TERMCAP_me (printf "\e[0m")
    set -x LESS_TERMCAP_so (printf "\e[48;2;26,26,26m")    # Dark background (1A1A1A)
    set -x LESS_TERMCAP_se (printf "\e[0m")
    set -x LESS_TERMCAP_us (printf "\e[38;2;30,144,255m")  # Bright blue (1E90FF)
    set -x LESS_TERMCAP_ue (printf "\e[0m")
end
