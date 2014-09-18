" Global variables for environment
let isMac = has("mac")
let isWin = has("win32")
let isGui = has('gui_running')

set guifont=Source_Code_Pro:h14

if isWin
    " make correct encoding for menu
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " set behaviour for win
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim

    " maximize window when opening
    au GUIEnter * simalt ~x

    " in case of 'diffexpr' is empty
    set diffexpr=MyDiff()
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" enable some feature on mswin like shift + arrow to select text
behave mswin

" set encoding
set encoding=utf-8
set termencoding=utf-8
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,big5,euc-jp,euc-kr,latin1,cp936
set fileencoding=utf-8
set ff=unix

" set line number
set nu

" enable search highlights
set hls

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source $MYVIMRC

" Correct console's encoding
language messages en_US.utf-8

" set compatibility with vi
set nocompatible

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Plugin 'L9'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'SudoEdit.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'Gundo'
Plugin 'FuzzyFinder'
if has('lua')
  Bundle 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1
end
Plugin 'sirver/ultisnips'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'kablamo/vim-git-log'
Plugin 'airblade/vim-gitgutter'

" Theme
Plugin 'altercation/vim-colors-solarized'

" Front-end
Plugin 'kchmck/vim-coffee-script'
Plugin 'jade.vim'
Plugin 'genoma/vim-less'
Plugin 'mattn/emmet-vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'elzr/vim-json'

Plugin 'plasticboy/vim-markdown'

" set theme & highlight
syntax on
set background=light
colorscheme solarized

" Set syntax for specify format
set ft=markdown
au BufWinEnter *.txt set ft=txt
au BufNewFile,BufRead * setfiletype markdown

" set case sensitive
set ignorecase smartcase

" Enable filetype plugin
filetype plugin indent on

" No sound on errors
set noerrorbells
set novisualbell
set vb t_vb=

" set auto backup for work's files
set nobackup
set backupext=.bak

" show last line but '@'
set dy=lastline

" Text, tab and indent related
set expandtab smarttab
set shiftwidth=2
set tabstop=2

" breaking lines
set lbr
set tw=500

" set indent
set ai " auto indent
set si " smart indent

" set cursor line highlight
set nocursorline

" autocomplpro settings
let g:acp_mappingDriven = 1

"key mapping
nmap <F2> :nohls <CR>

" Command maps
" Map :E to :Explore
command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
nnoremap <leader>q :q<cr>
nnoremap <leader>c :close<cr>
nnoremap <leader>ig gg=G<cr>
" file configuration
nnoremap <leader>e :edit
nnoremap <leader>w :w!<cr>
nnoremap <leader><s-w> :w
" switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>
" tab configuration
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>te :tabedit
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove
nnoremap <leader>tl :tabn<cr>
nnoremap <leader>th :tabp<cr>
" nerdtree configuration
nnoremap <f4> :NERDTree<cr>
nnoremap <leader>nt :NERDTree<cr>
" gundo configuration
nnoremap <f5> :GundoToggle<cr>
" sessions
nnoremap <leader>mks :mksession!

" ariline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
