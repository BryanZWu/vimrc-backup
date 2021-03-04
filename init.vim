syntax on
set t_Co=256
source ~/.vim/colors/gruvbox.vim
set showmatch
set softtabstop=2
set number
set expandtab 
set shiftwidth=2
set smarttab
set showcmd
autocmd FileType c setlocal shiftwidth=4 softtabstop=4
set cursorline
filetype indent on
set wildmenu
call plug#begin("~/.vim/plugged")
  " Plugin Section
  Plug 'ycm-core/youCompleteMe'
  Plug 'sheerun/vim-polyglot'
  Plug 'machakann/vim-sandwich'
  Plug 'dense-analysis/ale'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'
  Plug 'morhetz/gruvbox'
  Plug 'cohama/lexima.vim'
  Plug 'cpiger/NeoDebug'
call plug#end()
:packadd termdebug
let g:NERDTreeShowHidden = 1
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:lexima_enable_basic_rules=1
let g:lexima_enable_newline_rules=1
let g:lexima_enable_endwise_rules=1
let g:neodbg_keymap_toggle_breakpoint  = '<F9>'         " toggle breakpoint on current line
let g:neodbg_keymap_next               = '<F10>'        " next
let g:neodbg_keymap_run_to_cursor      = '<C-F10>'      " run to cursor (tb and c)
let g:neodbg_keymap_jump               = '<C-S-F10>'    " set next statement (tb and jump)
let g:neodbg_keymap_step_into          = '<F11>'        " step into
let g:neodbg_keymap_step_out           = '<S-F11>'      " setp out
let g:neodbg_keymap_continue           = '<F5>'         " run or continue
let g:neodbg_keymap_print_variable     = '<C-P>'        " view variable under the cursor
let g:neodbg_keymap_stop_debugging     = '<S-F5>'       " stop debugging (kill)
let g:neodbg_keymap_toggle_console_win = '<F6>'         " toggle console window
let g:neodbg_keymap_terminate_debugger = '<C-C>'        " terminate debugger
" Sandwich customizations
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
"Automatic indent when adding linewise brackets
let g:sandwich#recipes += [
      \   {
      \     'buns'        : ['{', '}'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['add'],
      \     'linewise'    : 1,
      \     'command'     : ["'[+1,']-1normal! >>"],
      \   },
      \   {
      \     'buns'        : ['{', '}'],
      \     'motionwise'  : ['line'],
      \     'kind'        : ['delete'],
      \     'linewise'    : 1,
      \     'command'     : ["'[,']normal! <<"],
      \   },
      \ ]
" Html sandwdith tags
let g:sandwich#recipes += [                             
      \   {
      \     'external': ['it', 'at'],
      \     'noremap' : 1,
      \     'filetype': ['html', 'javascript', 'typescriptreact', 'tsx'],
      \     'input'   : ['m'],
      \   },
      \ ]



autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"let g:ycm_key_list_stop_completion = ['ENTER']
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle NERDTree with Ctrl-b
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" Map Ctrl-Backspace to delete the previous word in insert mode. 
" Note that this works ONLY in windows!
call lexima#add_rule({'char': '<BS>', 'except': '[`<"({['']+\%#', 'input': '<C-W>'})


" Rules for remapping the <BS> stuff since in windows it becomes Ctrl + H

call lexima#add_rule({'char': '<C-H>', 'at': '"\%#"', 'delete': 1})
call lexima#add_rule({'char': '<C-H>', 'at': '''\%#''', 'delete': 1})
call lexima#add_rule({'char': '<C-H>', 'at': '\[\%#\]', 'delete': 1})
call lexima#add_rule({'char': '<C-H>', 'at': '{\%#}', 'delete': 1})


" Fast console log in javascript
call lexima#add_rule({'char': '<C-P>','input': 'console.log(', 'input_after': ')', 'filetype': ['js', 'javascript', 'typescript', 'ts', 'tsx', 'typescriptreact']})
call lexima#add_rule({'char': '<C-P>','input': 'printf(', 'input_after': ')', 'filetype': ['c']})
call lexima#add_rule({'char': '<C-P>','input': 'print(', 'input_after': ')', 'filetype': ['py', 'python']})
call lexima#add_rule({'char': '<C-P>','input': 'System.out.println(', 'input_after': ')', 'filetype': ['java']})
call lexima#add_rule({'char': '<CR>', 'at': 'log\%#', 'input': '<BS><BS><BS>console.log(', 'input_after': ')', 'filetype': ['js', 'javascript', 'typescript', 'ts', 'tsx', 'typescriptreact']})
let g:ycm_key_list_stop_completion = ['^@']
" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>
" for command mode
nnoremap <Tab> >>
" disable nonfunctional C-Z
noremap <C-z> <NOP>
" remove C-T because that's used by the command prompt to create a new tab
noremap <C-t> <NOP>
" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

map ; :GFiles<CR>
