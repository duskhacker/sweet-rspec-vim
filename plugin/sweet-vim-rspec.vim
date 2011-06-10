function! SweetRunSpec(arg)
  echomsg "Starting..."
  redraw!
  if !exists('g:SweetVimRspecUseBundler')
    let g:SweetVimRspecUseBundler = 1
  endif

  if !exists('t:SweetVimRspecVersion')
    let t:SweetVimRspecVersion = empty( system("bundle exec spec --version 2>/dev/null" ) )  ? 2 : 1
  endif

  if !exists('t:SweetVimRspecExecutable') || empty(t:SweetVimRspecExecutable)
    let t:SweetVimRspecExecutable =  g:SweetVimRspecUseBundler == 0 ? "" : "bundle exec " 
    if  t:SweetVimRspecVersion  > 1
      let t:SweetVimRspecExecutable .= "rspec -r " . expand("~/.vim/plugin/sweet_vim_rspec_formatter.rb") . " -f RSpec::Core::Formatters::SweetSpecFormatter "
    else
      let t:SweetVimRspecExecutable .= "spec -br " . expand("~/.vim/plugin/sweet_vim_rspec1_formatter.rb") . " -f Spec::Runner::Formatter::VimFormatter "
    endif
  endif

  if a:arg != 'last' " Need checking of command to make sure it is set. 
    let t:SweetVimRspecTarget = expand("%:p") . " " 
    if a:arg == "atLine"
      let t:SweetVimRspecTarget .=  "-l " . line(".") . " " 
    endif
  endif

  cgete system(t:SweetVimRspecExecutable . t:SweetVimRspecTarget . " 2>/dev/null")
  botright cwindow
  cw
  set foldmethod=marker
  set foldmarker=+-+,-+-
  echo "Done"
endfunction
command! SweetSpec call SweetRunSpec("all")
command! SweetSpecRunAtLine call SweetRunSpec("atLine")
command! SweetSpecRunLast call SweetRunSpec("last")
