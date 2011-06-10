# Introduction

SweetVimRspec makes running Rspec specs in VIM sweeter. It has
three modes, run a whole file, run just one focused test, or run the
previously run test. The last option is particularly nice because it
doesn't matter where you are in the project, you can still run the last
spec without returning to the spec buffer. 

The output is formatted for VIM folding and output to a Quickfix buffer,
so you can easily navigate all the errors in your specs. 

SweetVimRspec supports both Rspec 1 and Rspec 2. 

## Features

SweetVimRspec has the following commands

### SweetVimRspecRunFile

Runs all specs in the current buffer. 

### SweetVimRspecRunFocused

Runs a focused spec at the current line (the line your cursor is on) in the current buffer. 

### SweetVimRspecRunPrevious 

Runs the last spec, no matter where your cursor currently
resides.

## Mappings

These are the mappings that I use, I have not included them in the
plugin so as not to overwrite mappings you already have.

* `map <D-r> :SweetSpec<CR>` "(CMD-r)  or (Apple-r)
* `map <D-R> :SweetSpecRunAtLine<CR>` "(SHIFT-CMD-r) 
* `map <M-D-r> :SweetSpecRunLast<CR>` "(OPT-CMD-r)

Simply copy these into your .vimrc to activate them. 

Note: The `<M-D-r>` mapping requires `:set macmeta`

## Folding

To navigate the Quickfix buffer output efficiently, you should be
familiar with VIM folding. Take a look a `:h usr_28` for more
infomation.

## TODO

* An output window that shows rspec executing. 

## Contributing

This is BETA software, it most likely has minor bugs. I've personally
used it, but other platforms and installations will be different from
mine and may cause problems. This software is only tested on MacVim 7.3
(57). If you find bugs, report them. Better yet, fix them and I'll
include the fixes here. 

## Thanks

The formatter is based on code I found [here](https://wincent.com/blog/running-rspec-specs-from-inside-vim)
