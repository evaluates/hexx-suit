# Shared namespace for the Hexx-based gems
module Hexx

  # Namespace for the module.
  #
  # @api public
  module Suit
    class << self

      # Loads all the necessary rake tasks
      #
      # @example
      #   Hexx::Suit.install_tasks
      #
      # @return [self]
      def install_tasks
        load_gem_tasks
        load_rspec_tasks
        load_custom_tasks

        self
      end

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

      # Loads bundler rake tasks
      #
      # @return [self]
      #
      # @api private
      def load_gem_tasks
        require "bundler/gem_tasks"
        ::Bundler::GemHelper.install_tasks

        self
      end

      # Loads rspec +spec+ rake task
      #
      # @return [self]
      #
      # @api private
      def load_rspec_tasks
        require "rspec/core/rake_task"
        ::RSpec::Core::RakeTask.new(:spec)

        self
      end

      # Loads rake tasks, defined in the gem
      #
      # @return [self]
      #
      # @api private
      def load_custom_tasks
        tasks = ::File.expand_path "../../tasks/**/*.rake", __FILE__
        ::Dir[tasks].each { |task| load task }

        self
      end
    end # singleton_class Suit
  end # module Suit
end # module Hexx
