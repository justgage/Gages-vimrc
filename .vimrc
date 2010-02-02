set nocompatible

runtime ftplugin/man.vim

filetype plugin on

set ruler
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set laststatus=1 

filetype indent on
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-t> <ESC>:tabnew<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
" imap ]  @@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s
imap <C-space> <C-X><C-O><C-P>
imap jj <Esc>
imap <S-Insert> <Esc>"+p
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

com Vimrc :e $HOME/.vimrc
com W :w

nmap <S-Insert> "+p
nmap   <f5>   :w<CR>:!ruby %<CR>
nmap <C-S-tab> :tabprevious<cr>
nmap <C-t> :tabnew<cr>
nmap <C-tab> :tabnext<cr>
nmap <F2> :NERDTreeToggle<CR><CR>
" nmap <F3> :MRU<CR>
nmap , <C-w>
nmap <C-j> 3j
nmap <C-k> 3k
" enables omni compleation always
" nmap i i<C-X><C-O><C-P>
" nmap a a<C-X><C-O><C-P>
" nmap o o<C-X><C-O><C-P>

" moves windows using keypad 
" nmap <Left> <C-w>h 
" nmap <Right> <C-w>l 
" nmap <Up> <C-w>k 
" nmap <Down> <C-w>j 


"map <C-P> :Project <CR>
colo Mustang
filetype plugin on

ab </ </

map <C-b> :FuzzyFinderBuffer <CR>
map <C-f> :FuzzyFinderFile <CR>
" set autochdir	  
set autoindent
" set cul
set guioptions-=m "Gits rid of the menus
set guioptions-=T "Gets rid of the Toolbar set guioptions-=r "Get's rid of the scroll bars
set hlsearch
set ignorecase
" set nobackup
" set backup
set number
set smartindent
set sw=4
set wildmenu
set wrap!
set guifont=Monospace\ 9
set incsearch


"This Highlights the word under the cursor
nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>

"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"map mr :rubyf %

set scrolloff=3 "Set's it so that there's 3 lines of padding between the cursor and the top/bottom of the screen
" set vb t_vb=".  
au BufRead,BufNewFile *.js set ft=javascript.jquery
   " --- Some special settings for .txt files
au BufRead,BufNewFile *.txt setlocal wrap linebreak
au BufRead,BufNewFile *.txt setlocal syntax=txt
   " --- This Fixes the indents automaticly for all PHP files
" au FileType php silent normal gg=G
   " --- This Turns cursor collmons on and off when you lave a buffer
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline 
let g:showmarks_include="abcdefzxABJio"

autocmd Filetype html,xml,xsl source $VIM/vimfiles/scripts/closetag.vim 

"this makes for a better auto complete for some languages using <C-O>
"Doesn't seem to work =-/
if has("autocmd") && exists("+omnifunc")            
  autocmd Filetype *
    \   if &omnifunc == "" |
    \     setlocal omnifunc=syntaxcomplete#Complete |
    \   endif
endif
"end of <C-O> stuff

"a script I picked up that toggles gui stuff with <F11>
function ToggleGUICruft()
  let opts = ['T','m','r','L']
  let sign = &guioptions =~# 'T' ? '-' : '+'
  for opt in opts
    exec('set guioptions'.sign.'='.opt)
  endfor
endfunction
map <F11> <Esc>:call ToggleGUICruft()<CR><CR>
"end of all that stuff


"this was here before I started
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

"BETTER LOOOKING FOLD! WOOOOOOOOOOT!
" Set a nicer foldtext function
set foldcolumn=1
set foldmethod=marker
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
"END OR BETTER LOOKING FOLD

