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

      session_options = Statistic.session_keys.inject({}) do |hash, key|
        hash[key.to_sym] = session[key.to_sym] if session.has_key?(key.to_sym)
        hash
      end

      Statistic.create(options.merge(session_options))
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
        Statistic.key(key, type)
      end
    end
  end
end
