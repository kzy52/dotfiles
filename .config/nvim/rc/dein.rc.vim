set runtimepath+=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/bundle')
  call dein#begin('~/.config/nvim/bundle')

  let s:toml      = '~/.config/nvim/dein.toml'
  let s:lazy_toml = '~/.config/nvim/deinlazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
