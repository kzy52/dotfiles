if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'phpunit-result'
endif

"大文字と小文字を区別する
syntax case match

syntax match phpUnitOk /OK.*/
syntax match phpUnitFailures /FAILURES.*/

highlight phpUnitOk term=reverse ctermbg=2 guibg=DarkGreen
highlight phpUnitFailures term=reverse ctermbg=4 guibg=DarkRed

"unlet b:current_syntax
let b:current_syntax = 'phpunit-result'

if main_syntax == 'phpunit-result'
  unlet main_syntax
endif
