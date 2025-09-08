# frozen_string_literal: true

module Ashby
  class JobBoards < Client
    def self.all
      post('jobBoard.list')
    end
  end
end
