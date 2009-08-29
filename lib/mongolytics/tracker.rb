module Mongolytics
  module Tracker
    def self.included(controller)
      controller.extend(ClassMethods)
    end

    def track_stat
      options = {
        :controller => params[:controller].to_s,
        :action => params[:action].to_s,
        :path => request.path
      }

      Statistic.create(options.merge(:sessions => [session], :params => [params]))
    end

    module ClassMethods
      def track_stats_for(*actions)
        after_filter :track_stat, :only => actions
      end

      def track_all_stats
        after_filter :track_stat
      end

      def track_view_stats
        track_stats_for :index, :show
      end

      def track_change_stats
        track_stats_for :create, :update, :destroy
      end

      def track_session_key(key, type = String)
        Session.key(key, type)
      end

      def track_params_key(key, type = String)
        Param.key(key, type)
      end
    end
  end
end
