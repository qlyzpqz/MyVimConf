"let &termencoding=&encoding
set fileencodings=utf-8,cp936
set fileencoding=utf-8

"common set
filetype on
filetype plugin on
filetype indent on
"set autochdir
set ignorecase
"set tags+=~/MyTags/cpp_tag
set nu
colorscheme my_color
"set expandtab
syntax enable 
"highlight Comment ctermfg=green guifg=green

"""""""""""""""""""""""""""""""""""""""
autocmd BufEnter *.pc set filetype=esqlc
set shiftwidth=4
set tabstop=4
"""""""""""""""""""""""""""""""""""""""

"Set mapleader
let mapleader = ","

set cinoptions=:0g0l1

inoremap <C-s> : <Esc>:wi
nnoremap <silent> <leader>bn :bn<cr>
nnoremap <silent> <leader>bp :bp<cr>

nnoremap <leader>cc :cclose<cr>
nnoremap <leader>co :copen<cr>

"扩号自动补全
inoremap [ []<esc>i
inoremap { {}<esc>i<cr><esc>O
"inoremap ( ()<esc>i
inoremap <c-h> <esc>ha
inoremap <c-l> <esc>la
inoremap <c-j> <esc>ja
inoremap <c-k> <esc>ka

"插入模式下的光标移动
inoremap <c-a> <esc>0i
inoremap <c-e> <esc>$a



if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif


"function! MySys()
"    if has("win32")
"       return "windows"
"    else
"        return "linux"
"    endif
"endfunction

"Fast edit vimrc
if g:iswindows == 0
    "Fast reloading of the .vimrc
    map <silent> <leader>sv :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ev :e ~/.vimrc<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
else
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source $vim\_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :e $vim\_vimrc<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~\_vimrc
endif

" For windows version
if g:iswindows == 1
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif 



""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
if g:iswindows == 1
    let Tlist_Ctags_Cmd = 'ctags'
else                         
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
    let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1 
let Tlist_Use_Right_Window = 0
let Tlist_Auto_Open = 0               
map <silent> <F9> :TlistToggle<cr> 


""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr> 



""""""""""""""""""""""""""""""
" winManager setting
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr> 


""""""""""""""""""""""""""""""
"quickfix 
""""""""""""""""""""""""""""""
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw<cr> 

""""""""""""""""""""""""""""""
"omni-complete
""""""""""""""""""""""""""""""
set nocp
set completeopt=longest,menu 
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"


""""""""""""""""""""""""""""""
"echofunc
""""""""""""""""""""""""""""""
let g:EchoFuncKeyNext='<C-,>'
let g:EchoFuncKeyPrev='<C-.>'


""""""""""""""""""""""""""""""
"cscopes
""""""""""""""""""""""""""""""
set cscopequickfix=s-,g-,c-,t-,e-,f-,i-,d-
map <F12> :call Do_CsTag()<CR>
nmap <C-f>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-f>g :cs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-f>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-f>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-f>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-f>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-f>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-f>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.hh' -o -name '*.tpl' -o -name '*.pc' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.hh,*.cc,*.tpl,*.pc >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction


""""""""""""""""""""""""""""""
"MiniBufExplorer
""""""""""""""""""""""""""""""
let g:miniBufExplMapCTabSwitchWindows = 1
let g:miniBufExplMapCTabSwitchBufs = 1


"""""""""""""""""""""""""""""
"OneKeyCompile
"""""""""""""""""""""""""""""
map <F7> :call Do_OneFileMake()<CR>
function Do_OneFileMake()
	if expand("%:p:h") != getcwd()
		echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press <F7> to redirect to the dir of this file." | echohl None
		return
	endif
	let sourcefilename=expand("%:t")
	if (sourcefilename == "" || (&filetype!="cpp" && &filetype!="c"))
		echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
		return
	endif
	let deletespacefilename=substitute(sourcefilename, ' ', '', 'g')
	if strlen(deletespacefilename) != strlen(sourcefilename)
		echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename! | echohl None
		return
	endif
	if &filetype=="c"
		if g:iswindows==1
			set makeprg=gcc\ -o\ %<.exe\ %\ -g
		else
			set makeprg=gcc\ -o\ %<\ %\ -g
		endif
	elseif &filetype=="cpp" || &filetype=="cc"
		if g:iswindows==1
			set makeprg=g++\ -o\ %<.exe\ %\ -g
		else
			set makeprg=g++\ -o\ %<\ %\ -g
		endif
	endif

	execute "make"
	execute "normal :"
	execute "copen"
endfunction

"""""""""""""""""""""""""""
"OneKeyGdb
"""""""""""""""""""""""""""
map <F8> :call Do_Gdb()<CR>
function Do_Gdb()
	let sourcefilename=expand("%:t")
    if (sourcefilename=="" || (&filetype!="cpp" && &filetype!="c"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif
    let deletedspacefilename=substitute(sourcefilename,' ','','g')
    if strlen(deletedspacefilename)!=strlen(sourcefilename)
        echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
        return
    endif
	if(g:iswindows==1)
        let outfilename=substitute(sourcefilename,'\(\.[^.]*\)','.exe','g')
        let toexename=outfilename
    else
        let outfilename=substitute(sourcefilename,'\(\.[^.]*\)','','g')
        let toexename=outfilename
    endif
    if filereadable(outfilename)
		execute "normal :"
		execute "!gdb ".toexename
	else
		echohl WarningMsg | echo toexename." dose not exists!" | echohl None
		return
    endif
endfunction

""""""""""""""""""""""""""
"OneKeyRun
"""""""""""""""""""""""""
map <F5> :call Do_Run()<CR>
function Do_Run()
	let sourcefilename=expand("%:t")
    if (sourcefilename=="" || (&filetype!="cpp" && &filetype!="c"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif
    let deletedspacefilename=substitute(sourcefilename,' ','','g')
    if strlen(deletedspacefilename)!=strlen(sourcefilename)
        echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
        return
    endif
	if(g:iswindows==1)
        let outfilename=substitute(sourcefilename,'\(\.[^.]*\)','.exe','g')
        let toexename=outfilename
    else
        let outfilename=substitute(sourcefilename,'\(\.[^.]*\)','','g')
        let toexename=outfilename
    endif
	if filereadable(outfilename)
		execute "normal :"
		execute "!".outfilename
	else
		echohl WarningMsg | echo outfilename." dose not exists!" | echohl None
		return
	endif
endfunction

"""""""""""""""""""""""
"NERD_tree
"""""""""""""""""""""""
nmap<Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=23

let g:NERDTree_title = "[NERDTree]"
let NERDTreeWinPos="right"
function NERDTree_Start()
	exe 'NERDTree'
endfunction

function! NERDTree_IsValid()
	return 1
endfunction

autocmd VimEnter * NERDTree

""""""""""""""""""""""
"SaveProject
""""""""""""""""""""""
map  <F10> : call Do_SaveProject()<CR>
function Do_SaveProject()
	execute "normal :"
	execute "mksession! ".g:projectSessionName
	execute "wviminfo! ".g:projectVimInfoName
endfunction


""""""""""""""""""""""
"Code comment
""""""""""""""""""""""
"file header
"iab pqzfh /*********************************************************************<CR> * Author		: pengqinzhong<CR> * Email		: qlyzpqz@163.com<CR> * Created time : <C-R>=strftime("%Y-%m-%d %H:%M")<CR><CR> * File name	: <C-R>=expand("%:t")<CR><CR> * Description  : <CR> ********************************************************************/

iab pqzfh /*********************************************************************<CR>Author       : pengqinzhong<CR>Email        : qlyzpqz@163.com<CR>Created time : <C-R>=strftime("%Y-%m-%d %H:%M")<CR><CR>File name    : <C-R>=expand("%:t")<CR><CR>Description  : <CR>******************************************************************/

"function comment
"iab pqzfc /**<CR> * <CR> * @param <CR> * @return<CR> * @note<CR> * comment by pqz<CR>*/
iab pqzfc /**<CR><CR>@param <CR>@return<CR>@note<CR>comment by pqz<CR>/

nmap <leader>fh ipqzfh<ESC>
nmap <leader>fc ipqzfc<ESC>

