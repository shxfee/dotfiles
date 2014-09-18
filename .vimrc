" Vundle Configuration.
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'bling/vim-airline'
Plugin 'Townk/vim-autoclose'
Plugin 'scrooloose/nerdtree'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" All of your Plugins must be added before the following line


call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" Set up the theme and status line
set t_Co=256
colorscheme noteplus
set background=dark
let g:airline_theme = 'badwolf'
set laststatus=2
let g:airline_powerline_fonts = 1
let g:CommandTTraverseSCM='pwd'

" Set other misc options
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4


set nowrap			" don't wrap lines
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent    		" always set autoindenting on
set copyindent    		" copy the previous indentation on autoindenting
set shiftround    		" use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     		" set show matching parenthesis
set ignorecase    		" ignore case when searching
set smartcase     		" ignore case if search pattern is all lowercase,
                  		"    case-sensitive otherwise
set smarttab      		" insert tabs on the start of a line according to



set hlsearch      		" highlight search terms
set incsearch			" show search matches as you type
set history=1000        " remember more commands and search history
set undolevels=1000     " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title				" change the terminal's title
set visualbell          " don't beep
set noerrorbells        " don't beep
nnoremap <esc> :noh<return><esc>


" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
