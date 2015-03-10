module Hexx
  module Suit
    module Metrics

      # Prepares and runs yardstick environment from '.hexx-suit.yml'
      class Yardstick < RSpec::Metrics::Base

        # Loads yardstick verifier
        #
        # @return [Hexx::Suit::Metrics::Yardstick]
        #
        # @api private
        def self.new
          require "yardstick/rake/measurement"
          super
        end

        # @!scope class
        # Prepares output for the yardstick and sets the YARDSTICK_OUTPUT env
        #
        # @return [self]
        def load
          prepare_output
          set_environment

          super
        end

        # @!scope class
        # Runs yardstick with options from '.hexx-suit.yml'
        #
        # @return [undefined]
        def run
          measurement.yardstick_measure
        end

        private

        # yardstic metric definitions

        def name
          "yardstick"
        end

        def default_options
          {
            "output" => "tmp/yardstick/output.log",
            "path"   => "lib/**/*.rb"
          }
        end

        def metric
          ::Yardstick::Rake::Measurement
        end

        # operations

        def prepare_output
          SYSTEM.call %(
            mkdir #{ ::File.dirname(output) } -p
            touch #{ output }
          )
        end

        def set_environment
          ENV["YARDSTICK_OUTPUT"] = output
        end

        # helpers

        def measurement
          metric.new(:yardstick_measure, options) do |config|
            config.output = output
          end
        end

        def options
          @options ||= begin
            list = default_options.merge settings.to_hash
            list["path"] = Array(list["path"]).join(" ")
            list
          end
        end

        def output
          @output ||= options["output"]
        end
      end
    end
  end
end
