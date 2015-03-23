module RubyMotionQuery
  class App
    class << self

      # Creates and shows the UIAlertController.
      # Usage Example:
      #   rmq.app.alert(message: "This is a test")
      #   rmq.app.alert(title: "Hey there", message: "Are you happy?")
      # @return [UIAlertController]
      def alert(opts = {}, &block)
        # Shortcut: assume a string is the message
        opts = {message: opts} if opts.is_a? String

        # An alert is nothing without a message
        raise(ArgumentError, "RedAlert alert requires a message") if RubyMotionQuery::RMQ.is_blank?(opts[:message])
        # iOS8 and above only for UIAlertController
        raise "RedAlert requires iOS8 for alerts.  Please try `rmq.app.alert_view`" unless rmq.device.ios_at_least? 8
        core_alert(opts, &block)
      end

      # Returns a UIAlertAction from given parameters
      # Usage Example:
      #   yes = rmq.make_button("Yes")
      #   cancel = rmq.make_button(title: "Cancel", style: :cancel) {
      #      puts "Cancel pressed"
      #   }
      # @return [UIAlertAction]
      def make_button (opts = {}, &block)
        # shortcut sending a string
        opts = {title: opts} if opts.is_a? String

        opts = {
          title: "OK",
          style: :default,
        }.merge(opts)

        style = RubyMotionQuery::AlertConstants::ALERT_ACTION_STYLE[opts[:style]] || opts[:style]

        UIAlertAction.actionWithTitle(opts[:title], style: style, handler: -> (action) {
          title_symbol = action.title.gsub(/\s+/,"_").downcase.to_sym
          block.call(title_symbol) unless block.nil?
        })
      end

    end # close eigenclass

  end # close App
end