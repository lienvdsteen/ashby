# frozen_string_literal: true

module Ashby
  # Ashby::Jobs handles interactions with job-related endpoints in the Ashby API.
  #
  # Supports fetching all jobs with pagination, finding a job by ID, and searching
  # jobs based on requisition ID or title.
  #
  # Example:
  #   Ashby::Jobs.all
  #   Ashby::Jobs.find('job_abc123')
  #   Ashby::Jobs.search(req_id: 'REQ-001')
  #
  class Jobs < Client
    # Fetches all jobs with pagination support
    def self.all(payload = {})
      paginated_post('job.list', payload)
    end

    # Finds a job by its Ashby ID
    def self.find(id, expand: '')
      raise ArgumentError, 'Job ID is required' if id.to_s.strip.empty?

      payload = {
        id: id,
        expand: expand.strip.empty? ? [] : [expand]
      }
      post('job.info', payload)['results']
    end

    # Searches for jobs based on requisition ID or title
    def self.search(req_id: nil, title: nil)
      payload = {}
      payload[:requisitionId] = req_id.to_s if req_id
      payload[:title] = title if title

      raise ArgumentError, 'You must provide at least a job title or a requisition id' if payload.empty?

      post('job.search', payload)['results']
    end

    # Fetches all job templates
    def self.templates
      paginated_post('jobTemplate.list')
    end

    def self.create(payload)
      required_fields = %i[title teamId locationId]
      missing = required_fields.select { |f| payload[f].to_s.strip.empty? }
      raise ArgumentError, "Missing required fields: #{missing.join(', ')}" if missing.any?

      post('job.create', payload)['results']
    end

    def self.update(id: nil, payload: {})
      raise ArgumentError, 'You must provide a job id' if id.nil?

      payload[:id] = id
      post('job.update', payload)['results']
    end

    def self.set_status(job_id:, status:)
      valid_statuses = %w[Draft Open Closed Archived]
      raise ArgumentError, 'Job ID is required' if job_id.to_s.strip.empty?
      raise ArgumentError, "Invalid status: #{status}" unless valid_statuses.include?(status)

      payload = {
        jobId: job_id,
        status: status
      }

      post('job.setStatus', payload)['results']
    end
  end
end
