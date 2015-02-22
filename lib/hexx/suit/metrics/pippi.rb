module Hexx
  module Suit
    module Metrics

      # Prepares and runs pippi environment
      class Pippi < Base

        # Constructs the object and loads 'pippi' gem dependency
        #
        # Loads pippi settings, prepares the log file,
        # and sets ENV variables for the pippi rake tasks.
        #
        # @return [Hexx::Suit::Metrics::MetricFu]
        #
        # @api private
        def self.new
          require "pippi"
          super
        end

        # @!scope class
        # Prepares log file and sets ENV variables for pippi rake tasks
        #
        # @return [undefined]
        def load
          prepare_output
          set_environment

          self
        end

        # @!scope class
        # Starts pippi AutoRunner
        #
        # @return [undefined]
        def run
          ::Pippi::AutoRunner.new checkset: checkset, io: io
        end

        private

        # pippi metric definitions

        def name
          :pippi
        end

        def default_options
          {
            "checkset" => "basic",
            "output"   => "tmp/pippi/output.log"
          }
        end

        # operations

        def prepare_output
          SYSTEM.call %(
            mkdir #{ File.dirname(output) } -p
            touch #{ output }
          )
        end

        def set_environment
          ENV["USE_PIPPI"]    = "true"
          ENV["PIPPI_OUTPUT"] = output
        end

        # helpers

        def options
          @options ||= default_options.merge settings.to_h
        end

        def output
          @output ||= options["output"]
        end

        def io
          ::File.open(output, "w")
        end

        def checkset
          options["checkset"]
        end
      end
    end
  end
end
