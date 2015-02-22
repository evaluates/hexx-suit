# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < Base

        # The configurer for the Cane metric
        class Cane < Base

          private

          def name
            :cane
          end

          def options
            %w(abc_max line_length no_doc no_readme)
          end
        end
      end
    end
  end
end
