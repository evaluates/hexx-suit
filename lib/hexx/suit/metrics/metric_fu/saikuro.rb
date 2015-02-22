# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < Base

        # The configurer for the Saikuro metric
        class Saikuro < Base

          private

          def name
            :saikuro
          end

          def options
            %w(warn_cyclo error_cyclo)
          end
        end
      end
    end
  end
end
