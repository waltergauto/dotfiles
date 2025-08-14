" ~/.vimrc
" Configuración personalizada de Vim optimizada para tmux y desarrollo

" ================================
" CONFIGURACIÓN BÁSICA
" ================================

" Deshabilitar compatibilidad con vi
set nocompatible
set cuc
set cul
" Habilitar detección de tipo de archivo
filetype on
filetype plugin on
filetype indent on

" Habilitar syntax highlighting
syntax on

" Configurar encoding
set encoding=utf-8
set fileencoding=utf-8

" ================================
" CONFIGURACIÓN DE COLORES Y TEMA
" ================================

" Habilitar 256 colores
set t_Co=256

" Configurar esquema de colores oscuro
set background=dark
colorscheme desert

" Configurar colores personalizados para complementar tmux
highlight Normal ctermbg=none
highlight StatusLine ctermbg=24 ctermfg=255
highlight StatusLineNC ctermbg=238 ctermfg=255
highlight VertSplit ctermbg=238 ctermfg=238
highlight LineNr ctermfg=245 ctermbg=none
highlight CursorLineNr ctermfg=214 ctermbg=none

" ================================
" CONFIGURACIÓN DE INTERFAZ
" ================================

" Mostrar números de línea
set number
set relativenumber

" Resaltar línea actual
set cursorline

" Mostrar columna de comandos
set showcmd

" Mostrar modo actual
set showmode

" Habilitar ruler
set ruler

" Configurar status line personalizada
set laststatus=2
set statusline=%=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" Mostrar coincidencias de paréntesis
set showmatch

" Configurar scrolloff
set scrolloff=8

" Habilitar wildmenu
set wildmenu
set wildmode=list:longest

" ================================
" CONFIGURACIÓN DE BÚSQUEDA
" ================================

" Búsqueda incremental
set incsearch

" Resaltar búsquedas
set hlsearch

" Ignorar mayúsculas en búsqueda (a menos que contenga mayúsculas)
set ignorecase
set smartcase

" ================================
" CONFIGURACIÓN DE TEXTO
" ================================

" Configurar tabs y espacios
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" Autoindent y smart indent
set autoindent
set smartindent

" Configurar backspace
set backspace=indent,eol,start

" Wrap de líneas
set wrap
set linebreak

" ================================
" CONFIGURACIÓN DE ARCHIVOS
" ================================

" Habilitar backup y undo
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undofile
set undodir=~/.vim/undo//

" Crear directorios si no existen
silent !mkdir -p ~/.vim/backup
silent !mkdir -p ~/.vim/swap
silent !mkdir -p ~/.vim/undo

" Auto-reload de archivos modificados externamente
set autoread

" ================================
" KEYBINDINGS PERSONALIZADOS
" ================================

" Cambiar leader key
let mapleader = ","

" Mapeos para navegación
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save y quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Limpiar resaltado de búsqueda
nnoremap <leader>/ :nohlsearch<CR>

" Navegación entre buffers
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>d :bdelete<CR>

" Split windows
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>

" Redimensionar ventanas
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>= :resize +5<CR>
nnoremap <leader>_ :resize -5<CR>

" ================================
" CONFIGURACIÓN PARA TMUX
" ================================

" Habilitar mouse en vim
set mouse=a

" Configurar clipboard para trabajar con tmux
if has('clipboard')
    set clipboard=unnamedplus
endif

" Configuración específica para tmux
if exists('$TMUX')
    " Cambiar cursor según el modo
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

" ================================
" CONFIGURACIONES DE DESARROLLO
" ================================

" Mostrar espacios en blanco
set list
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

" Configuración para diferentes tipos de archivo
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Auto-completado básico
set omnifunc=syntaxcomplete#Complete

" ================================
" FUNCIONES PERSONALIZADAS
" ================================

" Función para alternar números relativos
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <leader>r :call NumberToggle()<CR>

" Función para limpiar espacios en blanco al final
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

nnoremap <leader>t :call TrimWhitespace()<CR>

" ================================
" CONFIGURACIÓN PARA WINDOWS TERMINAL
" ================================

" Configuración específica para Windows Terminal
if has('win32') || has('win64')
    " Configurar shell si es necesario
    " set shell=powershell
endif

" Configuración para mejor rendimiento en conexiones SSH
set ttyfast
set lazyredraw

" ================================
" CONFIGURACIONES ADICIONALES
" ================================

" Habilitar folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Configuración para mejor experiencia de edición
set complete-=i
set nrformats-=octal
set sessionoptions-=options
set viewoptions-=options

" Auto-guardar al salir del insert mode
autocmd InsertLeave * write

" Resaltar TODO, FIXME, etc.
autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')



" Personalizar colores de cursor cross
highlight CursorLine ctermbg=234 cterm=none
highlight CursorColumn ctermbg=234 cterm=none

" Toggle rápido para activar/desactivar la cruz
nnoremap <leader>c :set cursorline! cursorcolumn!<CR>

" Deshabilitar cursor cross en archivos grandes
autocmd BufEnter * if line('$') > 1000 | set nocursorline nocursorcolumn | endif
" ================================
" CONFIGURACIÓN DE PLUGINS (opcional)
" ================================

" Si usas vim-plug, descomenta y personaliza:
" call plug#begin('~/.vim/plugged')
"
" " Plugins esenciales
" Plug 'preservim/nerdtree'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
" Plug 'ctrlpvim/ctrlp.vim'
"
" call plug#end()
