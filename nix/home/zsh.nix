{ pkgs, ... }:

{
    xdg.enable = true;
    programs.zsh = {
        enable = true;

        initContent = ''
            function __execute () {
                source $ZDOTDIR/$1
            }

            __execute "env.zsh"
            __execute "utils.zsh"
            __execute "external_command.zsh"

            if __is_command_available sheldon; then
                1=
                eval "$(sheldon source)"
            fi

            __execute "prompt.zsh"
            __execute "misc.zsh"
            __execute "alias.zsh"
        '';
    };
    home.packages = with pkgs; [
        sheldon
    ];
    # same as env.sh
    home.sessionVariables = {
        ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
        SHELDON_CONFIG_DIR  = "$ZDOTDIR/sheldon";
        SHELDON_CONFIG_FILE = "$ZDOTDIR/sheldon/plugins.toml";
    };
    xdg.configFile."zsh" = {
        source = ./zsh;
        recursive = true;
    };
}

