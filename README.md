All this does right now is run the spec under the cursor.and outputs it to into a 'quickfix' window. 

The formatter is based on code I found [here](https://wincent.com/blog/running-rspec-specs-from-inside-vim)

* I don't know how to find files in vimscript yet, so the formatter file path is hard-coded
* I want there to be a 'run-all' and 'run-focused' 
* I want the script to remember the last run spec so you can invoke it from any buffer.
* It needs to work with RSpec 1 & 2 (it only works for 2 right now) 
* I want more context in the quick-fix buffer, ideally a folded backtrace for each failure. 
* I'd like an output window that shows rspec executing. 
