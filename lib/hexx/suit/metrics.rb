# encoding: utf-8

module Hexx

  module Suit

    # Contains metric configurators
    #
    # Any configurator loads metric settings from a corresponding yaml,
    # sets necessary environments via {.load} method,
    # and then runs the metric via {.run} method.
    #
    # Configurators loads their own dependencies in a corresponding constructor.
    module Metrics

      require_relative "metrics/base"
      require_relative "metrics/metric_fu"
      require_relative "metrics/rubocop.rb"
      require_relative "metrics/simplecov.rb"
      require_relative "metrics/yardstick.rb"
      require_relative "metrics/pippi.rb" if USE_PIPPI_METRIC

    end

  end # module Suit

end # mdoule Hexx
