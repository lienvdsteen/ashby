# frozen_string_literal: true

module Ashby
  # Ashby::Users provides access to user-related functionality in the Ashby API.
  #
  # Includes support for:
  #   - Fetching all users with pagination
  #   - Searching users by email
  #   - Looking up users by their Ashby ID
  #
  # Example usage:
  #   Ashby::Users.all
  #   Ashby::Users.find_by_email(email: 'recruiter@company.com')
  #   Ashby::Users.find_by_id(id: 'user_xyz789')
  #
  class Users < Client
    # Fetches all users with pagination support
    def self.all
      paginated_post('user.list')
    end

    # Find a user by their email
    def self.find_by_email(email: nil)
      payload = {}
      payload[:email] = email if email

      raise ArgumentError, 'You must provide an email' if payload.empty?

      response = post('user.search', payload)
      response['results']
    end

    # Finds a user by their Ashby ID
    def self.find_by_id(id: nil)
      raise ArgumentError, 'User ID is required' if id.to_s.strip.empty?

      payload = { userId: id }
      response = post('user.info', payload)
      response['results']
    end
  end
end
