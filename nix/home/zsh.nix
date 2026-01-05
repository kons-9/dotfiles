{ pkgs, config, ... }:

{
    xdg.enable = true;
    programs.zsh = {
        enable = true;
        envExtra = ''
            export XDG_CONFIG_HOME="${config.xdg.configHome}"
            export XDG_DATA_HOME="${config.xdg.dataHome}"
            export XDG_CACHE_HOME="${config.xdg.cacheHome}"

            export ZDOTDIR="${config.xdg.configHome}/zsh"

            export CARGO_HOME="${config.xdg.dataHome}/rust/cargo"
            export RUSTUP_HOME="${config.xdg.dataHome}/rust/rustup"
            export PYTHONSTARTUP="${config.xdg.configHome}/python/startup.py"
            export NVM_DIR="${config.xdg.configHome}/nvm"

            export SHELDON_CONFIG_DIR="$ZDOTDIR/../zsh-manual/sheldon"
            export SHELDON_CONFIG_FILE="$SHELDON_CONFIG_DIR/plugins.toml"

            export DENO_INSTALL="${config.xdg.dataHome}/deno"

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

