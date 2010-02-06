" x-------------------------------------x
" | GAGES VIMRC				|
" | 					|
" | this is my poorly orginized vimrc! 	|
" | 					|
" | There's nothing special here...	|
" x-------------------------------------x
" This makes sure that it doesn't defalt to all the crappy vi stuff rather
" than use all the new vim stuff
set nocompatible

runtime ftplugin/man.vim

" I forget what this does but it has
" somthing to do with making sure things
" respond to the filetype of a file
filetype plugin on
"somthing similar to the one above
filetype indent on

" puts a bar on the bottom with info
set ruler
" an old version which was pretty good 
" but it was a bit slow if memory serves me
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

set laststatus=1 

"the next three are commands that add firefox
"like keybindings for tabs
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-t> <ESC>:tabnew<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
nmap <C-S-tab> :tabprevious<cr>
nmap <C-t> :tabnew<cr>
nmap <C-tab> :tabnext<cr>
" imap ]  @@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s

" Makes Ctrl+Space auto complete commands 
imap <C-space> <C-X><C-O><C-P>
"Makes it so you can use jj to ESC if you can't set 
"Caps-lock to esc
imap jj <Esc>
"Makes shift+insert paste like it normaly does in
"many linux applications
imap <S-Insert> <Esc>"+p
nmap <S-Insert> "+p

"sorry I forgot what this does =p
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"adds a new command that edits your vimrc via :Vimrc
com Vimrc :e $HOME/.vimrc

"I always make the typo of typing :W
"This is my lazy way of not fixing
"old habbits
com W :w

" This runs the current file in ruby 
" because I was trying to learn before
" you can set it to python or whatever
nmap   <f5>   :w<CR>:!ruby %<CR>
" If you have the NERDtree plugin installed
" then this opens that with f2
" (really useful)
nmap <F2> :NERDTreeToggle<CR>
" This opens MRU which is a plugin
" for showing most recent files edited
" nmap <F3> :MRU<CR>


" this is an AWSOME mapping CTRL-W is usualy used to 
" deal with windows but with this you can just use
" the comma to do things. makes things like
" like split with ,s
" close with ,c
" etc...
nmap , <C-w>

" makes scrolling faster with CTRL
nmap <C-j> 3j
nmap <C-k> 3k
" enables omni compleation always
" warning! this can be quite annoying
" and doesn't work as it should
"
" nmap i i<C-X><C-O><C-P>
" nmap a a<C-X><C-O><C-P>
" nmap o o<C-X><C-O><C-P>

" moves windows to windows using keypad 
" nmap <Left> <C-w>h 
" nmap <Right> <C-w>l 
" nmap <Up> <C-w>k 
" nmap <Down> <C-w>j 

" sets my colorscheme
colo Mustang

" this was supposed to auto close HTML tags
" with </*tab* but it doesn't work too well
ab </ </

" some mappings to find files FAST!
map <C-f> :FuzzyFinderFile <CR>
" this one was for buffers but it's not so useful
" map <C-b> :FuzzyFinderBuffer <CR>

" This sets the CD to the current file, pretty nice
" actualy but I like a little more control
" set autochdir	  

" helps things to indent properly
set autoindent

" Highlights the current line, which is nice but somtimes
" can slow down the ui, and vim is about SPEED!
" set cul
set guioptions-=m "Gits rid of the menus
set guioptions-=T "Gets rid of the Toolbar set guioptions-=r "Get's rid of the scroll bars
set hlsearch "highlights things after you searched for them
set ignorecase "makes searches case-insenstive which I like
" I had nobackup for a while because I didn't like
" vim making extra files on my system, but now I like it
" set nobackup
" set backup
set number "line numbers!, essentual!
set smartindent "helps indenting
" 

"Number of spaces to use for each step of indent.  
"Used for >> and <<
set sw=4 
" This is also very useful, gives you a nice menu
" when tab-completing with : commands
set wildmenu
" this wrapps the lines, somtimes useful somtimes not
" not sure what the ! is for...
set wrap!
" sets my font and font size
set guifont=Monospace\ 9
" Very useful, highlight the matches as you type in a search
set incsearch


"This Highlights the word under the cursor
nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>

"some ruby stuff that I don't think worked
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"map mr :rubyf %

" this I find nice
" Set's it so that there's 3 lines of padding between the cursor and the
" top/bottom of the screen
set scrolloff=3
" set vb t_vb=".  

"makes it so that jquery scripts have jquery syntax highlighting
au BufRead,BufNewFile *.js set ft=javascript.jquery
   " --- Some special settings for .txt files
au BufRead,BufNewFile *.txt setlocal wrap linebreak
au BufRead,BufNewFile *.txt setlocal syntax=txt
   " --- This Fixes the indents automaticly for all PHP files
" au FileType php silent normal gg=G
   " --- This Turns cursor collmons on and off when you lave a buffer
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline 

"for the plugin that shows marks, to ignore some kinds of marks
let g:showmarks_include="abcdefzxABJio"

"this is for the closetag plugin to be loaded on html files
"I think I might want to get rid of this because
"I don't think I liked the pluigin
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

"this makes a line on the right showing where
"fold are in the code (usualy their invisible)
set foldcolumn=1
" puts a {{{ in the file so it saves your folds
" you have made but also makes it harder to read
" set foldmethod=marker

"BETTER LOOOKING FOLD! WOOOOOOOOOOT!
" Set a nicer foldtext function
" I picked up, I like it a lot
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

