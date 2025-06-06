# frozen_string_literal: true

module Ashby
  # Ashby::Departments provides methods to interact with the
  # Ashby API's department-related endpoints.
  #
  # Includes fetching a list of departments and retrieving a specific department by ID.
  #
  # Example:
  #   Ashby::Departments.all
  #   Ashby::Departments.find(id: 'abc123')
  #
  class Departments < Client
    # Fetches all departments
    def self.all
      response = post('department.list')
      response['results']
    end

    # Finds a department by its Ashby ID
    def self.find(id: nil)
      raise ArgumentError, 'Department ID is required' if id.to_s.strip.empty?

      payload = { departmentId: id }
      response = post('department.info', payload)
      response['results']
    end
  end
end
