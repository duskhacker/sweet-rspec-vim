require 'spec/runner/formatter/base_text_formatter'
require 'pathname'

# Format spec results for display in the Vim quickfix window
module Spec
  module Runner
    module Formatter
      class SweetVimRspecFormatter < BaseTextFormatter

        def dump_failure counter, failure
          data = ""
          data << "+-+ "
          data << "[FAIL] #{failure.header.match(/'(.*?)'/)[0]}\n"

          data << failure.exception.backtrace.find do |frame|
            frame =~ %r{\bspec/.*_spec\.rb:\d+\z}
          end + ": in `#{failure.header.match(/'(.*?)'/)[0]}'\n" #rescue nil

          data << failure.exception.message
          data << "\n+-+ Backtrace\n"
          data << failure.exception.clean_backtrace.join("\n")
          data << "\n-+-\n" * 2
          output.puts data
        end

        def example_pending(example, message, deprecated_pending_location=nil)
          data = ""
          data << "+-+ "
          data << "[PEND] #{example.description}\n"

          data << example.location + ": in `#{example.description}'\n"
          data << "\n-+-\n"
          output.puts data
        end

        def dump_summary(*); end

        def message(*); end

      end
    end 
  end
end

