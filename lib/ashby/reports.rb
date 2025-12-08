# frozen_string_literal: true

module Ashby
  # Ashby::Reports provides access to report-related functionality in the Ashby API.
  #
  # Supports running reports synchronously and generating them asynchronously.
  # The synchronous endpoint has a 30-second timeout; for longer-running reports, use the
  # asynchronous generate method.
  #
  # Example:
  #   Ashby::Reports.synchronous(id: 'report_abc123')
  #
  #   # Async generation - two-step process
  #   result = Ashby::Reports.generate(id: 'report_abc123')
  #   request_id = result['requestId']
  #   # Poll until complete
  #   result = Ashby::Reports.generate(id: 'report_abc123', request_id: request_id)
  #
  class Reports < Client
    # Retrieves report data synchronously (30 second timeout)
    # If a report times out, use generate instead
    def self.synchronous(id: nil)
      raise ArgumentError, 'Report ID is required' if id.to_s.strip.empty?

      payload = { reportId: id }
      response = post('report.synchronous', payload)
      response['results']
    end

    # Generates a report asynchronously
    # Two-step process:
    # 1. Call with only report_id to start generation (returns request_id)
    # 2. Poll with both report_id and request_id until status is 'complete' or 'failed'
    def self.generate(id: nil, request_id: nil)
      raise ArgumentError, 'Report ID is required' if id.to_s.strip.empty?

      payload = { reportId: id }
      payload[:requestId] = request_id unless request_id.to_s.strip.empty?

      response = post('report.generate', payload)
      response['results']
    end
  end
end
