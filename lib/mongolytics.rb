$:.unshift File.dirname(__FILE__)

require 'mongolytics/statistic'
require 'mongolytics/tracker'

module Mongolytics
  def self.stats_for_path(path)
    Statistic.stats_for_path(path)
  end

  def self.stats_for_keys(controller, action)
    Statistic.stats_for_keys(controller, action)
  end
end