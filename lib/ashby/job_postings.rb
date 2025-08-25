# frozen_string_literal: true

module Ashby
  # Ashby::JobPostings provides access to job posting-related functionality in the Ashby API.
  #
  # Includes support for:
  #   - Fetching all job postings (active only by default, can include inactive)
  #   - Looking up a job posting by its Ashby ID
  #
  # Example usage:
  #   Ashby::JobPostings.all
  #   Ashby::JobPostings.all(active_only: false)
  #   Ashby::JobPostings.find_by_id(id: 'jp_abc456')
  #
  class JobPostings < Client
    # Fetches all job postings
    def self.all(active_only: true, job_board_id: nil)
      payload = { active_only: active_only }
      payload[:job_board_id] = job_board_id if job_board_id

      response = post('jobPosting.list', payload)
      response['results']
    end

    # Finds a Job Posting by the Ashby ID
    def self.find_by_id(id: nil)
      raise ArgumentError, 'Job Posting ID is required' if id.to_s.strip.empty?

      payload = { jobPostingId: id }
      response = post('jobPosting.info', payload)
      response['results']
    end

    # Finds all Job Postings associated with a given Job ID
    def self.by_job_id(job_id: nil)
      raise ArgumentError, 'Job ID is required' if job_id.to_s.strip.empty?

      payload = { id: job_id }
      response = post('job.info', payload)
      job_posting_ids = response.dig('results', 'jobPostingIds') || []

      job_posting_ids.map { |jp_id| find_by_id(id: jp_id) }
    end
  end
end
