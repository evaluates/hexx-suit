# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < Base

        # The configurer for the Flay metric
        class Flay < Base

          private

          def name
            :flay
          end

          def options
            %w(minimum_score)
          end
        end
      end
    end
  end
end
