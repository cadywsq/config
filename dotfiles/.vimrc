let mapleader = ','
"+-----------------------------------------------------------------------------+
"| Vundle                                                                      |
"+-----------------------------------------------------------------------------+
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
set signcolumn=yes
let g:gitgutter_diff_args = 'HEAD'

Plugin 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-w>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-w>l :TmuxNavigateRight<cr>
nnoremap <M-h> :TmuxNavigateLeft<cr>
nnoremap <M-j> :TmuxNavigateDown<cr>
nnoremap <M-k> :TmuxNavigateUp<cr>
nnoremap <M-l> :TmuxNavigateRight<cr>
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-H> <C-w>H
nnoremap <M-L> <C-w>L
nnoremap <M-=> <C-w>+
nnoremap <M--> <C-w>-
nnoremap <M-.> <C-w>.
nnoremap <M-,> <C-w>,

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<leader><space>'
set wildignore+=*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_working_path_mode = 'ra'

Plugin 'itchyny/lightline.vim'

Plugin 'jiangmiao/auto-pairs'

Plugin 'godlygeek/tabular'
nnoremap T :Tab /
vnoremap T :Tab /

Plugin 'nathanaelkane/vim-indent-guides'
set background=dark
nmap <silent> <C-j> <Plug>IndentGuidesToggle
autocmd FileType c,python,java,cpp,objc,ruby IndentGuidesEnable
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#555555  ctermbg=240
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333333   ctermbg=235

Plugin 'scrooloose/nerdtree'
nnoremap <leader>f :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=0
let NERDTreeWinSize=48
let NERDTreeMouseMode=3
let NERDTreeShowHidden=1

Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"+-----------------------------------------------------------------------------+
"| Google                                                                      |
"+-----------------------------------------------------------------------------+

if filereadable('/usr/share/vim/google/google.vim')
    source /usr/share/vim/google/google.vim
    Glug magic

    Glug blaze plugin[mappings]='<C-b>'

    Glug blazedeps

    Glug codefmt
    nnoremap <M-f> :FormatCode<CR>
    inoremap <M-f> <Esc>:FormatCode<CR>

    Glug easygoogle

    Glug findinc

    Glug ft-proto

    Glug ft-python

    Glug google-filetypes

    Glug googlepaths

    Glug googlestyle

    Glug syntastic-google checkers=`{'python': 'gpylint'}`
    let g:syntastic_mode_map = {'mode': 'passive'}
    nnoremap <C-d> :SyntasticCheck<CR>
    let g:syntastic_auto_loc_list=1
    let g:syntastic_enable_signs=1
    let g:syntastic_loc_list_height=5

" set statusline=%<\ %n:%f\ %m%r%y%{SyntasticStatuslineFlag()}%=(%l\ ,\ %c%V)\ Total:\ %L\
" work around for the location list bug
autocmd FileType c,cpp,objc nnoremap ZQ :lcl<bar>q!<CR>
vmap ZQ vZQ
autocmd FileType c,cpp,objc nnoremap ZZ :lcl<bar>w<bar>lcl<bar>q<CR>
vmap ZZ vZZ

    Glug youcompleteme-google
    au Filetype c,cpp,objc,objcpp,python,cs noremap gd :YcmCompleter GoTo<CR>
    au Filetype c,cpp,objc,objcpp,python,cs noremap gb <C-o>
    let g:ycm_always_populate_location_list = 1
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

    Glug gtimporter

    Glug relatedfiles plugin[mappings]='<C-f>'

    let g:ctrlp_user_command = '/usr/bin/ag %s -i --nocolor --nogroup --hidden
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore .DS_Store
          \ --ignore "**/*.pyc"
          \ --ignore .git5_specs
          \ --ignore review
          \ -g ""'
endif
au BufRead,BufNewFile *.json set filetype=json

"+-----------------------------------------------------------------------------+
"| Misc settings                                                              |
"+-----------------------------------------------------------------------------+
if !has("gui_running")
    set t_Co=256
else
    set guifont=Hack\ 10
