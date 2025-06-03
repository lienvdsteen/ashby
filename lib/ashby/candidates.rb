module Ashby
  class Candidates < Client
    def self.all
      post('candidate.list')
    end
  end
end
