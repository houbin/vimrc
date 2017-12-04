" platform
if (has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

" vbundle配置 
set nocompatible 

filetype off                    "required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tomasr/molokai'

call vundle#end()               " required

filetype plugin indent off       "required!

syntax enable 
nmap lb ^
nmap le $
set tabstop=4                                    " 一个tab等于4个空格
set shiftwidth=4                                 " 每层缩进的空格数
set expandtab                                    " 将tab扩展为空格。使用Ctrl-V<tab>来输入真正的tab
set nowrap                                       " 不自动换行
set hlsearch                                     " 高亮搜索内容
set incsearch                                    " 在输入要搜索的文字时, vim会自动匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用

set history=1024
set number                                       " 显示行号
set autoread                                     " 文件在Vim之外修改过，自动重新读入
set showbreak=↪                                  " 显示换行符
set completeopt=longest,menuone                  " 更好的insert模式自动完成

autocmd BufEnter * lcd %:p:h

" mapleader
let mapleader=";"

" 设置快捷键将选中文本复制到系统的剪贴板和将剪贴板的内容粘贴至vim
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

"Window navigation mappings
"deprecated after using vim-tmux-navigator
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l

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

" vim记住文件关闭时的位置
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" neocomplete配置
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

" NERDTree配置
    map <F3> :NERDTreeToggle<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.o','\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeKeepTreeInNewTab=1
    let NERDTreeShowHidden=1

    " close vim if the only window left open is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " shortcut
    " ctrl + w + h      光标focus左侧的树形目录
    " ctrl + w + l      光标focus右侧的树形目录
    " ctrl + w + w      光标自动在左右侧窗口切换

    " o                 在已有窗口打开文件、目录或者书签，并跳到该窗口
    " go                在已有窗口打开文件、目录或者书签，但不跳到该窗口
    " t                 在新tab打开选中文件、书签，并跳到新tab                
    " T                 在新tab打开选中文件、书签，但不跳到新tab
    
    " O                 递归打开选中节点下的所有目录
    " x                 合拢选中节点下的父目录
    " X                 递归合拢选中节点下的所有目录

    " P                 跳到根节点
    " p                 跳到父节点
    " K                 跳到当前目录下同级的第一个节点
    " J                 跳到当前目录下同级的最后一个节点
    " k                 跳到当前目录下同级的前一个节点
    " j                 跳到当前目录下同级的后一个节点

    " tabnew            建立对指定文件的tab
    " tabc              关闭当前tab
    " tabo              关闭所有其他的tab
    " tabs              查看所有打开的tab
    " tabp              前一个tab
    " tabn              后一个tab
    " 标准模式下
    " gT                前一个tab
    " gt                后一个tab
    " shift + r         手动刷新nerdtree中的文件

" tagbar配置
    let g:tagbar_width=26
    let g:tagbar_autofocus = 1
    nmap <F4> :TagbarToggle<CR> 
    
    " 快捷键
    " F1                跳到tagbar对应的快捷键说明
    " p                 tag window跳到对应的地方, 但是光标不移动

" molokai, scheme color
    let g:molokai_original = 1

"cscope setting
    let work_dir=getcwd()
    function! AddScope()
        " set csprg=/usr/local/bin/cscope
        " set cscopetagorder=1
        " set cscopetag
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            "cs add cscope.out
            cs add cscope.out work_dir -C
        "else search cscope.out elsewhere  
        else  
           let cscope_file=findfile("cscope.out", ".;")  
           let cscope_pre=matchstr(cscope_file, ".*/")  
           if !empty(cscope_file) && filereadable(cscope_file)  
               cs add cscope_file cscope_pre
           endif        
         endif 
        set csverb
    endfunction

    function! GenerateScope()
        !find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.java" -o -name "*.php" -o -name "*.go"> cscope.files;cscope -Rbkq
        call AddScope()
    endfunction

    if has("cscope")
        call AddScope()
    endif

    " The following maps all invoke one of the following cscope search types:
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" 自定义命令
command! Ctags !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
command! Cscope call GenerateScope()
