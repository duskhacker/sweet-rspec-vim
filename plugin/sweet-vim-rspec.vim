
function! SweetRunSpec()
  cexpr system("bundle exec rspec -r /Users/dzepeda/.vim/ruby/sweet_vim_rspec_formatter.rb -f RSpec::Core::Formatters::VimFormatter " . expand("%:p"). " -l " . line("."))
  cw
endfunction
command! -nargs=0 -complete=file SweetSpec call SweetRunSpec()
map <leader>s :SweetSpec<space>
