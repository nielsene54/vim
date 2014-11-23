set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'suan/vim-instant-markdown'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'bling/vim-airline'

call vundle#end()
set number
set shell=bash
set noswapfile

"Indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"for code folding
set foldmethod=indent
set foldlevel=99

let g:syntastic_check_on_open=1

"Make status bar appear all the time
set laststatus=2

"Settings for YouCompleteMe
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

set t_Co=256
syntax on    "syntax highlighting
filetype on  "try to detect filetype
filetype plugin indent on   "enable loading indent file for filetype
set background=dark
colorscheme distinguished
autocmd FileType tex AutoPairsDisable

"make snipmate not mapped to tab so that I can use it with youcompleteme
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

set pastetoggle=<F2>

au FileType python set omnifunc=pythoncomplete#Complete

set completeopt=menuone,longest,preview

map <leader>n :NERDTreeToggle<CR>

nmap <leader>P <Esc>:CtrlP

:set list lcs=tab:\|\ 

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" highlight characters past column 120 
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END

function FindDjangoSettings2()
    if strlen($VIRTUAL_ENV) && has('python')
        let django_check = system("pip freeze | grep -q Django")
        if v:shell_error
            "echo 'django not installed'
        else
            "echo 'django is installed'
            let output  = system("find $VIRTUAL_ENV \\( -wholename '*/lib/*' -or -wholename '*/install/' \\) -or \\( -name 'settings.py' -print0 \\) | tr '\n' ' '")
            let outarray= split(output, '[\/]\+')
            let module  = outarray[-2] . '.' . 'settings'
            let module  = outarray[-2] . '.' . 'settings'
            " let curpath = '/' . join(outarray[:-2], '/')
            execute 'python import sys, os'
            " execute 'python sys.path.append("' . curpath . '")'
            " execute 'python sys.path.append("' . syspath . '")'
            execute 'python sys.path = ' . syspath
            execute 'python os.environ.setdefault("DJANGO_SETTINGS_MODULE", "' . module . '")'
        endif
    endif
endfunction

autocmd FileType python call FindDjangoSettings2()

"vim-latex stuff
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
 set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:"

"Always compile to pdf
let g:Tex_DefaultTargetFormat='pdf'
