# frozen_string_literal: true

# a4e6d71d-b125-4905-93a0-1a339e69b839

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
    def self.all
      paginated_post('job.list')
    end

    # Finds a job by its Ashby ID
    def self.find(id)
      raise ArgumentError, 'Job ID is required' if id.to_s.strip.empty?

      payload = { id: id }
      response = post('job.info', payload)
      response['results']
    end

    # Searches for jobs based on requisition ID or title
    def self.search(req_id: nil, title: nil)
      payload = {}
      payload[:requisitionId] = req_id.to_s if req_id
      payload[:title] = title if title

      raise ArgumentError, 'You must provide at least a job title or a requisition id' if payload.empty?

      response = post('job.search', payload)
      response['results']
    end

    # Fetches all job templates
    def self.templates
      paginated_post('jobTemplate.list')
    end

    def self.create(payload)
      required_fields = %i[title teamId locationId]
      missing = required_fields.select { |f| payload[f].to_s.strip.empty? }
      raise ArgumentError, "Missing required fields: #{missing.join(', ')}" if missing.any?

      response = post('job.create', payload)
      response['results']
    end

    def self.remove_hiring_team_member(job_id, member_id, role_id)
      payload = build_hiring_team_payload(job_id, member_id, role_id)
      response = post('hiringTeam.removeMember', payload)
      response['results']
    end

    def self.add_hiring_team_member(job_id, member_id, role_id)
      payload = build_hiring_team_payload(job_id, member_id, role_id)
      response = post('hiringTeam.addMember', payload)
      response['results']
    end

    private

    def self.build_hiring_team_payload(job_id, member_id, role_id)
      payload = {}
      payload[:jobId] = job_id.to_s if job_id
      payload[:teamMemberId] = member_id if member_id
      payload[:roleId] = role_id if role_id
      payload
    end
  end
end
