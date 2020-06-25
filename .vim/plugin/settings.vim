scriptencoding utf-8

set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode


if exists('$SUDO_USER')
	set nobackup                        " don't create root-owned files
	set nowritebackup                   " don't create root-owned files
else
  " uses the first available directory
  set backupdir=~/local/.vim/tmp/backup  
	set backupdir+=~/.vim/tmp/backup     " keep backup files out of the way
	set backupdir+=.
endif

if exists('&belloff')
	set belloff=all                     " never ring the bell for any reason
endif

set cursorline                        " highlight current line

if exists('$SUDO_USER')
	set noswapfile                      " don't create root-owned files
else
	set directory=~/local/.vim/tmp/swap// 
	set directory+=~/.vim/tmp/swap//     " keep swap files out of the way
	set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                    " don't create root-owned files
  else
    set undodir=~/local/.vim/tmp/undo
    set undodir+=~/.vim/tmp/undo      " keep undo files out of the way
    set undodir+=.
    set undofile                      " actually use undo files
  endif
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                      " don't create root-owned files
  else
    if isdirectory('~/local/.vim/tmp')
      set viminfo+=n~/local/.vim/tmp/viminfo
    else
      set viminfo+=n~/.vim/tmp/viminfo " override ~/.viminfo default
    endif

    if !empty(glob('~/.vim/tmp/viminfo'))
      if !filereadable(expand('~/.vim/tmp/viminfo'))
        echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
      endif
    endif
  endif
endif


if has('mksession')
  if isdirectory('~/local/.vim/tmp')
    set viewdir=~/local/.vim/tmp/view
  else
    set viewdir=~/.vim/tmp/view       " override ~/.vim/view default
  endif
  set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
endif

set expandtab                         " always use spaces instead of tabs

set hidden                            " allows you to hide buffers with unsaved changes without being prompted

if has('linebreak')
  set linebreak
endif

set list
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
" + BOX DRAWINGS HEAVY TRIPLE
" DASH HORIZONTAL (U+2505,
" UTF-8: E2 94 85)
"
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set modelines=5                       " scan this many lines looking for modeline
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set number                            " show line numbers in gutter

set scrolloff=3                       " start scrolling 3 lines before edge of viewport
set sidescrolloff=3                   " same as scolloff, but for columns

if exists('+relativenumber')
	set relativenumber                  " show relative numbers in gutter
endif

set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace
set shiftwidth=2                      " spaces per tab (when shifting) // what's the difference with tabstop?

if v:progname !=# 'vi'
	set softtabstop=-1                  " use 'shiftwidth' for tab/bs at end of line
endif

if has('windows')
	set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
	set splitright                      " open vertical splits to the right of the current window
endif

set tabstop=2                         " spaces per tab


set textwidth=80                      " automatically hard wrap at 80 columns
