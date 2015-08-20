set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"From github
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
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'Raimondi/delimitMate'
Plugin 'marijnh/tern_for_vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'vim-scripts/HTML-AutoCloseTag'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-cucumber'
Plugin 'vim-scripts/Gundo'
Plugin 'fatih/vim-go'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'SirVer/ultisnips'
Plugin 'lambdalisue/vim-django-support'
Plugin 'szw/vim-tags'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'fisadev/vim-isort'
"From vim.org
Plugin 'repmo.vim'
"color schemes
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
set number
set shell=bash
set noswapfile

"Highlight search matches
set hlsearch

"Make gdiff in fugitive.vim vertical instead of horizontal
set diffopt+=vertical

"Indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"for code folding
set foldmethod=indent
set foldlevel=99

"Shows blank lines and spaces
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list

"Custom autocmnd's
"Delete trailing whitespaces upon write
autocmd BufWritePre * :%s/\s\+$//e

let g:syntastic_check_on_open=1

"Make status bar appear all the time
set laststatus=2

"Settings for YouCompleteMe
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
"Settings for Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

"Tabs
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

set t_Co=256
syntax on    "syntax highlighting
filetype on  "try to detect filetype
filetype plugin indent on   "enable loading indent file for filetype
set background=dark
colorscheme distinguished
autocmd FileType tex AutoPairsDisable

"make ultisnips not mapped to tab so that I can use it with youcompleteme
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
"Add my snippets directory to the vim runtimepath
set runtimepath+=~/.vim/snippets

"CtrlP settings
let g:ctrlp_custom_ignore= 'node_modules\|target\|amps-standalone\|bower_components|*.pyc'
set pastetoggle=<F2>

au FileType python set omnifunc=pythoncomplete#Complete

set completeopt=menuone,longest,preview

let NERDTreeIgnore = ['\.pyc$']
map <leader>n :NERDTreeToggle<CR>

nmap <leader>P <Esc>:CtrlP

"Ctrl+C to break up {  }
imap <C-c> <CR><Esc>O

"Add virtualenv paths to ctags
map <F9> :!ctags -R -f ./tags $VIRTUAL_ENV/lib/python2.7/site-packages<CR>

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

