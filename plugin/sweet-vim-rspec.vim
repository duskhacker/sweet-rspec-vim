function! SweetRunSpec(arg)
  echo "Running Specs...\n"
  redraw!
  if !exists('g:SweetVimRspecUseBundler')
    let g:SweetVimRspecUseBundler = 1
  endif


  if !exists('t:SweetVimRspecVersion')
    let t:SweetVimRspecCommand =  g:SweetVimRspecUseBundler == 0 ? "" : "bundle exec " 
    let t:SweetVimRspecVersion = empty( system("bundle exec spec --version 2>/dev/null" ) )  ? 2 : 1
    if  t:SweetVimRspecVersion  > 1
      let t:SweetVimRspecCommand .= "rspec -r " . expand("~/.vim/plugin/sweet_vim_rspec_formatter.rb") . " -f RSpec::Core::Formatters::SweetSpecFormatter "
    else
      let t:SweetVimRspecCommand .= "spec -br " . expand("~/.vim/plugin/sweet_vim_rspec1_formatter.rb") . " -f Spec::Runner::Formatter::VimFormatter "
    end
  endif

  if a:arg != 'last' " Need checking of command to make sure it is set. 
    let t:SweetVimRspecCommand .= expand("%:p") . " " 

    if a:arg == "atLine"
      let t:SweetVimRspecCommand .=  "-l " . line(".") . " " 
    endif

    let t:SweetVimRspecCommand .= "2>/dev/null"
  endif

  cgete system(t:SweetVimRspecCommand)
  botright cwindow
  cw
  set foldmethod=marker
  set foldmarker=+-+,-+-
  echo "Done"
endfunction
command! SweetSpec call SweetRunSpec("all")
command! SweetSpecRunAtLine call SweetRunSpec("atLine")
command! SweetSpecRunLast call SweetRunSpec("last")
