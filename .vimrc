scriptencoding utf-8

" 文字コード、改行コード {{{
set encoding=utf-8
set fileformats=unix,dos,mac
" }}} / 文字コード、改行コード

" neobundle.vim {{{
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" color schema
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'

NeoBundle 'Align'
NeoBundle 'elzr/vim-json'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdcommenter'
" NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/AnsiEsc.vim'

" for Ruby
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'

" for React
NeoBundle 'mxw/vim-jsx'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" }}} / neobundle.vim

" matchit.vim {{{
source $VIMRUNTIME/macros/matchit.vim
" }}} / matchit.vim

" Load Settings {{{
" http://vim-users.jp/2009/12/hack108/
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
if &t_Co > 1
  syntax enable
endif
colorscheme hybrid
" colorscheme molokai
" colorscheme Tomorrow-Night
" }}} / Color Settings

" Settings {{{
let mapleader = ","
set autoindent
set autoread " 自動読み直し
set backspace=indent,eol,start "バックスペースキーで削除できるものを指定
set clipboard=unnamed " コピーしたものがレジスタにも入るようにする
" set cursorline " カーソル行をハイライト 重い...
set hidden " 複数ファイルの編集を可能にする
set history=50 " コマンド・検索パターン履歴数
set laststatus=2 " 常にステータラスラインを表示
set list " 不可視文字表示
" set listchars=tab:>\ ,extends:<
set listchars=tab:>-,trail:-,extends:>,precedes:<
set modelines=0 " モードラインは無効
set nobackup
" set backup
" set backupdir=~/.vim/backups
set noswapfile
" set swapfile
" set directory=~/.vim/swaps
set number " 行番号表示
set ruler " ルーラーを表示
set scrolloff=5 " スクロール時の余白確保
set showcmd " コマンドをステータス行に表示
set showmatch " 対応する括弧をハイライト
set showmode " 現在のモードを表示
set smartindent
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc  " ワイルドカードで表示するときに優先度を低くする拡張子
set textwidth=0 " 自動で折り返しをしない
set title " タイトルを表示する
set ttyfast " ターミナル接続を高速にする
set vb t_vb= " ビープ音を鳴らさない
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする
set wildchar=<tab> " コマンド補完開始キー
set wildmenu " コマンド補完を強化
set wildmode=list:longest " リスト表示
" set wildmode=list,full
" }}} / Settings

" Search Settings {{{
set incsearch " インクリメンタルサーチ
set ignorecase " 大文字小文字無視
set hlsearch " 検索文字をハイライト
set smartcase " 大文字は区別する
" }}} / Search Settings

" FileType Settings {{{
" 1 tab == 2 spaces
set tabstop=2
set shiftwidth=2

set expandtab
set smarttab

if has("autocmd")
  augroup MyAutoCmd
    autocmd!

    autocmd FileType * set formatoptions-=ro " 改行時にコメントしない

    autocmd FileType php setlocal ts=2 sts=2 sw=2
    autocmd FileType c setlocal ts=4 sw=4 noexpandtab
    autocmd FileType java setlocal ts=4 sts=4 sw=4
    autocmd FileType html,xhtml,css,scss,javascript,coffee,sh,sql,yaml setlocal ts=2 sts=2 sw=2 nowrap

    " for Rails
    autocmd BufNewFile,BufRead app/*/*.erb setlocal ft=eruby fenc=utf-8
    autocmd BufNewFile,BufRead app/**/*.rb setlocal ft=ruby  fenc=utf-8
    autocmd BufNewFile,BufRead app/**/*.yml setlocal ft=ruby  fenc=utf-8
    autocmd FileType ruby,haml,eruby,sass,mason setlocal ts=2 sts=2 sw=2 et nowrap

    " for Cake PHP
    autocmd BufNewFile,BufRead *.ctp set filetype=php

    " for Node.js
    autocmd BufNewFile,BufRead *.ejs set filetype=javascript

    " for markdown
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
    autocmd FileType markdown hi! def link markdownItalic LineNr

    " for coffeescript
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    autocmd FileType coffee setlocal ts=2 sts=2 sw=2 et nowrap

    " for vuejs
    autocmd BufNewFile,BufRead *.{vue*} set filetype=html
  augroup END
endif
" }}} / FileType Settings

