require File.dirname(__FILE__) + '/../../test_helper'

module Mongolytics
  class StatisticTest < Test::Unit::TestCase
    context 'The Statistic class' do
      should "find count of stats for a given path" do
        Statistic.expects(:count).with({:path => '/users/1'}).returns(10201)
        Statistic.stats_for_path('/users/1').should == 10201
      end

      should "find count of stats for a given controller and action" do
        Statistic.expects(:count).with({:controller => 'users', :action => 'show'}).returns(11211)
        Statistic.stats_for_keys(:users, :show).should == 11211
      end
    end
  end
end
