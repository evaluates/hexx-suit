require "yaml"

module Hexx
  module Suit

    # Contains metric configurators
    #
    # Any configurator loads metric settings from a corresponding yaml,
    # sets necessary environments via {.load} method,
    # and then runs the metric via {.run} method.
    #
    # Configurators loads their own dependencies in a corresponding constructor.
    module Metrics

      # Base class for metrics configurators
      #
      # @api private
      class Base

        # The utility class for sending commands to the system
        SYSTEM = Utils::System

        # Loads metric settings and configures the current metric
        #
        # @return (see #load)
        def self.load
          send(:new).load
        end

        # Configures and runs the current metric
        #
        # @return (see #run)
        def self.run
          load.run
        end

        # Loads the configuration file and configures the metric
        #
        # @abstract
        #
        # @return [Hexx::Suit::Metrics]
        #   the configured metric object
        #
        # @api private
        def load
          self
        end

        # Runs the metric
        #
        # @abstract
        #
        # @return [undefined]
        #
        # @api private
        def run
        end

        # @note
        #   The class has a private constructor.
        #   Use methods {.load} or {.run}.
        private_class_method :new

        private

        # Extracts a hash of settings from the current file
        #
        # @return [Hash]
        #
        # @api private
        def settings
          @settings ||= file ? ::YAML.load_file(file) : {}
        end

        # Returns the name of the settings file
        #
        # @return [String]
        #   when the file is present in the config/metrics folder
        # @return [nil]
        #   when the file is absent in the config/metrics folder
        #
        # @api private
        def file
          @file ||= Dir["config/metrics/#{ name }.yml"].first
        end

        # The name of the current metric
        #
        # @abstract
        #
        # @return [Symbol]
        attr_reader :name
      end
    end
  end
end
