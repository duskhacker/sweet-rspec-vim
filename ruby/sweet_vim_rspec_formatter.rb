require 'rspec/core/formatters/base_text_formatter'

# Format spec results for display in the Vim quickfix window
# Use this custom formatter like this:
#   bin/rspec -r spec/support/vim_formatter -f RSpec::Core::Formatters::VimFormatter spec
module RSpec
  module Core
    module Formatters
      class VimFormatter < BaseTextFormatter

        # TODO: vim-side function for printing progress (if that's even possible)

        def example_failed example
          data = ""
          data << "+-+ "
          data << "[FAIL] #{example.description}\n"

          exception = example.execution_result[:exception]
          data << exception.backtrace.find do |frame|
            frame =~ %r{\bspec/.*_spec\.rb:\d+\z}
          end + ": in `#{example.description}'\n" rescue nil

          data << exception.message
          data << "\n+-+ Backtrace\n"
          data << exception.backtrace.join("\n")
          data << "\n-+-\n" * 2
          output.puts data
        end

        def example_pending(example)
          data = ""
          data << "+-+ "
          data << "[PEND] #{example.description}\n"

          pending = example.execution_result[:pending_message]
          data << example.location + ": in `#{example.description}'"
          data << "\n\n-+-\n"
          output.puts data
        end

        def dump_failures *args; end

        def dump_pending *args; end

        def message msg; end

        # like BaseFormatter
        def dump_summary duration, example_count, failure_count, pending_count
          @duration = duration
          @example_count = example_count
          @failure_count = failure_count
          @pending_count = pending_count
        end

        def close
          super
          summary = summary_line example_count, failure_count, pending_count
        end

        private

        def format_message msg
          # NOTE: may consider compressing all whitespace here
          msg.gsub("\n", ' ')[0,40]
        end

      end
    end 
  end 
end 

