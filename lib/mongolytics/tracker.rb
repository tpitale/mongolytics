module Mongolytics
  module Tracker
    def self.included(controller)
      controller.extend(ClassMethods)
    end

    def track_stat
      controller = params[:controller].to_s
      action = params[:action].to_s
      path = request_uri.path

      Statistic.create(:controller => controller, :action => action, :path => path)
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
    end
  end
end
