require File.dirname(__FILE__) + '/../test_helper'

class MongolyticsTest < Test::Unit::TestCase
  context "The Mongolytics module" do
    should "delegate stats_for_path to Statistic" do
      Mongolytics::Statistic.expects(:stats_for_path).with('/users/1')
      Mongolytics.stats_for_path('/users/1')
    end

    should "delegate stats_for_keys to Statistic" do
      Mongolytics::Statistic.expects(:stats_for_keys).with(:users, :show, {})
      Mongolytics.stats_for_keys(:users, :show)
    end

    should "delegate stats_for_keys with session options to Statistic" do
      Mongolytics::Statistic.expects(:stats_for_keys).with(:users, :show, :user_id => 1)
      Mongolytics.stats_for_keys(:users, :show, :user_id => 1)
    end
  end
end
