" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undodir=~/.undodir/
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Ctrl + HJKL for arrow keys

"设置行号
set nu
" 开启实时搜索功能 
set incsearch 
" 搜索时大小写不敏感 
set ignorecase 
" 关闭兼容模式 
set nocompatible 
" vim 自身命令行模式智能补全 
set wildmenu
"将制表符扩展为空格
set expandtab
"设置编辑时制表符占用空格数
set tabstop=4
"设置格式化时制表符占用空格数
set shiftwidth=4
"让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
"开启自动缩进
set ai
"开启智能对齐
set smartindent
" 禁止折行
set nowrap
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8
set guifont=Consolas-with-Yahei:h14:b:cDEFAULT
colorscheme desert
nmap<C-F5> :w<CR>:call Do_OneKeyMake()<CR>
imap<C-F5> <Esc>:w<CR>:call Do_OneKeyMake()<CR>
nmap<F5> :call Do_OneKeyMake()<CR>
imap<F5> <Esc>:call Do_OneKeyMake()<CR>
function Do_OneKeyMake()
    let sF=expand('%:p')
    let oF=expand('%:p:h').'\a.exe'
    let fE=expand('%:e')
    "echo oF
    "echo filereadable(sF)
    if fE!='cpp' && fE!='c'
        echohl WarningMsg | echo '文件扩展名必须是 cpp 或者 c' | echohl None
        return
    endif

    if filereadable(oF)
        if delete(oF)
            echohl WarningMsg | echo '无法删除之前生成的可执行文件，可能是没有权限' | echohl None
            return
        endif
    endif
    
    let cmd='cls & g++ -static -Wall "'.sF.'" -o "'.oF.'" && "'.oF.'" &pause'
    silent execute 'normal :'
    silent execute '!'.cmd
    
    if !filereadable(oF)
        echohl WarningMsg | echo '没有生成新的可执行文件，可能编译失败，或者没有权限' | echohl None
        return
    endif
    "本来把编译和运行放到不同窗口的，但是那样可能会有多余的操作
    "下面的命令用于产生执行时的窗口，现已注释掉
    "let cmd='cls & "'.oF.'" &pause'
    "silent execute 'normal :'
    "silent execute '!'.cmd
    
endfunction
cd d:/
cd /source
