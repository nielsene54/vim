filetype off
call pathogen#infect()
call pathogen#helptags()
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

"Linting and such
let g:syntastic_check_on_open=1

"Settings for YouCompleteMe
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>

set t_Co=256
syntax on    "syntax highlighting
filetype on  "try to detect filetype
filetype plugin indent on   "enable loading indent file for filetype
set background=dark
colorscheme distinguished

"Better Scrolling
function SmoothScroll(up)
    if a:up
        let scrollaction=""
    else
        let scrollaction=""
    endif
    exec "normal" . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)><Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

let g:pyflakes_use_quickfix = 0

let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

set completeopt=menuone,longest,preview

map <leader>n :NERDTreeToggle<CR>

nmap <leader>a <Esc>:Ack!
nmap <leader>P <Esc>:CtrlP

"set statusline=%{fugitive#statusline()}

map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

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
