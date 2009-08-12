require File.dirname(__FILE__) + '/../../test_helper'

class FauxController
  include Mongolytics::Tracker
end

module Mongolytics
  class TrackerTest < Test::Unit::TestCase
    context "A Controller with Tracker mixed-in" do
      should "create an after_filter for the specified actions" do
        FauxController.expects(:after_filter).with(:track_stat, :only => [:new, :edit])
        FauxController.track_stats_for :new, :edit
      end

      should "create an after_filter for all actions" do
        FauxController.expects(:after_filter).with(:track_stat)
        FauxController.track_all_stats
      end

      should "create an after_filter for index, show" do
        FauxController.expects(:after_filter).with(:track_stat, :only => [:index, :show])
        FauxController.track_view_stats
      end

      should "create an after_filter for create, update, destroy" do
        FauxController.expects(:after_filter).with(:track_stat, :only => [:create, :update, :destroy])
        FauxController.track_change_stats
      end

      should "add a session key to Statistic" do
        Statistic.expects(:key).with(:username, String)
        FauxController.track_session_key :username
      end

      should "allow override of class type for key added to Statistic" do
        Statistic.expects(:key).with(:user_id, Integer)
        FauxController.track_session_key :user_id, Integer        
      end
    end

    context "An instance of a Controller with Tracker mixed-in" do
      should "create a statistic with controller, action, and path" do
        controller = FauxController.new
        
        controller.stubs(:request).returns(stub(:path => '/users/1'))
        controller.stubs(:params).returns({:controller => 'faux', :action => 'show'})
        controller.stubs(:session).returns({})

        Statistic.expects(:create).with(:controller => 'faux', :action => 'show', :path => '/users/1').returns(true)
        assert controller.track_stat
      end

      should "create a statistic with controller, action, path, and user_id" do
        FauxController.track_session_key :user_id, Integer
        controller = FauxController.new

        controller.stubs(:request).returns(stub(:path => '/users/1'))
        controller.stubs(:params).returns({:controller => 'faux', :action => 'show'})
        controller.stubs(:session).returns({:user_id => 1})

        Statistic.expects(:create).with(:controller => 'faux', :action => 'show', :path => '/users/1', :user_id => 1).returns(true)
        assert controller.track_stat
      end
    end
  end
end