# frozen_string_literal: true

require "slop"

module RepoBot
  class Main
    class << self
      attr_accessor :opts

      def start
        process_options

        output_file << RepoBot::Formatter::CSV.format(RepoBot.git_repos) +
                       RepoBot::Formatter::CSV.format(RepoBot.bitbucket_repos)
      end

      private

      def output_file
        opts[:output] ? File.open(opts[:output], "w") : $stdout
      end

      def process_options
        @opts = Slop.parse do |o|
          o.banner = "usage: #{$PROGRAM_NAME} [options] [directory]"
          o.bool "-c", "--csv", "Output information in CSV format. This is the default."
          # o.bool "-w", "--html", 'Output information in HTML ("web") format.'
          o.bool "-h", "--help", "Show this help information" do
            puts o
            exit
          end
          o.string "-o", "--output", "Write the information to the specified file, instead of STDOUT (the terminal)."
          o.on "-v", "--version", "Print the version of this program." do
            puts RepoBot::VERSION
            exit
          end
        end
      end
    end
  end
end
