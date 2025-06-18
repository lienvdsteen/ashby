# frozen_string_literal: true

module Ashby
  # Ashby::CloseReasons provides access to close reason related functionality in the Ashby API.
  #
  # Includes support for:
  #   - Fetching all close reasons (with pagination)
  #
  # Example:
  #   Ashby::CloseReasons.all
  #
  class CloseReasons < Client
    # Fetches all openings with pagination support
    def self.all
      response = post('closeReason.list')
      response['results']
    end
  end
end
