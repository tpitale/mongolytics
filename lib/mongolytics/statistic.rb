module Mongolytics
  class Statistic
    include MongoMapper::Document

    key :controller, :string, :required => true
    key :action, :string, :required => true
    key :path, :string
    
    def self.stats_for_path(path)
      find(:conditions => {:path => path}).count
    end

    def self.stats_for_keys(controller, action)
      find(:conditions => {:controller => controller.to_s, :action => action.to_s}).count
    end
  end
end
