function! SweetVimRspecRun(kind)
  echomsg "Running Specs..."
  sleep 10m " Sleep long enough so MacVim redraws the screen so you can see the above message
  if !exists('g:SweetVimRspecUseBundler')
    let g:SweetVimRspecUseBundler = 1
  endif

  if !exists('t:SweetVimRspecVersion')
    let l:cmd = ""
    if g:SweetVimRspecUseBundler == 1
      let l:cmd .= "bundle exec "
    endif
    let l:cmd .=  "spec --version 2>/dev/null"
    let t:SweetVimRspecVersion = empty( system( l:cmd ) )  ? 2 : 1
  endif

  if !exists('t:SweetVimRspecExecutable') || empty(t:SweetVimRspecExecutable)
    let t:SweetVimRspecExecutable =  g:SweetVimRspecUseBundler == 0 ? "" : "bundle exec " 
    if  t:SweetVimRspecVersion  > 1
      let t:SweetVimRspecExecutable .= "rspec -r " . expand("~/.vim/plugin/sweet_vim_rspec2_formatter.rb") . " -f RSpec::Core::Formatters::SweetVimRspecFormatter "
    else
      let t:SweetVimRspecExecutable .= "spec -br " . expand("~/.vim/plugin/sweet_vim_rspec1_formatter.rb") . " -f Spec::Runner::Formatter::SweetVimRspecFormatter "
    endif
  endif

  if a:kind !=  "Previous" 
    let t:SweetVimRspecTarget = expand("%:p") . " " 
    if a:kind == "Focused"
      let t:SweetVimRspecTarget .=  "-l " . line(".") . " " 
    endif
  endif

  if !exists('t:SweetVimRspecTarget')
    echo "Run a Spec first"
    return
  endif

  cclose

  if exists('g:SweetVimRspecErrorFile') 
    execute 'silent! bdelete ' .  g:SweetVimRspecErrorFile
  endif

  let g:SweetVimRspecErrorFile = tempname()
  execute 'silent! wall'
  cgete system(t:SweetVimRspecExecutable . t:SweetVimRspecTarget . " 2>" . g:SweetVimRspecErrorFile)
  botright cwindow
  cw
  setlocal foldmethod=marker
  setlocal foldmarker=+-+,-+-

  if getfsize(g:SweetVimRspecErrorFile) > 0 
    execute 'silent! split ' . g:SweetVimRspecErrorFile
    setlocal buftype=nofile
  endif

  call delete(g:SweetVimRspecErrorFile)

  let l:oldCmdHeight = &cmdheight
  let &cmdheight = 2
  echo "Done"
  let &cmdheight = l:oldCmdHeight
endfunction
command! SweetVimRspecRunFile call SweetVimRspecRun("File")
command! SweetVimRspecRunFocused call SweetVimRspecRun("Focused")
command! SweetVimRspecRunPrevious call SweetVimRspecRun("Previous")
