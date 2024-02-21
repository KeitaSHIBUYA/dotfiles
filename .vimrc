" vim の設定
set number
set cursorline " 編集中の行をハイライト
set ruler " 右下にカーソルの位置を表示
set showcmd " 入力中のコマンドを表示
set title " タイトルの追加
syntax enable " シンタックスハイライトを有効化
set wildmenu " vim上からファイルを選択できる機能を有効化
set ambiwidth=double " 全角文字の重なりを解消
set backspace=indent,eol,start " 挿入モードでbackspaceを使って削除を可能に
set laststatus=2 " ステータスバーを2行表示
set history=1000 " コマンドの履歴を1000件保存
set showmatch " 対応する括弧をハイライト
set smartindent " 前の行のインデントを保持
set clipboard+=unnamed " ヤンクの結果をクリップボードに保存
set noerrorbells " エラーの表示時にビープ音を鳴らさない
set mouse=a " マウスの有効化
set shiftwidth=0 " タブの設定(タブ幅4の場合)
set softtabstop=4
set tabstop=4
autocmd FileType python setlocal tabstop=4 " 言語ごとにタブ幅を設定する場合
set hlsearch " 検索結果をハイライト
set incsearch " 最初の一文字を入力した時点から検索開始
set wrapscan " ファイル末尾に到達すると再び先頭から検索

" vim-plug
" call plug#begin('~/.vim/plugged')
" 	call plug#begin()
" 	" ddc.vim本体
" 	Plug 'Shougo/ddc.vim'
" 	" DenoでVimプラグインを開発するためのプラグイン
" 	Plug 'vim-denops/denops.vim'
" 	" ポップアップウィンドウを表示するプラグイン
" 	Plug 'Shougo/pum.vim'
" 	" カーソル周辺の既出単語を補完するsource
" 	Plug 'Shougo/ddc-around'
" 	" ファイル名を補完するsource
" 	Plug 'LumaKernel/ddc-file'
" 	" 入力中の単語を補完の対象にするfilter
" 	Plug 'Shougo/ddc-matcher_head'
" 	" 補完候補を適切にソートするfilter
" 	Plug 'Shougo/ddc-sorter_rank'
" 	" 補完候補の重複を防ぐためのfilter 
" 	Plug 'Shougo/ddc-converter_remove_overlap'
" 
" 	Plug 'mattn/vim-lsp-settings'
" 	Plug 'prabirshrestha/vim-lsp'
" 	Plug 'prabirshrestha/async.vim'
" call plug#end()

" 使いたいsourceを指定する

" vimプラグインの読み込み
if filereadable(expand('~/.vim/vimrc.plugin'))
  source ~/.vim/vimrc.plugin
endif

