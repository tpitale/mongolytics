module Mongolytics
  class Statistic
    include MongoMapper::Document

    key :controller, String, :required => true
    key :action, String, :required => true
    key :path, String

    BASE_KEYS = ["updated_at", "action", "_id", "controller", "path", "created_at"]

    def self.session_keys
      keys.map{|k,v| k} - BASE_KEYS
    end

    def self.stats_for_path(path)
      count({:path => path})
    end

    def self.stats_for_keys(controller, action, session_key_hash = {})
      count({:controller => controller.to_s, :action => action.to_s}.merge(session_key_hash))
    end
  end
end
