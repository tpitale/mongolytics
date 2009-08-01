module Mongolytics
  class Statistic
    include MongoMapper::Document

    key :controller, String, :required => true
    key :action, String, :required => true
    key :path, String
    
    def self.stats_for_path(path)
      all(:conditions => {:path => path}).count
    end

    def self.stats_for_keys(controller, action)
      all(:conditions => {:controller => controller.to_s, :action => action.to_s}).count
    end
  end
end
