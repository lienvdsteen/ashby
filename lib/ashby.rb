# frozen_string_literal: true

require_relative "ashby/version"
require_relative "ashby/configuration"
require_relative "ashby/client"
require_relative "ashby/candidates"

module Ashby
  extend Configuration

  class Error < StandardError; end
end
