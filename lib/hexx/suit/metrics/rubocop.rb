module Hexx
  module Suit
    module Metrics

      # Prepares and runs rubocop environment from '.hexx-suit.yml'
      class Rubocop < Base

        # @!scope class
        # Sets ENV variables for rubocop rake tasks
        #
        # @return [self]
        def load
          ENV["RUBOCOP_FORMAT"] = options["format"]
          ENV["RUBOCOP_OUTPUT"] = options["output"]

          super
        end

        private

        # rubocop metric definitions

        def name
          :rubocop
        end

        def default_options
          { "format" => "html", "output" => "tmp/rubocop/index.html" }
        end

        # helpers

        def options
          @options ||= default_options.merge settings.to_h
        end
      end
    end
  end
end
