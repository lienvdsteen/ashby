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
  class Candidates < Client
    # Fetches all candidates with pagination support
    def self.all
      paginated_post('candidate.list')
    end

    # Finds a candidate by their email or name
    def self.find(email: nil, name: nil)
      payload = {}
      payload[:email] = email if email
      payload[:name] = name if name

      raise ArgumentError, 'You must provide at least an email or a name' if payload.empty?

      response = post('candidate.search', payload)
      response['results']
    end

    # Finds a candidate by their Ashby ID
    def self.find_by_id(id: nil)
      raise ArgumentError, 'Candidate ID is required' if id.to_s.strip.empty?

      payload = { id: id }
      response = post('candidate.info', payload)
      response['results']
    end

    # Creates a note on a candidates profile
    def create_candidate_note(candidate_id, note_content, send_notifications: false) # rubocop:disable Metrics/MethodLength
      payload = {
        candidateId: candidate_id,
        note: note_content,
        sendNotifications: send_notifications
      }

      response = post('candidate.createNote', payload)
      raise "Failed to create note: #{response['error']}" unless response['success']

      response['results']
    end
  end
end
