# frozen_string_literal: true

module Ashby
  # Ashby::Postings provides access to job posting related functionality in the Ashby API.
  #
  # It wraps the `jobPosting.info` and `jobPosting.list` endpoints and exposes a few
  # convenience helpers for commonly accessed nested fields such as `linkedData`
  # (for SEO rich results) and `applicationFormDefinition`.
  #
  # Endpoints referenced:
  #   - jobPosting.info   -> Retrieve a single job posting by ID
  #   - jobPosting.list   -> List job postings (optionally only those that are publicly listed)
  #   - jobPosting.update -> Update an existing job posting
  #
  # Example usage:
  #   Ashby::Postings.list                     # list all postings (listed + unlisted)
  #   Ashby::Postings.list(listed_only: true)  # only postings publicly listed
  #   Ashby::Postings.all                      # (deprecated) alias to .list
  #   Ashby::Postings.find('jp_abc123')        # posting hash
  #   Ashby::Postings.linked_data('jp_abc123') # structured data for SEO
  #   Ashby::Postings.application_form_definition('jp_abc123')
  #   Ashby::Postings.update(id: 'jp_abc123', payload: { title: 'Updated Title' })
  #
  # Note: A `Ashby::JobPostings` class already exists; this class provides a
  # cleaner name (`Postings`) and a couple of ergonomic helpers while delegating
  # to the same underlying API endpoints. Either class can be used interchangeably.
  #
  class Postings < Client
    # Lists job postings. By default returns both listed and unlisted job postings.
    # Pass listed_only: true to restrict to those safe for public display.
    # @param listed_only [Boolean, nil] When true only include publicly listed postings; when nil omit filter.
    def self.list(listed_only: nil)
      payload = {}
      payload[:listedOnly] = true if listed_only == true
      post('jobPosting.list', payload)['results']
    end

    # Deprecated: Use .list(listed_only: ...) instead. Retained for backward compatibility.
    def self.all(listed_only: nil, **_deprecated)
      Kernel.warn('[DEPRECATION] Ashby::Postings.all is deprecated. Use Ashby::Postings.list(listed_only: ...) instead.')
      list(listed_only: listed_only)
    end

    # Retrieve a single job posting by its Ashby Job Posting ID.
    # @param id [String] The Ashby Job Posting ID (e.g., "jp_abc123")
    # @return [Hash] The job posting object
    def self.find(id)
      raise ArgumentError, 'Job Posting ID is required' if id.to_s.strip.empty?

      payload = { jobPostingId: id }
      post('jobPosting.info', payload)['results']
    end
    class << self
      alias find_by_id find
      alias info find
    end

    # Convenience: Returns the `linkedData` section (for SEO rich results) of a posting.
    def self.linked_data(id)
      find(id)['linkedData']
    end

    # Convenience: Returns the `applicationFormDefinition` of a posting.
    def self.application_form_definition(id)
      find(id)['applicationFormDefinition']
    end

    # Update a job posting via jobPosting.update.
    # You must supply at least one field to update in the payload.
    #
    # @param id [String] The Ashby Job Posting ID
    # @param payload [Hash] Fields to update (see Ashby API docs for allowed keys)
    # @return [Hash] Updated job posting object
    def self.update(id:, payload: {})
      raise ArgumentError, 'Job Posting ID is required' if id.to_s.strip.empty?
      raise ArgumentError, 'Update payload cannot be empty' if payload.empty?

      body = payload.dup
      body[:jobPostingId] = id
      post('jobPosting.update', body)['results']
    end
  end
end
