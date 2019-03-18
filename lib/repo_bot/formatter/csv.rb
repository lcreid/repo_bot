# frozen_string_literal: true

require "csv"

module RepoBot
  module Formatter
    # Format the reponse from a RepoBot query to a RepoHost.
    class CSV
      class << self
        # Format an array of hashes into a CSV file.
        # @param repo_list [repo_list] A reponse from a RepoBot query to a RepoHost.
        # @return [String] The repo_list converted to a CSV-formatted string.
        def format(repo_list)
          keys = repo_list.flat_map(&:keys).uniq
          ::CSV.generate do |csv|
            csv << keys
            repo_list.each do |item|
              csv << keys.map { |k| item[k] }
            end
          end
        end
      end
    end
  end
end
