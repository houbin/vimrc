" platform
if (has("win32") || has("win95") || has("win64") || has("win16"))
    let g:vimrc_iswindows=1
else
    let g:vimrc_iswindows=0
endif

set nocompatible
syntax on
set tabstop=4 " 一个tab等于4个空格
set shiftwidth=4 " 每层缩进的空格数
set expandtab " 将tab扩展为空格。使用Ctrl-V<tab>来输入真正的tab
set nowrap " 不自动换行
set hlsearch " 高亮搜索内容
set incsearch " 在输入要搜索的文字时, vim会自动匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用

autocmd BufEnter * lcd %:p:h
" 缩进
"if has("autocmd") 
"    filetype plugin indent on
"    augroup vimrcEx
"    	au!
"	    autocmd FileType text setlocal textwidth=200
"        autocmd BufReadPost *
"	                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
"	                    \ exe "normal! g`\"" |
"	                    \ endif
"	    augroup END
"else
"		"set autoindent
"endif " has("autocmd")

map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
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
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

set history=1024
set number                                       " 显示行号
set autoread                                     " 文件在Vim之外修改过，自动重新读入
set showbreak=↪                                  " 显示换行符
set completeopt=longest,menuone                  " 更好的insert模式自动完成

filetype off                  " required

" ========================== neocomplete start ============================
"
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" ====================== neocomplete end =================================


" set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
  " alternatively, pass a path where Vundle should install plugins
  "let path = '~/some/path/here'
  "call vundle#rc(path)

  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  " The following are examples of different formats supported.
  " Keep Plugin commands between here and filetype plugin indent on.
  " scripts on GitHub repos
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'Shougo/neocomplete.vim'


  " Plugin 'tpope/vim-fugitive'
  "Plugin 'Lokaltog/vim-easymotion'
  "Plugin 'tpope/vim-rails.git'
  " The sparkup vim script is in a subdirectory of this repo called vim.
  " Pass the path to set the runtimepath properly.
  "Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
  " scripts from http://vim-scripts.org/vim/scripts.html
  "Plugin 'L9'
  "Plugin 'FuzzyFinder'
  " scripts not on GitHub
  "Plugin 'git://git.wincent.com/command-t.git'
  " git repos on your local machine (i.e. when working on your own plugin)
  "Plugin 'file:///home/gmarik/path/to/plugin'
  " ...

  filetype plugin indent on     " required
  " To ignore plugin indent changes, instead use:
  "filetype plugin on
  "
  " Brief help
  " :PluginList          - list configured plugins
  " :PluginInstall(!)    - install (update) plugins
  " :PluginSearch(!) foo - search (or refresh cache first) for foo
  " :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
  "
  " see :h vundle for more details or wiki for FAQ
  " NOTE: comments after Plugin commands are not allowed.
  " Put your stuff after this line




