module Ashby
  class JobBoards < Client
    def self.all
      post('jobBoard.list')
    end
  end
end
