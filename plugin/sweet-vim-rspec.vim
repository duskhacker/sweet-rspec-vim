function! SweetRunSpec(arg)
  if !exists('t:SweetVimSpecRspecVersion')
    let t:SweetVimSpecRspecVersion =  empty( system("bundle exec spec --version 2>/dev/null" ) )  ? 2 : 1
  endif
  if a:arg != 'last'
    if t:SweetVimSpecRspecVersion == 2
      let g:sweetVimSpecCommand = " rspec -r " 
    else
      let g:sweetVimSpecCommand = " spec -br " 
    end

    let g:sweetVimSpecCommand = "bundle exec " . g:sweetVimSpecCommand

    if t:SweetVimSpecRspecVersion == 2
      let g:sweetVimSpecCommand = g:sweetVimSpecCommand . expand("~/.vim/plugin/sweet_vim_rspec_formatter.rb -f RSpec::Core::Formatters::SweetSpecFormatter ") . expand("%:p")
    else
      let g:sweetVimSpecCommand = g:sweetVimSpecCommand . expand("~/.vim/plugin/sweet_vim_rspec1_formatter.rb -f Spec::Runner::Formatter::VimFormatter ") . expand("%:p")
    endif

    if a:arg == "atLine"
      let g:sweetVimSpecCommand = g:sweetVimSpecCommand . " -l " . line(".")
    endif

    let g:sweetVimSpecCommand = g:sweetVimSpecCommand . " 2>/dev/null"
  endif

  cgete system(g:sweetVimSpecCommand)
  botright cwindow
  cw
  set foldmethod=marker
  set foldmarker=+-+,-+-
  echo "Done"
endfunction
command! SweetSpec call SweetRunSpec("all")
command! SweetSpecRunAtLine call SweetRunSpec("atLine")
command! SweetSpecRunLast call SweetRunSpec("last")
