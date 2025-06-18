# frozen_string_literal: true

module Ashby
  # Custom error class for the Ashby module that extends StandardError
  # with optional error code support.
  #
  # This class provides a standardized way to handle errors within the Ashby
  # module by allowing both error messages and optional error codes to be
  # associated with exceptions.
  #
  # @example Basic usage with message only
  #   raise Ashby::Error.new("Something went wrong")
  #
  # @example Usage with message and error code
  #   raise Ashby::Error.new("API request failed", 500)
  #
  # @example Accessing the error code
  #   begin
  #     raise Ashby::Error.new("Not found", 404)
  #   rescue Ashby::Error => e
  #     puts e.message  # => "Not found"
  #     puts e.code     # => 404
  #   end
  #
  # @attr_reader [Object, nil] code The optional error code associated with this error
  class Error < StandardError
    attr_reader :code

    # Initialize a new Ashby::Error instance
    #
    # @param message [String] The error message
    # @param code [Object, nil] Optional error code (typically an integer, but can be any object)
    def initialize(message, code = nil)
      super(message)
      @code = code
    end
  end
end
