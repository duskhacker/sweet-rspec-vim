require 'spec/runner/formatter/base_text_formatter'
require 'pathname'

# Format spec results for display in the Vim quickfix window
module Spec
  module Runner
    module Formatter
      class VimFormatter < BaseTextFormatter

        def dump_failure counter, failure
          data = ""
          data << "+-+ "
          data << "[FAIL] #{failure.header.match(/'(.*?)'/)[0]}\n"

          data << failure.exception.backtrace.join("\n")

          data << failure.exception.message
          data << "\n+-+ Backtrace\n"
          data << failure.exception.clean_backtrace.join("\n")
          data << "\n-+-\n" * 2
          output.puts data
        end

        #def dump_pending(counter, failure)

          #data = ""
          #data << "+-+ "
          #data << "[PEND] #{failure.header.match(/'(.*?)'/)[0]}\n"

          #data << failure.exception.backtrace.join("\n")

          #data << failure.exception.message
          #data << "\n+-+ Backtrace\n"
          #data << failure.exception.clean_backtrace.join("\n")
          #data << "\n-+-\n" * 2
          #output.puts data
        #end

        def dump_summary(*); end

        def message(*); end

      end
    end 
  end
end

