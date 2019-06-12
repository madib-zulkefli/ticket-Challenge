# frozen_string_literal: true

require_relative 'menu_quit_exception'
require_relative '../Request/bad_request_exception'

# this class will act as an invoker in a command pattern
# it will contain all the menu option "command" objects
# and will run the command selected at runtime
class MenuInvoker
  def initialize(menu_options)
    @menu_options_list = menu_options
    @selected_option = nil
  end

  def display_menu_options
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
    puts 'That is not a valid input' unless @selected_option
  end

  # execute the selected option once chosen
  def execute_menu_action
    # execute the action if selected_option
    # is not still nil
    begin
      @selected_option&.execute_action
    rescue BadRequestException
      puts 'REQUEST: Returning to the menu'
    end
    # once the action has been taken,
    # reset current selected option
    @selected_option = nil
  end
end
