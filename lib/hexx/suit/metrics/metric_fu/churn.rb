# encoding: utf-8

module Hexx
  module Suit
    module Metrics
      class MetricFu < Base

        # The configurer for the Churn metric
        class Churn < Base

          private

          def name
            :churn
          end

          def options
            %w(ignore_files start_date minimum_churn_count)
          end
        end
      end
    end
  end
end
