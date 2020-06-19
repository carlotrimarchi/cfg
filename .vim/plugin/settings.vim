set autoindent                        " maintain indent of current line
set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode


if exists('$SUDO_USER')
	set nobackup                        " don't create root-owned files
	set nowritebackup                   " don't create root-owned files
else
	set backupdir=~/.vim/tmp/backup     " keep backup files out of the way
	set backupdir+=.
endif

if exists('&belloff')
	set belloff=all                     " never ring the bell for any reason
endif

set cursorline                        " highlight current line

if exists('$SUDO_USER')
	set noswapfile                      " don't create root-owned files
else
	set directory=~/.vim/tmp/swap//     " keep swap files out of the way
	set directory+=.
endif

set expandtab                         " always use spaces instead of tabs

set hidden                            " allows you to hide buffers with unsaved changes without being prompted


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


if exists('+relativenumber')
	set relativenumber                  " show relative numbers in gutter
endif

set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace

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
