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

set wrap
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
set guifont=consola-with-Yahei:h14:b:cDEFAULT
colorscheme desert




nmap<C-F5> :w<CR>:call Do_OneKeyMake()<CR>
imap<C-F5> <Esc>:w<CR>:call Do_OneKeyMake()<CR>
nmap<F5> :call Do_OneKeyMake()<CR>
imap<F5> <Esc>:call Do_OneKeyMake()<CR>
function Do_OneKeyMake()
    let sF=expand('%:p')
    let oF=expand('%:p:h').'\ok.exe'
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
