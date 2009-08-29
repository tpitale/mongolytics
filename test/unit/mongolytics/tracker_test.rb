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

      should "add a session key to Session" do
        Session.expects(:key).with(:username, String)
        FauxController.track_session_key :username
      end

      should "allow override of class type for a session key added to Session" do
        Session.expects(:key).with(:user_id, Integer)
        FauxController.track_session_key :user_id, Integer        
      end

      should "add a params key to Session" do
        Param.expects(:key).with(:username, String)
        FauxController.track_params_key :username
      end

      should "allow override of class type for a params key added to Session" do
        Param.expects(:key).with(:user_id, Integer)
        FauxController.track_params_key :user_id, Integer
      end
    end

    context "An instance of a Controller with Tracker mixed-in" do
      should "create a statistic with controller, action, and path" do
        controller = FauxController.new
        
        params = {:controller => 'faux', :action => 'show'}
        session = {}

        controller.stubs(:request).returns(stub(:path => '/users/1'))
        controller.stubs(:params).returns(params)
        controller.stubs(:session).returns(session)

        Statistic.expects(:create).with({
          :controller => 'faux',
          :action => 'show',
          :path => '/users/1',
          :params => [params],
          :sessions => [session]
        }).returns(true)

        assert controller.track_stat
      end
    end
  end
end