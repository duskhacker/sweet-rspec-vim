
function! SweetRunSpec(command)
  " TODO: handle args such as --tag focus here, or make a separate command for it
  if a:command == ''
    let dir = 'spec'
  else
    let dir = a:command
  endif
  cexpr system("bundle exec rspec -r /Users/dzepeda/.vim/plugin/my_spec_formatter.rb -f RSpec::Core::Formatters::VimFormatter " . expand("%:p"). " -l " . line("."))
  cw
endfunction
command! -nargs=* -complete=file SweetSpec call SweetRunSpec(<q-args>)
map <leader>s :SweetSpec<space>