" Window Settings {{{
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" height
nnoremap + <C-w>+
nnoremap - <C-w>-
" width
nnoremap ) <C-w>>
nnoremap ( <C-w><LT>

" }}} / Window Settings


" Tab Settings {{{
nnoremap T :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tn :tabNext<CR>
" }}} / Tab Settings


" Other Settings {{{
nnoremap <silent><Space>j :Explore<CR> " ファイラー起動

" .vimrcや.gvimrcを編集するためのKey-mappingを定義する
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>

nnoremap <ESC><ESC> :nohlsearch<CR> " 検索結果ハイライトをリセットする

"検索ワードが画面の真ん中に来るようにする
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" インサートモードでもhjklで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" インサートモードを抜ける
inoremap <silent> jj <esc>

" 0, 9で行頭、行末へ
nmap 0 ^
nmap 9 $

" ビジュアルモード時vで行末まで選択
xnoremap v $h

function! s:remove_dust()
  let cursor = getpos(".")
  %s/\s\+$//ge " 保存時に行末の空白を除去する
  %s/\t/  /ge " 保存時にtabを2スペースに変換する
  call setpos(".", cursor)
  unlet cursor
endfunction
augroup RemoveDust
  autocmd BufWritePre * call <SID>remove_dust()
augroup END

"挿入モードで",date",',time'で日付、時刻挿入
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>

" Buffer Settings
noremap <Space> :bn!<CR>
noremap <S-Space> :bp!<CR>

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=red guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
" / 全角スペースの表示

" copypath
function! CopyPath()
  let @*=expand('%:P')
endfunction

function! CopyFullPath()
  let @*=expand('%:p')
endfunction

function! CopyFileName()
  let @*=expand('%:t')
endfunction

command! CopyPath     call CopyPath()
command! CopyFullPath call CopyFullPath()
command! CopyFileName call CopyFileName()

nnoremap <silent>cp :CopyPath<CR>
nnoremap <silent>cfp :CopyFullPath<CR>
nnoremap <silent>cf :CopyFileName<CR>

" http://vim-users.jp/2011/04/hack214/
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(
" }}} / Other Settings


" PHP Settings {{{
let php_sql_query = 1 " SQLをハイライトする
let php_htmlInStrings = 1 " HTMLをハイライト
let php_noShortTags = 1 " ショートタグ「< ?」はハイライトしないようにする
" let php_folding = 1 " クラスと関数の折りたたむ
" }}} / PHP Settings

" markdown {{{
let g:markdown_fenced_languages = [
\  'zsh',
\  'coffee',
\  'css',
\  'html',
\  'erb=eruby',
\  'javascript',
\  'js=javascript',
\  'json=javascript',
\  'ruby',
\  'sass',
\  'xml',
\  'php',
\  'swift'
\]
" }}} / markdown

" Plugin Settings {{{

" Align
" elzr/vim-json
" kien/ctrlp.vim
" mattn/emmet-vim
" fholgado/minibufexpl.vim
" osyo-manga/vim-over
" scrooloose/nerdcommenter
" scrooloose/nerdtree
" Shougo/neosnippet
" Shougo/unite.vim
" Shougo/unite-outline
" Shougo/vimfiler
" thinca/vim-quickrun
" tpope/vim-surround

" Align {{{
let g:Align_xstrlen = 3 " Alignを日本語環境で使用するための設定
" }}} / Align

" elzr/vim-json {{{
" ダブルクォート非表示機能を無効化する
let g:vim_json_syntax_conceal = 0
" }}} / elzr/vim-json

" kien/ctrlp.vim {{{
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l'
endif
" }}} / kien/ctrlp.vim

" mattn/emmet-vim {{{
let g:user_emmet_settings = {
\   'lang' : 'ja'
\ }
" }}} / mattn/emmet-vim

" fholgado/minibufexpl.vim {{{
noremap <C-m> :TMiniBufExplorer<CR>
" let g:miniBufExplVSplit = 20
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBuffs = 1
" }}} / fholgado/minibufexpl.vim

" osyo-manga/vim-over {{{
nnoremap <Leader>o :OverCommandLine<CR>

" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>
" }}} / osyo-manga/vim-over

" scrooloose/nerdcommenter {{{
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle
" }}} / scrooloose/nerdcommenter

" scrooloose/nerdtree {{{
" map <C-n> :NERDTreeToggle<CR>
" }}} / scrooloose/nerdtree

" Shougo/neosnippet {{{
" Plugin key-mappings.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

imap <C-t> <Plug>(neosnippet_expand_or_jump)
smap <C-t> <Plug>(neosnippet_expand_or_jump)
xmap <C-t> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/dotfiles/.vim/snippets'
" }}} / Shougo/neosnippet

" Shougo/unite.vim {{{
" The prefix key.
nnoremap [unite] <Nop>
nmap     <leader>u [unite]

" 入力モードで開始する
let g:unite_enable_start_insert=1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

let g:unite_winwidth = 30

" file_mruの表示フォーマットを指定
let g:unite_source_file_mru_filename_format = ''

" history/yank を有効化する
let g:unite_source_history_yank_enable = 1

" 現在のバッファ一覧
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
" ファイル一覧
nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 最近開いたファイルの一覧
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
" ブックマーク一覧
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" バッファと最近開いたファイルの一覧
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
" yank の履歴一覧
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
" ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
" }}} / Shougo/unite.vim

" Shougo/unite-outline {{{
nnoremap <silent> <Leader>l :<C-u>Unite -vertical -no-quit outline<CR>
" }}} / Shougo/unite-outline

" Shougo/vimfiler {{{
let g:vimfiler_as_default_explorer = 1
" セーフモードの設定
let g:vimfiler_safe_mode_by_default = 0
" VimFiler を起動
nnoremap <Space>f :<C-u>VimFiler<CR>
" 現在ん開いているバッファをIDE風に開く
nnoremap <silent> <Leader>f :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
" }}} / Shougo/vimfiler

" thinca/vim-quickrun {{{
" 初期化
let g:quickrun_config = {}
" runnerにvimprocを設定
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config._ = {'runner/vimproc/updatetime' : 100}
" 横分割をするようにする
let g:quickrun_config={'*': {'split': ''}}
" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

" markdownファイルをブラウザで開く
let g:quickrun_config['markdown'] = {
    \ 'outputter': 'browser',
    \ }

" coffeeScript
let g:quickrun_config.coffee = {'command': 'coffee'}
" }}} / thinca/vim-quickrun

" tpope/vim-surround {{{
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
" }}} / tpope/vim-surround

" }}} / Plugin Settings
