if v:progname == 'vi'
  set noloadplugins
endif

let mapleader = "\<Space>"

let g:netrw_liststyle = 3	" preferred appearance style. It can be changed with i while using it
let g:netrw_banner = 0 		" remove top banner
let g:netrw_browse_split = 4	" opens split in separate window, kind of like nerdtree
let g:netrw_altv = 1
"let g:netrw-v = 1
let g:netrw_winsize = 25

noremap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right" " open NERDTree on the right side


" script to toggle netrw window, mapped to <leader>n
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vexplore!
    endif
endfunction

" noremap <leader>n :call ToggleNetrw()<CR>


" Autocmds

" Fix splits size (make them equal) when vim window is resized
autocmd VimResized * execute "normal! \<c-w>="




" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

" VimWiki

let g:vimwiki_list = [
      \ {'path': '~/Dropbox/obsidian/', 'syntax': 'markdown', 'ext': '.md'}
                \ ]


if &loadplugins
  if has('packages')
    packadd! ale
    packadd! base16-vim

    packadd! terminus
    "packadd! typescript-vim
    "packadd! vim-clipper
    "packadd! vim-dirvish
    "packadd! vim-docvim
    "packadd! vim-easydir
    "packadd! vim-fugitive
    "packadd! vim-git
    "packadd! vim-javascript
    "packadd! vim-json
    "packadd! vim-jsx
    "packadd! vim-markdown
    packadd! php
    "packadd! vim-projectionist
    "packadd! vim-repeat
    "packadd! vim-signature
    "packadd! vim-surround
    "packadd! vim-zsh
  else
    source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect('pack/bundle/opt/{}')
  endif
endif


" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
"
" Must come *after* the `:packadd!` calls above otherwise the contents of
" package "ftdetect" directories won't be evaluated.

filetype indent plugin on
syntax on
