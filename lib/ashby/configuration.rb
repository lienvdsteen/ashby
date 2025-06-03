# frozen_string_literal: true

module Ashby
  # Ashby::Configuration manages global settings for the Ashby API client.
  #
  # This module is intended to be extended by a class or module that needs
  # to hold configuration settings such as the API token.
  #
  # Example:
  #   Ashby::Configuration.configure do |config|
  #     config.api_token = 'your-token'
  #   end
  #
  #   Ashby::Configuration.config
  #   # => { api_token: 'your-token' }
  #
  module Configuration
    VALID_OPTIONS_KEYS = %i[api_token].freeze
    attr_accessor(*VALID_OPTIONS_KEYS)

    # Sets all configuration options to their default values
    # when this module is extended.
    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def config
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Resets all configuration options to the defaults.
    def reset
      self.api_token = nil
    end
  end
end
