# frozen_string_literal: true

require_relative 'menu_option_base'
require_relative 'menu_option_view_id'
require_relative 'menu_option_view_list'
require_relative 'menu_option_quit'
require_relative 'menu_invoker'

# this class is just the interface for the menu processes,
# simplifying the look of it for the outside
class MenuInterface
  def initialize(request)
    # define main menu attributes
    # define menu options
    # set up menus to ready the objects for use
    @request = request
    ticket_id_menu_option = MenuOptionViewID.new(@request)
    ticket_all_menu_option = MenuOptionViewList.new(@request)
    quit_menu_option = MenuOptionQuit.new
    menu_options = [
      ticket_id_menu_option,
      ticket_all_menu_option,
      quit_menu_option
    ]
    @main_menu = MenuInvoker.new(menu_options)
  end

  def display_menu
    # display menu data goes here to avoid clutter
    total_count_url = @request.make_ticket_one_url
    total_count = @request.make_request(total_count_url)['count']
    puts '----------------'
    puts 'TICKET VIEWER'
    puts '----------------'
    puts "Your ticket total is: #{total_count} tickets"
    puts 'Please Enter'
    @main_menu.display_menu_options
  end

  def run_menu_process
    # runs the whole process of menu actions from here
    @main_menu.compare_response
    @main_menu.execute_menu_action
  end
end
