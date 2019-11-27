" load vim plugins
for name in systemlist('ls ~/.vim/pack/orange')
    let path = '~/.vim/pack/vendor/'.name
    execute 'set runtimepath+='.path
endfor


" ======================
" Personnal Setting
" ======================

"Split Layout
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Syntax
syntax on

" 高亮多余的空白字符及 Tab
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" 使用 4 个空格，不使用 Tab
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"Code Indent
au BufNewFile,BufRead *.py
\ set tabstop=4|
\ set softtabstop=4|
\ set shiftwidth=4|
\ set textwidth=79|
\ set expandtab|
\ set autoindent|
\ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2|
\ set softtabstop=2|
\ set shiftwidth=2


" 总是显示 DOS 格式文件中的 ^M
set fileformats=unix

"Flagging Unnecessary Whitespace
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/



"python3 with venv support
python3 << EOF
import os
import sys
import site
if 'VIRTUAL_ENV' in os.environ:
   project_base_dir = os.environ['VIRTUAL_ENV']
   activate_this = os.path.join(project_base_dir, 'bin/activate')
   old_os_path = os.environ.get('PATH', '')
   os.environ['PATH'] = os.path.dirname(os.path.abspath(activate_this)) + os.pathsep + old_os_path
   base = os.path.dirname(os.path.dirname(os.path.abspath(activate_this)))
   if sys.platform == 'win32':
       site_packages = os.path.join(base, 'Lib', 'site-packages')
   else:
       site_packages = os.path.join(base, 'lib', 'python%s' % sys.version[:3], 'site-packages')
   prev_sys_path = list(sys.path)
   site.addsitedir(site_packages)
   sys.real_prefix = sys.prefix
   sys.prefix = base
   # Move the added items to the front of the path:
   new_sys_path = []
   for item in list(sys.path):
       if item not in prev_sys_path:
           new_sys_path.append(item)
           sys.path.remove(item)
   sys.path[:0] = new_sys_path
EOF


" Auto Complete
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter="/usr/bin/python3"
let g:ycm_global_ycm_extra_conf = "/home/orange/.vim/pack/vendor/start/YouCompleteMe/.ycm_extra_conf.py"
let g:ycm_key_invoke_completion='<c-z>'
let g:pymode_rope_completion = 0  " close pymode complete
" map <leader>q  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" debug run with quickfix window
nnoremap <F5> :call CompileRunGcc()<cr>
func! CompileRunGcc()
          exec "w"
          if &filetype == 'python'
                  if search("@profile")
                          exec "AsyncRun kernprof -l -v %"
                          exec "copen"
                          exec "wincmd p"
                  elseif search("set_trace()")
                          exec "!python3 %"
                  else
                          exec "AsyncRun -raw python3 %"
                          exec "copen"
                          exec "wincmd p"
                  endif
          endif

endfunc




" File Scan
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swap$'] "ignore files in NERDTree
nnoremap <F3> :NERDTree <CR>
" autocmd vimenter * NERDTree
" show hidden files
let NERDTreeShowHidden=1
" NERDTree dont show detail info
let NERDTreeMinimalUI=1
" delete the buffer when delete its file
let NERDTreeAutoDeleteBuffer=1
" close nerdtree when close vim with one file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" git plug with nerdtree
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" base on indent or grammer folding
"set foldmethod=indent
set foldmethod=syntax
" close fold code when start vim
set nofoldenable

" indent view
" let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle


" ctrlsf key
nnoremap <Leader>sp :CtrlSF<CR>

" python-mode setting
" use python3 as default interpreter
let g:pymode_python = 'python3'
" use PEP8 style indent
let g:pymode_indent = 1
" use lint checkers
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
" open python all grammer highlight
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
" highlight indent error
let g:pymode_syntax_indent_errors = g:pymode_syntax_all


"==============================================================================
" vim-go 插件
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2



set nu
" characteristic
set encoding=utf-8
set mouse=a
set clipboard=unnamed
set backspace=indent,eol,start

" highlight current line/columns
set cursorline
"set cursorcolumn

