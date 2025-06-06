# frozen_string_literal: true

require 'rest-client'
require 'json'

module Ashby
  # Ashby::Client is a low-level internal class that provides HTTP communication
  # with the Ashby API.
  #
  # It defines base `post` and `paginated_post` methods for making JSON API calls,
  # managing authentication, and handling paginated responses.
  #
  # This class is extended by endpoint-specific service classes (e.g., Jobs, Offers).
  #
  # Example usage:
  #   Ashby::Client.post('job.info', { id: 'job_abc123' })
  #   Ashby::Client.paginated_post('job.list')
  #
  # Note:
  #   Ensure `Ashby.api_token` is set before making requests.
  #
  # TODO:
  #   Consider implementing syncToken support for incremental pagination.
  #
  class Client
    API_URL = 'https://api.ashbyhq.com'

    def self.post(path, payload = {})
      url = build_url(path, {})
      response = RestClient.post(url, payload.to_json, headers.merge({ content_type: :json }))
      JSON.parse(response.body)
    end

    def self.paginated_post(path, payload = {}, limit: 100) # rubocop:disable Metrics/MethodLength
      all_results = []
      cursor = nil

      loop do
        paginated_payload = payload.dup
        paginated_payload[:limit] = limit
        paginated_payload[:cursor] = cursor if cursor

        response = post(path, paginated_payload)

        page_results = response['data'] || response['results'] || response

        if page_results.is_a?(Array)
          all_results.concat(page_results)
        else
          all_results << page_results
        end

        break unless response['moreDataAvailable'] && response['nextCursor']

        cursor = response['nextCursor']
      end

      all_results
    end

    def self.build_url(path, params)
      url = "#{API_URL}/#{path}"
      url += "?#{URI.encode_www_form(params)}" unless params.empty?
      p url
      url
    end

    def self.headers
      token = "#{Ashby.api_token}:"
      {
        Accept: 'application/json',
        Authorization: "Basic #{Base64.strict_encode64(token)}"
      }
    end
  end
end
