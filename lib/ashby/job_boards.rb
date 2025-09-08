# frozen_string_literal: true

module Ashby
  class JobBoards < Client
    def self.all
      response = post('jobBoard.list')
      response['results']
    end
  end
end
