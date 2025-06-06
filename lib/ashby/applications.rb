# frozen_string_literal: true

module Ashby
  # Ashby::Applications provides access to job application-related operations via the Ashby API.
  #
  # Supported functionality includes:
  #   - Retrieving a paginated list of all applications
  #   - Fetching a specific application by its ID
  #
  # Example usage:
  #   Ashby::Applications.all
  #   Ashby::Applications.find_by_id(id: 'app_abc123')
  #
  class Applications < Client
    # Fetches all openings with pagination support
    def self.all
      paginated_post('applications.list')
    end

    # Finds an opening by its Ashby ID
    def self.find_by_id(id: nil)
      raise ArgumentError, 'Application ID is required' if id.to_s.strip.empty?

      payload = { applicationId: id }
      response = post('application.info', payload)
      response['results']
    end
  end
end
