# frozen_string_literal: true

module Ashby
  # Ashby::Offers provides access to offer-related endpoints in the Ashby API.
  #
  # Supports fetching all offers with pagination and retrieving a specific offer by ID.
  #
  # Example:
  #   Ashby::Offers.all
  #   Ashby::Offers.find(id: 'offer_xyz789')
  #
  class Offers < Client
    # Fetches all offers with pagination support
    def self.all
      paginated_post('offer.list')
    end

    # Finds an offer by its Ashby ID
    def self.find(id: nil)
      raise ArgumentError, 'Offer ID is required' if id.to_s.strip.empty?

      payload = { id: id }
      response = post('offer.info', payload)
      response['results']
    end

    def self.offers_by_application_id(application_id: nil)
      raise ArgumentError, 'Application ID is required' if application_id.to_s.strip.empty?

      payload = { applicationId: application_id }
      response = post('offer.list', payload)
      response['results']
    end

    def self.most_recent_offer_by_application_id(application_id: nil)
      raise ArgumentError, 'Application ID is required' if application_id.to_s.strip.empty?

      payload = { applicationId: application_id }
      response = post('offer.list', payload)
      response['results'].max_by { |o| o['latestVersion']['createdAt'] }
    end
  end
end
