module ActiveSupport
  module Notifications
    # This is a default queue implementation that ships with Notifications. It
    # just pushes events to all registered log subscribers.
    class Fanout
      def initialize
        @subscribers = []
        @listeners_for = {}
      end

      def subscribe(pattern = nil, block = Proc.new)
        @listeners_for.clear
        Subscriber.new(pattern, block).tap do |s|
          @subscribers << s
        end
      end

      def unsubscribe(subscriber)
        @listeners_for.clear
        @subscribers.reject! {|s| s.matches?(subscriber)}
      end

      def publish(name, *args)
        listeners_for(name).each { |s| s.publish(name, *args) }
      end

      def listeners_for(name)
        @listeners_for[name] ||= @subscribers.select { |s| s.subscribed_to?(name) }
      end

      # This is a sync queue, so there is not waiting.
      def wait
      end

      class Subscriber #:nodoc:
        def initialize(pattern, delegate)
          @pattern = pattern
          @delegate = delegate
        end

        def publish(message, *args)
          @delegate.call(message, *args)
        end

        def subscribed_to?(name)
          !@pattern || @pattern === name.to_s
        end

        def matches?(subscriber_or_name)
          self === subscriber_or_name ||
            @pattern && @pattern === subscriber_or_name
        end
      end
    end
  end
end
