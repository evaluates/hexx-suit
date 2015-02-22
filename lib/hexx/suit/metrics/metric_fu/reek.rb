# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < Base

        # The configurer for the Reek metric
        class Reek < Base

          # @!scope class
          # Changes settings source to config/metrics/reek.yml
          #
          # @return [self]
          def load
            configure do |metric|
              metric.config_file_pattern = "config/metrics/reek.yml"
            end

            self
          end

          private

          def name
            :reek
          end
        end
      end
    end
  end
end
