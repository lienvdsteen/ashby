# frozen_string_literal: true

module Ashby
  # Ashby::HiringTeams provides access to hiring team management functionality in the Ashby API.
  #
  # Includes support for:
  #   - Adding a member to a hiring team
  #   - Removing a member from a hiring team
  #
  # Example usage:
  #   Ashby::HiringTeams.add_hiring_team_member(type: :job, id: 'job_123', member_id: 'user_456', role_id: 'role_789')
  #   Ashby::HiringTeams.remove_hiring_team_member(type: :application, id: 'app_123', member_id: 'user_456',
  #   role_id: 'role_789')
  #
  class HiringTeams < Client
    def self.remove_hiring_team_member(type, id, member_id, role_id)
      payload = build_hiring_team_payload(type, id, member_id, role_id)
      response = post('hiringTeam.removeMember', payload)
      response['results']
    end

    def self.add_hiring_team_member(type, id, member_id, role_id)
      payload = build_hiring_team_payload(type, id, member_id, role_id)
      response = post('hiringTeam.addMember', payload)
      response['results']
    end

    def self.build_hiring_team_payload(type, id, member_id, role_id) # rubocop:disable Metrics/MethodLength
      payload = {}
      case type
      when :job
        payload[:jobId] = id.to_s if id
      when :application
        payload[:applicationId] = id.to_s
      when :opening
        payload[:openingId] = id.to_s
      else
        raise ArgumentError, "Invalid type: #{type}. Must be one of :job, :application, or :opening."
      end
      payload[:teamMemberId] = member_id if member_id
      payload[:roleId] = role_id if role_id
      payload
    end
  end
end
