module Hexx
  module Suit

    # Contains utilitity classes
    module Utils

      # The utility sends multiline string to system
      #
      # Allows stubbing system calls in specifications.
      #
      # @example
      #   System.call %(
      #     inch --pedantic
      #     rubocop
      #   )
      #
      # @api private
      class System < String

        # Initializes multiline text to be sent to system
        #
        # Removes repetitive spaces from itself
        #
        # @param [#to_s] text
        #   Multiline text to be sent to system
        #
        # @return [undefined]
        def initialize(text)
          super
          strip!
          gsub!(/ {2,}/, " ")
        end

        # Returns non-empty lines without trailing spaces
        #
        # @return [Array<String>]
        def lines
          super.map(&:strip).reject(&:empty?)
        end

        # Sends itself to system line by line
        #
        # @return [self]
        def call
          lines.each(&method(:system))

          self
        end

        # Sends multiline string to system
        #
        # @example (see Hexx::Suit::Utils::System)
        #
        # @param  (see #initialize)
        #
        # @return [Hexx::Suit::Utils::System]
        #   utility object (allows chaining)
        def self.call(text)
          new(text).call

          self
        end
      end # class System
    end # module Utils
  end # module Suit
end # module Hexx
