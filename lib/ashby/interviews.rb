# frozen_string_literal: true

module Ashby
  # Ashby::InterviewSchedules provides access to Interview Schedule-related functionality in the Ashby API.
  #
  # Includes support for:
  #   - Fetching all interviews (with pagination)
  #
  # Example:
  #   Ashby::InterviewSchedules.all
  #
  class Interviews < Client
    # Fetches all interview schedules with pagination support
    def self.schedule_all(payload = {})
      paginated_post('interviewSchedule.list', payload)
    end

    def self.plans_all
      response = post('interviewPlan.list')
      response['results']
    end

    def self.stages_all
      response = post('interviewStage.list')
      response['results']
    end

    def self.interview_by_id(id: nil)
      raise ArgumentError, 'Interview ID is required' if id.to_s.strip.empty?

      payload = { id: id }
      response = post('interview.info', payload)
      response['results']
    end

    def self.stage_by_id(id: nil)
      raise ArgumentError, 'Stage ID is required' if id.to_s.strip.empty?

      payload = { interviewStageId: id }
      response = post('interviewStage.info', payload)
      response['results']
    end
  end
end
