function! SweetRunSpec(arg)
  if a:arg != 'last'
    let g:sweetVimSpecCommand = " rspec -r " 

    if !exists("g:SweetVimRspecUseBundler")
      let g:SweetVimRspecUseBundler = 0 
    endif

    if g:SweetVimRspecUseBundler == 1 
      let g:sweetVimSpecCommand = "bundle exec " . g:sweetVimSpecCommand
    endif

     let g:sweetVimSpecCommand = g:sweetVimSpecCommand . expand("~/.vim/plugin/sweet_vim_rspec_formatter.rb -f RSpec::Core::Formatters::SweetSpecFormatter ") . expand("%:p")

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
