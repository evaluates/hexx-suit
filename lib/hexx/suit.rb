# Shared namespace for the Hexx-based gems
module Hexx

  # Namespace for the module.
  #
  # @api public
  module Suit
    class << self

      # Loads runtime metrics in a given scope
      #
      # Checks if a corresponding environment is set
      #
      # @example
      #   # spec/spec_helper.rb
      #   Hexx::Suit.load_metrics_for(self)
      #
      # @param [Object] scope
      #
      # @return [self]
      def load_metrics_for(scope)
        load_pippi_for(scope)
        load_coverage_for(scope)

        self
      end

      private

      # Loads runtime coverage metric in a given scope
      #
      # @param [Object] scope
      #
      # @return self
      def load_coverage_for(scope)
        return unless ENV["USE_SIMPLECOV"]
        scope.instance_eval { Hexx::Suit::Metrics::SimpleCov.run }
      end

      # Loads runtime pippi metric in a given scope
      #
      # @param [Object] scope
      #
      # @return [self]
      def load_pippi_for(scope)
        return unless ENV["USE_PIPPI"]
        scope.instance_eval { Hexx::Suit::Metrics::Pippi.run }
      end
    end # singleton_class Suit
  end # module Suit
end # module Hexx
