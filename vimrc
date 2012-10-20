" ----------------------
" Initialization part
" ----------------------
" Step 1: git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" Step 2: get my .vimrc

set nocompatible  " This must be first, because it changes other options as side effect
"filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'snipMate'
Bundle 'matchit.zip'
Bundle 'ScrollColors' 
Bundle 'Color-Sampler-Pack'
Bundle 'SearchComplete'
Bundle 'taglist.vim'

" github repos
Bundle 'scrooloose/nerdtree'
Bundle 'wesleyche/SrcExpl'
Bundle 'wesleyche/Trinity'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-abolish'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'ervandew/supertab'
Bundle 'Raimondi/delimitMate'
Bundle 'anzaika/go.vim'

" ----------------------
" Global Options
" ----------------------
set hidden        " can have unwritten changes to a file without being forced to write or undo change
set clipboard+=unnamed  " Yanks go on clipboard instead
"set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000  " remember more commands and search history
set undolevels=1000
		  " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title         " change the terminal's title
"set visualbell    " don't beep
set noerrorbells  " don't beep
set nobackup
set noswapfile
set pastetoggle=<F2>
set wildmode=longest,list " At command line, complete longest common string, then list alternatives.
"set wildmenu
set tags=./tags;$HOME
set encoding=utf-8

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline
set statusline=%<%f\          " custom statusline
set stl+=[%{&ff}]             " show fileformat
set stl+=%y%m%r%=
set stl+=%-14.(%l,%c%V%)\ %P

"filetype plugin indent on
filetype plugin on


if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal' 
  	set t_Co=256 
elseif  &term =~? '^rxvt' || &term =~? '^screen'
    set t_Co=256
endif

if &t_Co >= 256 || has("gui_running")
   	colorscheme wombat256
endif

if &t_Co > 2 || has("gui_running")
   	" switch syntax highlighting on, when the terminal has colors
   	syntax on
endif

:autocmd ColorScheme * highlight Todo ctermbg=red ctermfg=white
:autocmd BufWinEnter * match Todo /TODO/
:autocmd BufWinEnter * match Todo /TODO:/
:autocmd BufWinEnter * match Todo /FIXME/
:autocmd BufWinEnter * match Todo /FIXME:/
:autocmd BufWinEnter * match Todo /XXX/
:autocmd BufWinEnter * match Todo /MARCO/

" Command and Auto commands " {{{
" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

"Auto commands
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG}                                set ft=gitcommit

" restore position in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif 

" ---------------------------------
" Important Plugin Initialization
" ---------------------------------

"let Tlist_Use_SingleClick=1
"let Tlist_Process_File_Always=1
"let Tlist_Show_Menu=1
"let Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Close_OnSelect=1
"let Tlist_Inc_Winwidth = 0

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabCompletionContexts = ['s:ContextDiscover', 's:ContextText']
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
"let g:SuperTabContextDefaultCompletionType="<c-p>"
"let g:SuperTabContextDiscoverDiscovery =
"        \ ["&completefunc:<c-x><c-i>", "&omnifunc:<c-x><c-f>"]
"
"autocmd FileType *
"    \   call SuperTabChain(&omnifunc, "<c-x><c-f>") |
"    \   call SuperTabSetDefaultCompletionType("<c-x><c-i>")

" ----------------------
" Key Mappings
" ----------------------
" change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap ; :
nnoremap j gj
nnoremap k gk

nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <silent> ,/ :nohlsearch<CR>

" taglists setting
nmap <silent> <leader>tg :TlistToggle<CR>

" FuzzyFinder setting
nmap <leader>fb :FufBuffer<cr>
nmap <leader>ff :FufFile<cr>
nmap <leader>fd :FufDir<cr>
nmap <leader>fm :FufBookmark<cr>
nmap <leader>ft :FufTag<cr>

" Open and close all the three plugins on the same time 
nmap <F8>   :TrinityToggleAll<CR> 
" Open and close the srcexpl.vim separately 
nmap <F9>   :TrinityToggleSourceExplorer<CR> 
" Open and close the taglist.vim separately 
nmap <F10>  :TrinityToggleTagList<CR> 
" Open and close the NERD_tree.vim separately 
nmap <F11>  :TrinityToggleNERDTree<CR> 

if has("cscope")
    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  
endif

" ref[1]: http://nvie.com/posts/how-i-boosted-my-vim/
" ref[2]: https://github.com/gmarik/vundle
" ref[3]: http://cscope.sourceforge.net/cscope_maps.vim
" ref[4]: http://mirnazim.org/writings/vim-plugins-i-use/
" ref[5]: https://github.com/gmarik/vundle/wiki/Examples
