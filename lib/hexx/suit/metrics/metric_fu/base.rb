# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < Base

        # Base class for metrics configured via metric_fu
        class Base < Metrics::Base

          # Constructs the object and loads 'metric_fu' dependency
          #
          # @return [Hexx::Suit::Metrics::MetricFu]
          #
          # @api private
          def self.new
            require "metric_fu"
            super
          end

          # @!scope class
          # Initializes and configures the metric from a corresponding yml
          #
          # @return [self]
          def load
            configure { |metric| options.each { |option| add(metric, option) } }

            super
          end

          private

          # current metric definitions

          # @abstract
          def name
          end

          # @abstract
          def options
          end

          # helpers

          def add(metric, option)
            value = settings[option]
            metric.send option, value unless value.nil?
          end

          def configure
            ::MetricFu::Configuration.configure_metric(name) do |metric|
              yield(metric)
            end
          end
        end
      end
    end
  end
end
