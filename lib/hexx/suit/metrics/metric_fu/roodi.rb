# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < RSpec::Metrics::Base

        # The configurer for the Roodi metric
        class Roodi < Base

          # @!scope class
          # Changes settings source to config/metrics/roodi.yml
          #
          # @return [self]
          def load
            configure do |metric|
              metric.roodi_config = "config/metrics/roodi.yml"
            end

            self
          end

          private

          def name
            :roodi
          end
        end
      end
    end
  end
end
