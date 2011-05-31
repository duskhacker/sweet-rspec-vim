function! SweetRunSpec()
  let l:command = " rspec -r " 

  if !exists("g:SweetVimRspecUseBundler")
    let g:SweetVimRspecUseBundler = 0 
  endif

  if g:SweetVimRspecUseBundler == 1 
    let l:command = "bundle exec " . l:command
  endif

  cexpr system(l:command . expand("~/.vim/plugin/sweet_vim_rspec_formatter.rb -f RSpec::Core::Formatters::VimFormatter ") . expand("%:p"). " -l " . line("."))
  cw
endfunction
command! SweetSpec call SweetRunSpec()
