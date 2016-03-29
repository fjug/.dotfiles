" turn on package manager 'pathogen'
execute pathogen#infect()

" no compatible mode
set nocompatible

set modelines=3

set ruler

" automatically indent code in common languages
set cindent

" write files when changing buffers, etc.
set autowriteall

" enable syntax highlighting
syntax on

" tabbing
set tabstop=4
set shiftwidth=4

" show tabs and trailing whitespace
set listchars=tab:»\ ,trail:·
set list
"set listchars=tab:»·,trail:·
"set listchars=tab:>\ ,trail:-
"set listchars=tab:»\ ,trail:·

" enable full mouse support
set mouse=a

" always show statusline (default 1)
set ls=2

" enhanced command-line completion
set wildmenu

" colors
"set background=light
set background=dark
highlight NonText ctermfg=6
highlight SpecialKey ctermfg=6
highlight Search ctermbg=6

" highlight cursor line
"set cursorline
highlight CursorLine guibg=darkblue ctermbg=darkblue term=underline cterm=NONE

" incremental search
set incsearch

" ctags
" autocmd BufRead *.{c,cc,cpp,c++,h,hh,hpp,h++} :silent !ctags --c++-kinds=+p --fields=+iaS --extra=+q *
" autocmd BufWrite *.{c,cc,cpp,c++,h,hh,hpp,h++} :silent !ctags --c++-kinds=+p --fields=+iaS --extra=+q *
set tags=./tags,/home/tobias/prj/VSLAM/tags


