# alias
__map vi 'nvim'
__map vim 'nvim'
__map .. 'cd ..'
__map ... 'cd ../..'
__map .... 'cd ../../..'
__map ..... 'cd ../../../..'
__map ls 'ls -h'
__map ll 'ls -l'
__map cp 'cp -i'
__map mv 'mv -i'
__map rm 'rm -i'
__map la 'ls -a'
__map gs 'git status'
__map gd 'git diff'
__map sozsh 'source ~/.zshrc'
__map prevcommand 'history -1 | sed "s/^[ ]*[0-9]*[ ]*//" | cut -d " " -f 2-'

# alias for my command
function _mkdir_and_cd(){
    mkdir $1
    cd $1
}

function _measure_nvim_startup_time(){
  nvim --startuptime tmp.log +q && cat tmp.log && rm -rf tmp.log
}

function _cd_and_ls(){
  cd $1
  ls
}

function git_new_dir(){
  if [ -z "$1" ]; then
    echo "Please input the name of the repository"
    return 1
  fi
  echo "Creating a new repository $1"
  git init
  echo "# $1" > README.md
  git add README.md 
  git commit -m "first commit"
  gh repo create $1
  git remote add origin https://github.com/kons-9/$1.git
  git push --set-upstream origin main
}

__noremap mcd '_mkdir_and_cd'
__noremap mnvim '_measure_nvim_startup_time'
__noremap c '_cd_and_ls'
__noremap gnd 'git_new_dir'
