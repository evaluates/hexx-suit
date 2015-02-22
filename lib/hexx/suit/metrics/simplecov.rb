module Hexx
  module Suit
    module Metrics

      # Prepares and runs pippi environment
      #
      # @api private
      class SimpleCov < Base

        # Loads the simplecov and coveralls gem
        #
        # @return [Hexx::Suit::Metrics::SimpleCov]
        #
        # @api private
        def self.new
          %w(simplecov coveralls).each { |gem| require gem }
          super
        end

        # @!scope class
        # Configures the SimpleCov metric
        #
        # @return [self]
        def load
          set_environment
          configure_metric

          self
        end

        # @!scope class
        # Configures simplecov from the simplecov.yml file and starts
        # the metric
        #
        # @return [undefined]
        def run
          metric.start
        end

        private

        # simplecov metric definitions

        def name
          "simplecov"
        end

        def metric
          ::SimpleCov
        end

        def default_options
          {
            "output"  => "tmp/coverage",
            "filters" => ["spec/", "config/"],
            "groups"  => {
              "Libraries" => "lib/",
              "Application" => "app/"
            }
          }
        end

        # operations

        def set_environment
          ENV["USE_SIMPLECOV"]    = "true"
          ENV["SIMPLECOV_OUTPUT"] = "#{ output }/index.html"
        end

        def configure_metric
          add_filters
          add_groups
          set_formatters
          set_output
        end

        def add_filters
          filters.each(&metric.method(:add_filter))
        end

        def add_groups
          groups.each { |key, value| metric.add_group(key, value) }
        end

        def set_formatters
          metric.formatter = metric::Formatter::MultiFormatter[
            metric::Formatter::HTMLFormatter,
            ::Coveralls::SimpleCov::Formatter
          ]
        end

        def set_output
          metric.coverage_dir output
        end

        # helpers

        def options
          @options ||= default_options.merge settings.to_h
        end

        def output
          @output = options["output"]
        end

        def filters
          @filters ||= Array(options["filters"]).flatten.map(&:to_s)
        end

        def groups
          @groups ||= begin
            list = options["groups"]
            list.is_a?(Hash) ? list : {}
          end
        end
      end
    end
  end
end