" set search path for 'find' and plugins
set path=.,./*,.;,/usr/include/,/usr/local/include

" Set completion parameter
set complete=.,w,b,u,t  " Set complete-ion files to search. Currently
                        " scanning included files is slow. default
                        " is:.,w,b,u,t,i in vim7. 'i' is new: scan included
                        " files
set showfulltag         " when completing a word in insert mode,
                        " show tag name and search pattern


" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif



" ------------------- filtype plugin -------------------

" determine filetype
filetype on
filetype plugin on
filetype plugin indent on

" .pl files are prolog files (not perl)
let g:filetype_pl = "prolog"

" .tex files contain latex by default (not plain TeX)
let g:tex_flavor = "latex"

au BufRead,BufNewFile *.bsh set filetype=java
au BufRead,BufNewFile *.cl set filetype=cpp


" ------------------- vtreeexplorer --------------------

let treeExplVertical=1
let treeExplWinSize=40
let treeExplDirSort=1
set hidden " avoid creation of new windows when opening
           " new files and current buffer changed
function IfFileEmpty()
  if @% == ""
    :VSTreeExplore
  endif
endfunction
"autocmd VimEnter * call IfFileEmpty()

function ToggleVTreeExplorer()
	let winnum = bufwinnr("TreeExplorer")
	if winnum != -1
		if winnr() == winnum
			" Already in the explorer window. Close it and return
			if winbufnr(2) != -1
				close
			endif
		else
			" Goto the taglist window, close it and then come back to the
			" original window
			let curbufnr = bufnr('%')
			exe winnum . 'wincmd w'
			close
			" Need to jump back to the original window only if we are not
			" already in that window
			let winnum = bufwinnr(curbufnr)
			if winnr() != winnum
				exe winnum . 'wincmd w'
			endif
		endif
	else
		VSTreeExplore
	endif
endfunction




" ------------------- taglist --------------------------

let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1




" ------------------- map keys -------------------------

" toggle tree explorer
map <F2> :call ToggleVTreeExplorer()<CR>
imap <F2> <ESC>:call ToggleVTreeExplorer()<CR>

" show buf explorer
map <F3> :BufExplorer<CR>
imap <F3> <ESC>:BufExplorer<CR>

" toggle highlighting search results
map <F4> :let &hls=!&hls<CR>
imap <F4> <ESC>:let &hls=!&hls<CR>a

map <F5> :w! ~/.c<CR>
map <F6> :r ~/.c<CR>

" move to next/previous compilation error
map <F7>   :cp<CR>
map <F8>   :cn<CR>

" toggle taglist
map <F9> :TlistToggle<CR>
imap <F9> <ESC>:TlistToggle<CR>

" quit
map <F10> :qa<CR>

" make
map <S-F5> :make<CR>:botright cwindow<CR>

" write buffer
imap <C-S> :w<CR>
imap <C-S> <ESC>:w<CR>a

" toggle cursorline
map ,cl :let &cul=!&cul<CR>

" cut and paste
set clipboard=unnamed
set pastetoggle=<F12>

" map input mode jj to <Esc>
imap ii <Esc>
imap ` <Esc>

" toggle line numbers
"map ,ln :let &number=!&number<CR>
set number
set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" line number color setup
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" header define
map ,def ^yw^i#ifndef <ESC>o#define <ESC>pGo#endif // <ESC>po<UP><CR>

" search and replace
map   '' :s///g<Left><Left><Left>
vmap  '' :s///g<Left><Left><Left>
map   '; :%s///cg<Left><Left><Left><Left>
vmap  '; :s///cg<Left><Left><Left><Left>

" move between windows
map <C-L> <C-W>l
map <C-K> <C-W>k
map <C-J> <C-W>j
map <C-H> <C-W>h

" session
map <S-F7> :mksession! work.vim
map <S-F8> :source work.vim

" ------------------------------------------------------

" set spelling language
"setlocal spell spelllang=de

" comment in/out python, latex, c++/java
"vmap <F7> :s/^/#/<CR>:let &hls=0<CR>
"vmap <F8> :s/^#//<CR>:let &hls=0<CR>
vmap <F7> :s/^/%/<CR>:let &hls=0<CR>
vmap <F8> :s/^%//<CR>:let &hls=0<CR>
"vmap <F7> :s/^/\/\//<CR>:let &hls=0<CR>
"vmap <F8> :s/^\/\///<CR>:let &hls=0<CR>
"map <F9> :%s/\\"u/ü/g<cr>:%s/\\"o/ö/g<cr>:%s/\\"a/ä/g<cr>:%s/\\ss{}/ß/g<cr>

" set default encoding
"set enc=utf-8
"set fenc=utf-8
"set termencoding=utf-8

" ------------------- code formatting ------------------

function MyFormatCode()
	:%s/( / (/g
	:%s/ )/)/g
	:%s/< / </g
	:%s/ >/>/g
	:%s/[ / [/g
	:%s/ ]/]/g
	:%s/\s\s*$//g
endfunction


" convert latex code to semiverbatim
function Mkverb()
	:'<,'>s/\\/\\\\/g
	:'<,'>s/{/\\{/g
	:'<,'>s/}/\\}/g
endfunction



" ---------------- create new h/cpp file ----------------

function! MyNewClass(name)
"-----------------------------------
" create h file
"-----------------------------------
	let fname=a:name . ".h"
	execute "edit" fname
	call append(0, a:name)
	:1
	:s/\(\u\)/_\1/g
	:s/$/_H/g
	normal! gUU
	execute "normal! ^yw^i#ifndef \<esc>o#define \<esc>pGo#endif // \<esc>po\<up>\<cr>"
	append
namespace slam {


class THECLASSNAME
{
public:
	THECLASSNAME ();
	~THECLASSNAME ();

private:
};


} // namespace slam

.
	:5
	normal! ddGp
	execute ":%s/THECLASSNAME/" . a:name . "/g"
	:w
"-----------------------------------
" create cpp file
"-----------------------------------
	let fname=a:name . ".cpp"
	execute "edit" fname
	append
#include "THECLASSNAME.h"


namespace slam {


THECLASSNAME::THECLASSNAME ()
{
}


THECLASSNAME::~THECLASSNAME ()
{
}


} // namespace slam

.
	execute ":%s/THECLASSNAME/" . a:name . "/g"
	:w
	execute "normal! \<cr>"
endfunction

:autocmd BufEnter * silent execute '!printf "\e]1;`basename '.getcwd().'` | '.expand("%:t").' (vim)\a"'  | redraw!
