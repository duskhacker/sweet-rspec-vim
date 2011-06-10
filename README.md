# Introduction

SweetVimRsec is a vimscript pluss Rspec formatter that outputs failures
and pending messages into a Vim Quickfix buffer for easy navigation of
failures.

It has formatters for Rspec 1.x and 2. 

## Features

SweetVimRspec has the following commands

### SweetSpec

Runs all specs in the current buffer. 

### SweetSpecRunAtLine

Runs a focused spec at the current line in the current buffer. 

### SweetSpecRunLast 

Runs the last spec, no matter what line or buffer you are currently at.

## Mappings

These are the mappings that I use, I have not included them in the
plugin so as not to overwrite mappings you already have.

* `map <D-r> :SweetSpec<CR>`
* `map <D-R> :SweetSpecRunAtLine<CR>`
* `map <M-D-r> :SweetSpecRunLast<CR>`

Note: The <M-D-r> mapping requires :set macmeta

## TODO

* An output window that shows rspec executing. 


The formatter is based on code I found [here](https://wincent.com/blog/running-rspec-specs-from-inside-vim)
