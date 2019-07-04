"�����к�
set nu
" ����ʵʱ�������� 
set incsearch 
" ����ʱ��Сд������ 
set ignorecase 
" �رռ���ģʽ 
set nocompatible 
" vim ����������ģʽ���ܲ�ȫ 
set wildmenu
"���Ʊ����չΪ�ո�
set expandtab
"���ñ༭ʱ�Ʊ��ռ�ÿո���
set tabstop=4
"���ø�ʽ��ʱ�Ʊ��ռ�ÿո���
set shiftwidth=4
"�� vim �����������Ŀո���Ϊһ���Ʊ��
set softtabstop=4
"�����Զ�����
set ai
"�������ܶ���
set smartindent

set wrap
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"����˵�����
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"���consle�������
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
        echohl WarningMsg | echo '�ļ���չ�������� cpp ���� c' | echohl None
        return
    endif

    if filereadable(oF)
        if delete(oF)
            echohl WarningMsg | echo '�޷�ɾ��֮ǰ���ɵĿ�ִ���ļ���������û��Ȩ��' | echohl None
            return
        endif
    endif
    
    let cmd='cls & g++ -static -Wall "'.sF.'" -o "'.oF.'" && "'.oF.'" &pause'
    silent execute 'normal :'
    silent execute '!'.cmd
    
    if !filereadable(oF)
        echohl WarningMsg | echo 'û�������µĿ�ִ���ļ������ܱ���ʧ�ܣ�����û��Ȩ��' | echohl None
        return
    endif
    "�����ѱ�������зŵ���ͬ���ڵģ������������ܻ��ж���Ĳ���
    "������������ڲ���ִ��ʱ�Ĵ��ڣ�����ע�͵�
    "let cmd='cls & "'.oF.'" &pause'
    "silent execute 'normal :'
    "silent execute '!'.cmd
    
endfunction
