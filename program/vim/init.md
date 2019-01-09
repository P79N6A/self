
```bash
mkdir ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# if do not install vundle
# git clone https://github.com/flazz/vim-colorschemes.git ~/.vim
```

```bash
wget https://raw.githubusercontent.com/max2max/self/master/program/vim/colors/PaperColor.vim -P ~/.vim/colors
```

```bash
cat >~/.vimrc <<EOF
filetype off
set softtabstop=4
set encoding=utf-8
set showmatch
set number
set paste
set background=light
syntax on

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Yggdroot/indentLine'
Plugin 'jiangmiao/auto-pairs'
Plugin 'python-mode/python-mode'

"Plugin 'rafi/awesome-vim-colorschemes'
"Plugin 'scrooloose/nerdtree'
"Plugin 'kristijanhusak/vim-hybrid-material'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'mswift42/vim-themes'

call vundle#end()

colorscheme PaperColor
EOF
```

```bash
cd ~/.vim/bundle/YouCompleteMe/
git submodule update --init --recursive
# or
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe/
python install.py --clang-completer --system-libclang
```

```bash
vim +PluginInstall +qall
# or
vim
:PlugInstall
:BundleClean
:BundleUpdate
:BundleList
:BundleSearch
```
