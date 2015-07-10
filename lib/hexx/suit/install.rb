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
      def update_spec_helper
        template "spec/spec_helper.erb", "spec/spec_helper.rb", force: true
      end

      # @private
      def create_rakefile
        template "Rakefile.erb", "Rakefile"
      end

      # @private
      def create_guardfile
        template "Guardfile.erb", "Guardfile"
      end

      # @private
      def create_yardopts
        template "_yardopts.erb", ".yardopts"
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
          "Gemfile", %(
          |group :metrics do
          |  gem "hexx-suit", "~> #{version}" if RUBY_ENGINE == "ruby"
          |end
          |).gsub(/ *\|/, ""),
          skip: true
        )
      end

      private

      def version
        Hexx::Suit::VERSION.split(".")[0..1].join(".")
      end

      def gemname
        @gemname ||= ::File.basename(destination_root).downcase
      end

      def namespace
        @namespace ||=
          gemname
          .split("-")
          .map { |item| item.split("_").map(&:capitalize).join }
          .join("::")
      end

    end # class Install

  end # module Suit

end # module Hexx
