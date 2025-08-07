# frozen_string_literal: true

module Ashby
  #
  # Ashby::Feedback provides access to feedback-related operations via the Ashby API.
  # # Supported functionality includes:
  #   - Retrieving a paginated list of all feedback
  # # Example usage:
  #   Ashby::Feedback.all
  #
  class Feedback < Client
    # Fetches all feedback with pagination support
    def self.all(payload = {})
      paginated_post('applicationFeedback.list', payload)
    end
  end
end
