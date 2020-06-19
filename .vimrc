" starting from scratch

let mapleader = "\<Space>"

let g:netrw_liststyle = 3	" preferred appearance style. It can be changed with i while using it
let g:netrw_banner = 0 		" remove top banner
let g:netrw_browse_split = 4	" opens split in separate window, kind of like nerdtree
let g:netrw_altv = 1
"let g:netrw-v = 1
let g:netrw_winsize = 25


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

" Add your own mapping. For example:
noremap <leader>n :call ToggleNetrw()<CR>


" Autocmds

" Fix splits size (make them equal) when vim window is resized
autocmd VimResized * execute "normal! \<c-w>="

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

