" neagle2009@gmail.com 

"显示行号
set number

"当文件被更改时自动reload
set autoread

"根据文件中其他地方的缩进空格个数来确定一个tab 是多少个空格
set smarttab

"tab显示空格数
set tabstop=4

"编辑时退格是多少个空格
set softtabstop=4
"每一级缩进多少个空格
set shiftwidth=4

"tab扩展为空格(noexpandtab)
set noexpandtab

"set expandtab
"[range]retab 重新调整空格
"use twice withd of ASCII char
set ambiwidth=double
set formatoptions=tcqro "注释换行前面自动加星号

"high line cursor line  set cul  set nocul
"set cursorline

set fileencodings=utf-8,cp936,GB2312,GBK,GB18030
syntax on
color desert

set autowrite

" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>

set nocompatible              " be iMproved, required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
"
" " let Vundle manage Vundle, required
" Plugin 'gmarik/Vundle.vim'
" Plugin 'fatih/vim-go'
"
" " All of your Plugins must be added before the following line
" call vundle#end()            " required
" filetype plugin indent on    " required

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
call plug#end()

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1

