module Hexx
  module Suit

    # The generator creates a Rakefile in a destination root
    class Install < Thor::Group
      include Thor::Actions

      # @!scope class
      # @!method start(args)
      # Populates the necessary files into current directory
      #
      # @param  [Array<String>] args An array of arguments from CLI (ARGV etc.)
      #
      # @return [undefined]
      #
      # @api public

      # Root folder for the generator's templates
      #
      # @return [String]
      #
      # @api private
      def self.source_root
        @source_root ||= File.expand_path "../install", __FILE__
      end

      namespace :install
      desc "Installs the 'hexx-suit' gem."

      # Creates the Rakefile
      #
      # @return [undefined]
      #
      # @api private
      def create_rakefile
        copy_file "Rakefile"
      end

      # Creates the Guardfile
      #
      # @return [undefined]
      #
      # @api private
      def create_guardfile
        copy_file "Guardfile"
      end

      # Creates the .rspec settings
      #
      # @return [undefined]
      #
      # @api private
      def create_rspec
        copy_file "_rspec", ".rspec"
      end

      # Creates the .yardopts settings
      #
      # @return [undefined]
      #
      # @api private
      def create_yardopts
        copy_file "_yardopts", ".yardopts"
      end

      # creates the metric settings
      #
      # @return [undefined]
      #
      # @api private
      def create_metrics
        directory "metrics", "config/metrics"
      end

      # creates metric_fu loader
      #
      # @return [undefined]
      #
      # @api private
      def create_metrics_loader
        copy_file "_metrics", ".metrics"
      end
    end # class Install
  end # module Suit
end # module Hexx
