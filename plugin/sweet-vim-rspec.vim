" Find the path to this script so that the links
" to formatter don't need to be hard coded.
if !exists('g:SweetVimRspecPlugin')
  let g:SweetVimRspecPlugin = fnamemodify(expand("<sfile>"), ":p:h") 
endif

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
    " Execute the spec --version command which, if returns without error
    " means that the version of rspec is ONE otherwise assume rspec2
    cgete system( l:cmd ) 
    let t:SweetVimRspecVersion = v:shell_error == 0 ? 1 : 2
  endif

  if !exists('t:SweetVimRspecExecutable') || empty(t:SweetVimRspecExecutable)
    let t:SweetVimRspecExecutable =  g:SweetVimRspecUseBundler == 0 ? "" : "bundle exec " 
    if  t:SweetVimRspecVersion  > 1
      let t:SweetVimRspecExecutable .= "rspec -r " . g:SweetVimRspecPlugin . "/sweet_vim_rspec2_formatter.rb" . " -f RSpec::Core::Formatters::SweetVimRspecFormatter "
    else
      let t:SweetVimRspecExecutable .= "spec -br " . g:SweetVimRspecPlugin . "/sweet_vim_rspec1_formatter.rb" . " -f Spec::Runner::Formatter::SweetVimRspecFormatter "
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
