# frozen_string_literal: true

module Ashby
  # Ashby::Candidates provides access to candidate-related functionality in the Ashby API.
  #
  # Includes support for:
  #   - Fetching all candidates (with pagination)
  #   - Searching by email or name
  #   - Looking up by ID
  #   - Adding notes to candidate profiles in plain text or HTML
  #
  # Example:
  #   Ashby::Candidates.all
  #   Ashby::Candidates.find(email: 'jane@company.com')
  #   Ashby::Candidates.find_by_id(id: 'cand_abc123')
  #
  #   client = Ashby::Candidates.new
  #   client.create_candidate_note('cand_abc123', 'Reached out via email.')
  #   client.create_formatted_candidate_note('cand_abc123', title: 'Initial Contact',
  #     content: 'Spoke with Jane over Zoom.')
  #
  class Openings < Client
    # Fetches all openings with pagination support
    def self.all
      paginated_post('opening.list')
    end

    # Finds an opening by its Ashby ID
    def self.find(email: nil, name: nil)
      payload = {}
      payload[:email] = email if email
      payload[:name] = name if name

      raise ArgumentError, 'You must provide at least an email or a name' if payload.empty?

      response = post('opening.search', payload)
      response['results']
    end

    # Finds an opening by its Ashby ID
    def self.find_by_id(id: nil)
      raise ArgumentError, 'Opening ID is required' if id.to_s.strip.empty?

      payload = { id: id }
      response = post('opening.info', payload)
      response['results']
    end
  end
end
