# ~/.config/fish/config.fish
# Spider-Man themed fish shell config

# Color Scheme
set -g fish_color_normal white
set -g fish_color_command ff0000     # Spider-Red
set -g fish_color_quote 0000ff       # Spider-Blue
set -g fish_color_param white
set -g fish_color_error ffd700       # Gold
set -g fish_color_autosuggestion 808080

# Prompt
function fish_prompt
    set -l spidey_symbol (set_color red)"🕷️ "(set_color normal)
    set -l web_line (set_color blue)"▁▂▃▄▅▆▇█"(set_color normal)
    echo -n -s $spidey_symbol (set_color red)"WEB-" (set_color blue)"SLINGER " (set_color white)"➜ "
end

# Greeting
set -g fish_greeting (set_color red)"With great power comes great responsibility!\n"(set_color blue)"🕸️  Your friendly neighborhood shell 🕸️"

# Aliases
alias spidey='echo "Thwip! 💥"'
alias webswing='curl'
alias venom='sudo'

# Path
set -gx PATH $PATH /home/$USER/.spider-tools/bin

# Vi mode
fish_vi_key_bindings
set -g fish_cursor_default block
set -g fish_cursor_insert line
