# frozen_string_literal: true

require "csv"

module RepoBot
  module Formatter
    # Format the reponse from a RepoBot query to a RepoHost.
    class CSV
      class << self
        # Format an array of hashes into a CSV file.
        # @param response [Response] A reponse from a RepoBot query to a RepoHost.
        # @return [String] The response converted to a CSV-formatted string.
        def format(response)
          keys = response.to_json.flat_map(&:keys).uniq
          ::CSV.generate do |csv|
            csv << keys
            response.to_json.each do |item|
              csv << keys.map { |k| item[k] }
            end
          end
        end
      end
    end
  end
end
