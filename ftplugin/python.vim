" In ~/.vim/ftplugin/python.vim

" Check Python files with flake8.
let b:ale_linters = ['flake8']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let b:ale_echo_msg_format = '[%linter%][%code%] %s [%severity%]'
