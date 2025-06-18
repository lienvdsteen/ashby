# frozen_string_literal: true

require_relative 'ashby/version'
require_relative 'ashby/configuration'
require_relative 'ashby/client'
require_relative 'ashby/candidates'
require_relative 'ashby/departments'
require_relative 'ashby/jobs'
require_relative 'ashby/offers'
require_relative 'ashby/applications'
require_relative 'ashby/openings'
require_relative 'ashby/users'
require_relative 'ashby/job_postings'
require_relative 'ashby/hiring_team'
require_relative 'ashby/error'
require_relative 'ashby/close_reasons'
require_relative 'ashby/interviews'

# This module handles integration with Ashby's API
# for recruitment and hiring processes
module Ashby
  extend Configuration

  class Error < StandardError; end
end
