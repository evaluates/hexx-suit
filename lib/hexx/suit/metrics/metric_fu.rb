# encoding: utf-8

module Hexx
  module Suit
    module Metrics

      # Configurator for the metric_fu and all its subpackages
      class MetricFu < Base

        # Loads the metric_fu gem dependency
        #
        # @return [Hexx::Suit::Metrics::MetricFu]
        def self.new
          require "metric_fu"
          super
        end

        # Loads common settings and configures metrics
        #
        # @return [self]
        def load
          set_environment
          configure_metric_fu
          configure_packages

          super
        end

        private

        # metric_fu definitions

        def packages
          %w(
            cane churn flay flog reek roodi saikuro
            hotspots rails_best_practices rcov stats
          )
        end

        def name
          :metric_fu
        end

        def default_options
          {
            "folders" => %(lib app),
            "format"  => "html",
            "metrics" => %(cane churn flay flog reek roodi saikuro),
            "output"  => "tmp/metric_fu",
            "verbose" => false
          }
        end

        def configuration
          ::MetricFu::Configuration
        end

        # operations

        def set_environment
          ENV["METRIC_FU_OUTPUT"] = options["output"]
        end

        def configure_metric_fu
          configuration.run do |config|
            config.configure_formatter options["format"].to_sym
            config.verbose = options["verbose"]
          end
        end

        def configure_packages
          packages.map { |item| "configure_#{ item }" }.each(&method(:send))
        end

        def configure_cane
          configure(:cane) do |metric|
            metric.dirs_to_cane = folders
            Cane.load # loads settings from cane.yml
          end
        end

        def configure_churn
          configure(:churn) do |metric|
            metric.configured_run_options[:dirs_to_churn] = folders
            Churn.load # loads settings from churn.yml
          end
        end

        def configure_flog
          configure(:flog) do |metric|
            metric.dirs_to_flog = folders
            # no additional settings exist
          end
        end

        def configure_flay
          configure(:flay) do |metric|
            metric.dirs_to_flay = folders
            Flay.load # loads settings from flay.yml
          end
        end

        def configure_hotspots
          configure(:hotspots)
        end

        def configure_rails_best_practices
          configure(:rails_best_practices)
        end

        def configure_rcov
          configure(:reek) do |metric|
            metric.configured_run_options[:dirs_to_rcov] = folders
          end
        end

        def configure_reek
          configure(:reek) do |metric|
            metric.dirs_to_reek = folders
            Reek.load # loads settings from reek.yml
          end
        end

        def configure_roodi
          configure(:roodi) do |metric|
            metric.dirs_to_roodi = folders
            Roodi.load # loads settings from roodi.yml
          end
        end

        def configure_saikuro
          configure(:saikuro) do |metric|
            metric.input_directory = folders
            Saikuro.load # loads settings from saikuro.yml
          end
        end

        def configure_stats
          configure(:stats)
        end

        # helpers

        def configure(name)
          configuration.configure_metric(name) do |metric|
            metric.enabled = metrics.include? name.to_s
            yield(metric) if block_given?
          end
        end

        def options
          @options ||= default_options.merge settings.to_h
        end

        def metrics
          @metrics ||= options["metrics"]
        end

        def folders
          @folders ||= options["folders"]
        end
      end
    end
  end
end
