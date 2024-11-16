" Basic Settings
syntax on
set number
set norelativenumber
set mouse=a
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set showcmd
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set clipboard=unnamed
set noruler
set wildmenu
set laststatus=2
set belloff=all
"set colorcolumn=80
set cursorline

" Theme setting
colorscheme slate

" Performance settings
set timeoutlen=1000
set ttimeoutlen=0
set ttyfast
set lazyredraw

" Compilation and Running (using C++20)
" F7: Just build to check syntax
nnoremap <F7> :w<CR>:!g++ -std=c++20 -Wall -Wextra % -o %:r<CR>

" F8: Build with LOCAL flag and run with tee
nnoremap <F8> :w<CR>:!g++ -std=c++20 -O2 -Wall -DLOCAL % -o %:r && ./%:r \| tee output.txt<CR>

" F9: Format current file with clang-format
nnoremap <F9> :w<CR>:!clang-format -i %<CR>:e<CR>

" Custom mappings for competitive programming
inoremap {{ {<CR>}<Esc>ko
inoremap ,< cout << 
inoremap ,> cin >> 

" Common snippets
inoremap ,pb push_back()<Esc>i
inoremap ,eb emplace_back()<Esc>i
inoremap ,ppb pop_back()<Esc>i
inoremap ,pf push_front()<Esc>i
inoremap ,ppf pop_front()<Esc>i
inoremap ,fr for(int i = 0; i < n; i++) {<CR>}<Esc>O
inoremap ,ll long long
inoremap ,v vector<><Esc>i
inoremap ,s set<><Esc>i
inoremap ,st stack<><Esc>i
inoremap ,q queue<><Esc>i
inoremap ,dq deque<><Esc>i
inoremap ,m map<><Esc>i
inoremap ,hm unordered_map<><Esc>i
inoremap ,hs unordered_set<><Esc>i

" Auto-pairs
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

" Status line configuration
let g:start_time = localtime()

" Function to format elapsed time
function! GetElapsedTime()
    let elapsed = localtime() - g:start_time
    let hours = elapsed / 3600
    let minutes = (elapsed % 3600) / 60
    let seconds = elapsed % 60
    return printf("%02d:%02d:%02d", hours, minutes, seconds)
endfunction

" Function to set programming status line
function! SetProgrammingStatusLine()
    set statusline=\ %f
    set statusline+=%m
    set statusline+=%r
    set statusline+=%h
    set statusline+=%w
    set statusline+=\ [%{&ff}]
    set statusline+=\ [%Y]
    set statusline+=\ [%4l,%3v]
    set statusline+=\ [%L\ lines]
    set statusline+=\ [%{GetElapsedTime()}]
endfunction

" Function to set simple status line
function! SetSimpleStatusLine()
    set statusline=\ %f
    set statusline+=\ [%L\ lines]
endfunction

" Auto-command group for status line
augroup StatusLineConfig
    autocmd!
    " Programming files
    autocmd BufEnter,BufRead *.c,*.cpp,*.h,*.hpp,*.go,*.rs,*.java,*.py,*.rb,*.js,*.ts,*.php,*.cs call SetProgrammingStatusLine()
    " Other files
    autocmd BufEnter,BufRead * if index(['c', 'cpp', 'java', 'python', 'ruby', 'go', 'rust', 'javascript', 'typescript', 'php', 'cs'], &filetype) < 0 | call SetSimpleStatusLine() | endif
augroup END

" Timer update (only for programming files)
if has('timers')
    function! UpdateTimer(timer)
        if index(['c', 'cpp', 'java', 'python', 'ruby', 'go', 'rust', 'javascript', 'typescript', 'php', 'cs'], &filetype) >= 0
            redrawstatus
        endif
    endfunction
    let timer = timer_start(1000, 'UpdateTimer', {'repeat': -1})
endif

" Keep the timer update command
command! Rtime let g:start_time = localtime()

" Template system
if has('nvim')
    let s:template_dir = stdpath('config') . '/templates'
    let s:cp_template = s:template_dir . '/cp_template.cpp'
    let s:lc_template = s:template_dir . '/leetcode_template.cpp'
else
    let s:template_dir = $HOME . '/.vim/templates'
    let s:cp_template = s:template_dir . '/cp_template.cpp'
    let s:lc_template = s:template_dir . '/leetcode_template.cpp'
endif

" Create template directory if it doesn't exist
if !isdirectory(s:template_dir)
    call mkdir(s:template_dir, "p")
endif

" Auto-load appropriate template based on filename
augroup templates
    autocmd!
    autocmd BufNewFile *.cpp call LoadTemplate()
augroup END

function! LoadTemplate()
    let filename = expand('%:t:r')  " Get filename without extension
    let ext = expand('%:e')         " Get file extension

    " Check if file extension is cpp
    if ext == 'cpp'
        " Check for competitive programming related filenames
        if filename =~ '\v(cp|cf|codeforce|vnoj|cses)'
            execute '0r ' . s:cp_template
        " Check for leetcode related filenames
        elseif filename =~ '\v(lc|leetcode)'
            execute '0r ' . s:lc_template
        endif
    endif
endfunction

" Cursor shape changes based on mode
if has('nvim')
    " Neovim cursor
    set guicursor=n-v-c:block-Cursor/lCursor
    set guicursor+=i:ver25-Cursor/lCursor
    set guicursor+=r:hor20-Cursor/lCursor
else
    " Vim cursor (works in most terminals)
    if exists('$TMUX')
        " In tmux
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    else
        " Not in tmux
        let &t_SI = "\e[5 q"
        let &t_EI = "\e[2 q"
    endif
endif
