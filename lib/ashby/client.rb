# frozen_string_literal: true

require "rest-client"
require "json"

module Ashby
  class Client
    API_URL = "https://api.ashbyhq.com"

    def self.get(path, params = {})
      url = build_url(path, params)
      response = RestClient.get(url, headers)
      JSON.parse(response.body)
    end

    def self.post(path, payload = {})
      url = build_url(path, {})
      response = RestClient.post(url, payload.to_json, headers.merge({ content_type: :json }))
      JSON.parse(response.body)
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
        Accept: "application/json",
        Authorization: "Basic #{Base64::strict_encode64(token)}"
      }
    end
  end
end
