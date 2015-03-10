# encoding: utf-8

module Hexx

  # Namespace for the module.
  module Suit

    require_relative "suit/metrics"
    require_relative "suit/install"

    class << self

      # Loads all the necessary rake tasks
      #
      # @example
      #   Hexx::Suit.install_tasks
      #
      # @return [undefined]
      def install_tasks
        load_rspec_tasks
        load_custom_tasks
      end

      # Loads runtime metrics for the host gem
      #
      # @example
      #   # spec/spec_helper.rb
      #   Hexx::Suit.load_metrics_for(self)
      def load_metrics_for(scope)
        RSpec.load_metrics_for(scope)
      end

      private

      def load_rspec_tasks
        Hexx::RSpec.install_tasks
      end

      def load_custom_tasks
        tasks = ::File.expand_path "../../tasks/**/*.rake", __FILE__
        ::Dir[tasks].each { |task| load task }
      end

    end # singleton class Suit

  end # module Suit

end # module Hexx