endif
if has("mac")
    set clipboard=unnamed
    map [A <Up>
    map [B <Down>
    map [D <Left>
    map [C <Right>
    imap [A <Up>
    imap [B <Down>
    imap [D <Left>
    imap [C <Right>
    vmap [A <Up>
    vmap [B <Down>
    vmap [D <Left>
    vmap [C <Right>
    nmap [A <Up>
    nmap [B <Down>
    nmap [D <Left>
    nmap [C <Right>
    cmap [A <Up>
    cmap [B <Down>
    cmap [D <Left>
    cmap [C <Right>
else
    set clipboard=unnamedplus
endif
set laststatus=2

function SpellCorrectionModeOn()
    if &spell
        let s:wrongSpellStatus = spellbadword()[1]
        if s:wrongSpellStatus == 'bad'
            echo 'wrong spelling found'
            call arpeggio#unmap('i', '', 'jk')
            imap <silent> l <Right><Esc>:silent! call SpellCorrectionModeOff()<CR>
            imap j <Down>
            imap k <Up>
            normal he
            nnoremap <F13> a<C-x>s
        else
            echo 'No wrong spelling!'
        endif
    else
        echo 'Enable spell check with <F4> first.'
    endif
endfunction
function SpellCorrectionModeOff()
    nunmap <F13>
    iunmap l
    iunmap j
    iunmap k
    silent call arpeggio#map('i', '', 0, 'jk', '<Esc>')
endfunction
nmap <silent> <Backspace> :call SpellCorrectionModeOn()<CR><F13>

set tw=0
syntax on
au FileType cpp,c,java,tex,text  set tw=99
set formatoptions=cq foldignore= wildignore+=*.py[co]
syntax sync minlines=256
set mouse=a
set so=3
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,cp936,latin1,ucs-bom
set termencoding=utf-8
" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/
set undolevels=1000
set undoreload=10000
set viminfo='10,\"100,:20,%,n~/.viminfo
set timeoutlen=500
set autoread

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set ai nowrap nu expandtab
set tabstop=2 shiftwidth=2
setlocal spelllang=en_us
set incsearch
set smartcase ignorecase
set showmode
autocmd VimLeave * call system("xsel -ib", getreg('+'))
colorscheme molokai_mod
set guioptions=
set cul
syntax sync minlines=64
set regexpengine=1
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul
set backspace=indent,eol,start
set foldmethod=syntax
set foldnestmax=2      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

autocmd BufWritePre * :%s/\s\+$//e

"+-----------------------------------------------------------------------------+
"| Remaps                                                                      |
"+-----------------------------------------------------------------------------+
call arpeggio#map('iv', '', 0, 'jk', '<Esc>')
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

nnoremap <M-j> 3<C-w>j
nnoremap <M-k> 3<C-w>k
nnoremap <M-h> 3<C-w>h
nnoremap <M-l> 3<C-w>l
nnoremap <M-J> 3<C-w>J
nnoremap <M-K> 3<C-w>K
nnoremap <M-H> 3<C-w>H
nnoremap <M-L> 3<C-w>L
nnoremap <M-=> 3<C-w>+
nnoremap <M--> 3<C-w>-
nnoremap <M-.> 3<C-w>.
nnoremap <M-,> 3<C-w>,

inoremap <M-j> 3<C-w>j
inoremap <M-k> 3<C-w>k
inoremap <M-h> 3<C-w>h
inoremap <M-l> 3<C-w>l
inoremap <M-J> 3<C-w>J
inoremap <M-K> 3<C-w>K
inoremap <M-H> 3<C-w>H
inoremap <M-L> 3<C-w>L
inoremap <M-+> 3<C-w>=
inoremap <M--> 3<C-w>-
inoremap <M-.> 3<C-w>.
inoremap <M-,> 3<C-w>,

nnoremap <C-Tab> <C-w>w
vnoremap <C-Tab> <C-w>w
inoremap <C-Tab> <C-w>w
inoremap <C-w> <C-o><C-w>
nnoremap <Right> *
nnoremap <Left> #
nnoremap <up> 3<c-y>
nnoremap <down> 3<c-e>
imap <Home> <C-o>^
map <Home> ^
map <c-d> <delete>
imap <c-d> <Delete>
nmap <C-d> <Delete>
vmap <C-d> <Delete>
map <C-a> <Home>
map <C-e> <End>
" nmap <C-f> <Right>
" nmap <C-b> <Left>
" nmap <C-n> <Down>
" nmap <C-p> <Up>
nmap <C-l> <Right>
nmap <C-h> <Left>
nmap <C-j> <Down>
nmap <C-k> <Up>

imap <C-a> <Home>
imap <C-e> <End>
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
noremap <C-z> <C-a>
nnoremap <silent> <F3> :set hlsearch!<bar>echo 'highlight search '.(&hlsearch==1?'on':'off')<CR>
imap <F3> <C-o><F3>
set pastetoggle=<F2>
nnoremap <silent> <F4> :set spell!<bar>echo 'spell '.(&spell==1?'on':'off')<CR>
imap <F4>  <C-o><F4>
nnoremap U :redo<CR>
nnoremap w viw
vnoremap w e
nnoremap W viW
vnoremap W E
nnoremap <silent> <C-s> :wa<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> v:w<CR>
nnoremap zz mz1z=`z
inoremap <C-g> <Esc>[s1z=`]a
nnoremap x "xx
vnoremap P pgvy
nnoremap Q {gq}
vnoremap Q gq
nnoremap R :%s/\<<C-r><C-w>\>//g<Left><Left>
vmap R *N:%s///g<Left><Left>
vmap <Right> *
vmap <Left> #
nmap <M-a> ggVGy

"+-----------------------------------------------------------------------------+
"| FileType settings                                                           |
"+-----------------------------------------------------------------------------+
au FileType markdown set makeprg=multimarkdown\ %\ -o\ %.html
" au FileType tex set makeprg=latexmk\ -pdfdvi\ %
au FileType tex set makeprg=pdflatex\ -halt-on-error\ %
inoremap <M-4> <nop>
au FileType tex inoremap <M-4> $$<Left>
au FileType tex inoremap <D-Space> $$<Left>
au FileType tex inoremap <M-k> <CR>\[<CR>\]<Up><CR>
au FileType tex inoremap <D-k> <CR>\[<CR>\]<Up><CR>
