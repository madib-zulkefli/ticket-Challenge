# frozen_string_literal: true

require_relative 'menu_quit_exception'

# this class will act as an invoker in a command pattern
# it will contain all the menu option "command" objects
# and will run the command selected at runtime
class MenuInvoker
  def initialize(menu_options)
    @menu_options_list = menu_options
    @selected_option = nil
  end

  def display_menu
    for menu_options in @menu_options_list
      menu_options.display_prompt
    end
  end

  # this is called after all the options are displayed
  # it gets the user's response and compares it to the options
  # then saves the selected option
  def compare_response
    puts 'Enter your choice: '
    response = gets.chomp
    for menu_option in @menu_options_list
      if menu_option.check_response(response)
        @selected_option = menu_option
        break
      end
    end
    # if no match was found among all options
    if !@selected_option
      puts 'That is not a valid input'
      raise MenuQuitException
    end
  end

  # execute the selected option once chosen
  def execute_menu_action
    @selected_option&.execute_action
    @selected_option = nil
  end
end
