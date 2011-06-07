# Introduction

SweetVimRsec is a vimscript pluss Rspec formatter that outputs failures
and pending messages into a Vim Quickfix buffer for easy navigation of
failures.

## Features

SweetVimRspec has the following commands

### SweetSpec

Runs all specs in the current buffer. 

### SweetSpecRunAtLine

Runs a focused spec at the current line in the current buffer. 

### SweetSpecRunLast 

Runs the last spec, no matter what line or buffer you are currently at. 

## TODO

* Rspec 1.x compatibility. 
* An output window that shows rspec executing. 


The formatter is based on code I found [here](https://wincent.com/blog/running-rspec-specs-from-inside-vim)
