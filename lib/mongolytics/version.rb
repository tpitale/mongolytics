module Mongolytics
  module Version
    
    MAJOR = 0
    MINOR = 0
    TINY  = 1
    
    def self.to_s # :nodoc:
      [MAJOR, MINOR, TINY].join('.')
    end    
  end
end