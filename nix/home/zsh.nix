{ pkgs, config, ... }:

{
    xdg.enable = true;
    programs.zsh = {
        enable = true;
        envExtra = ''
            export CARGO_HOME="$XDG_DATA_HOME/rust/cargo"
            export RUSTUP_HOME="$XDG_DATA_HOME/rust/rustup"
            export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
            export NVM_DIR="$XDG_CONFIG_HOME/nvm"

            export SHELDON_CONFIG_DIR="$ZDOTDIR/../zsh-manual/sheldon"
            export SHELDON_CONFIG_FILE="$SHELDON_CONFIG_DIR/plugins.toml"

            export DENO_INSTALL="$XDG_DATA_HOME/deno"

            export PATH="$DENO_INSTALL/bin:$PATH"
        '';

        initContent = ''
            # もし、自分が~/.zshrcではなくて、かつ、~/.zshrcが存在する場合は、~/.zshrcを読み込む
            is_this_path_dot_zshrc() {
                local current_script
                current_script="$(realpath "${config.xdg.configHome}/zsh/.zshrc")"
                local zshrc_path
                zshrc_path="$(realpath ~/.zshrc)"
                if [ "$current_script" = "$zshrc_path" ]; then
                    return 0
                else
                    return 1
                fi
            }
            if [ -f ~/.zshrc ] && ! is_this_path_dot_zshrc; then
                source ~/.zshrc
            fi

            if [ -f ~/.zshrc.local ]; then
                source ~/.zshrc.local
            fi
            function __execute () {
                source ${config.xdg.configHome}/zsh-manual/$1
            }

            __execute "utils.zsh"
            __execute "external_command.zsh"

            if __is_command_available sheldon; then
                eval "$(sheldon source)"
            fi

            __execute "prompt.zsh"
            __execute "misc.zsh"
            __execute "alias.zsh"
        '';
        dotDir = "${config.xdg.configHome}/zsh";
    };
    home.packages = with pkgs; [
        sheldon
    ];
    home.sessionVariables = {
    };
    xdg.configFile."zsh-manual" = {
        source = ./zsh;
        recursive = true;
    };
}

