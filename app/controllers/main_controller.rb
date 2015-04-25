class MainController < UIViewController

  def viewDidLoad
    super

    self.title = 'RedAlert'

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    rmq.append(UIScrollView, :containing_scroller).tap do |cs|

      # New UIAlertController Examples
      cs.append(UIView, :alert_controller_section).tap do |acs|
        acs.append(UILabel, :alert_controller_title)
        acs.append(UILabel, :usage_tour)

        # Simple alert example that has an OK button (RedAlert default),
        # doesn't care when it's pressed.
        acs.append(UIButton, :alert_controller_button).on(:tap) do
          rmq.app.alert("Minimal Alert")
        end

        # Alert example that has an OK button (RedAlert default),
        # puts a message when pressed.
        acs.append(UIButton, :alert_controller_two).on(:tap) do
          rmq.app.alert("Alert with Block") {
            puts "Alert with Block worked!"
          }
        end

        # Alert example with changed title and message.
        # OK button that prints the button's action_type
        acs.append(UIButton, :alert_controller_three).on(:tap) do
          rmq.app.alert(title: "New TITLE!", message: "So easy!") do |action_type|
            puts "you clicked #{action_type}"
          end
        end

        # Simple action sheet example.
        # OK button that doesn't care when pressed.
        acs.append(UIButton, :alert_controller_four).on(:tap) do
          rmq.app.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet) do |action_type|
            puts "you clicked #{action_type}"
          end
        end

        ##############################
        #  Multiple button examples
        ##############################


        # Alert example with 4 buttons, each made with `make_button` helper.
        acs.append(UIButton, :custom_actions_helper_alert).on(:tap) do
          ok = rmq.app.make_button {
            puts "OK pressed"
          }

          yes = rmq.app.make_button("Yes") {
            puts "Yes pressed"
          }

          cancel = rmq.app.make_button(title: "Cancel", style: :cancel) {
            puts "Cancel pressed"
          }

          destructive = rmq.app.make_button(title: "Destructive", style: :destructive) {
            puts "Destructive pressed"
          }

          button_list = [ok, yes, cancel, destructive]

          rmq.app.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list)
        end

        # Alert example with 4 buttons, each made with `make_button` helper.
        acs.append(UIButton, :custom_actions_helper_sheet).on(:tap) do
          ok = rmq.app.make_button {
            puts "OK pressed"
          }

          yes = rmq.app.make_button("Yes") {
            puts "Yes pressed"
          }

          cancel = rmq.app.make_button(title: "Cancel", style: :cancel) {
            puts "Cancel pressed"
          }

          destructive = rmq.app.make_button(title: "Destructive", style: :destructive) {
            puts "Destructive pressed"
          }

          button_list = [ok, yes, cancel, destructive]

          rmq.app.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list, style: :sheet)
        end

        acs.append(UILabel, :template_tour)


        # Action sheet with ease of the template
        acs.append(UIButton, :alert_controller_yesno).on(:tap) do
          rmq.app.alert(message: "Would you use Templates?", actions: :yes_no) do |title|
            case title
            when :yes
              puts "They are so easy!"
            when :no
              puts "No worries, we can build custom."
            end
          end
        end

        acs.append(UIButton, :alert_controller_yesnocancel).on(:tap) do
          rmq.app.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) do |title|
            case title
            when :yes
              puts "Here's your Sandwich!"
            when :no
              puts "FINE!"
            when :cancel
              puts "You hit cancel"
            end
          end
        end

        acs.append(UIButton, :alert_controller_okcancel).on(:tap) do
         rmq.app.alert(message: "Log Out?", actions: :ok_cancel) do |title|
            case title
            when :ok
              puts "Fictitiously logging you out"
            when :cancel
              puts "You hit cancel"
            end
          end
        end

        acs.append(UIButton, :alert_controller_deletecancel).on(:tap) do
         rmq.app.alert(title: "DESTROY!!!", message: "Would you like to remove some important data?", actions: :delete_cancel) do |title|
            case title
            when :delete
              puts "Destroying that data!"
            when :cancel
              puts "keep all the things!"
            end
          end
        end


      end.resize_frame_to_fit_subviews(bottom: 10, right: -5)



    end.resize_content_to_fit_subviews
  end

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
