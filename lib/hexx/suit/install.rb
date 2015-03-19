# encoding: utf-8

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

      # @private
      def self.source_root
        @source_root ||= File.expand_path "../install", __FILE__
      end

      namespace :install
      desc "Installs the 'hexx-suit' gem."

      # @private
      def install_rspec
        Hexx::RSpec::Install.start %w(--no-rakefile)
      end

      # @private
      def create_rakefile
        copy_file "Rakefile"
      end

      # @private
      def create_guardfile
        copy_file "Guardfile"
      end

      # @private
      def create_yardopts
        copy_file "_yardopts", ".yardopts"
      end

      # @private
      def create_metrics
        directory "metrics", "config/metrics"
      end

      # @private
      def create_metrics_loader
        copy_file "_metrics", ".metrics"
      end

      # @private
      def create_rubocop_loader
        copy_file "_rubocop.yml", ".rubocop.yml"
      end

      # @private
      def create_gemfile
        copy_file "Gemfile", skip: true
        append_to_file(
          "Gemfile",
          "\ngem \"hexx-suit\", \"~> #{ version }\"," \
          " group: :metrics if RUBY_ENGINE == \"ruby\"\n",
          skip: true
        )
      end

      private

      def version
        Hexx::Suit::VERSION.split(".")[0..1].join(".")
      end

    end # class Install

  end # module Suit

end # module Hexx
