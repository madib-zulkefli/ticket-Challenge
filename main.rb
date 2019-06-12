# frozen_string_literal:true

require_relative 'JsonUtils/json_utils'
require_relative 'Menu/menu_interface'
require_relative 'Request/ticket_request'
require_relative 'Request/bad_request_exception'

# this is the main class,containing the main method
# this is where the program will be run from
class Main
  def main
    puts 'Getting credentials from config'
    creds = JsonUtils.retrieve_config
    puts 'Testing credentials on ticket request'
    request = TicketRequest.new(creds)
    menu = MenuInterface.new(request)

    begin
      request.check_auth
      loop do
        menu.display_menu
        menu.run_menu_process
      end
    rescue MenuQuitException
      puts 'MENU: Ending menu process'
    rescue BadRequestException
      puts 'REQUEST: Ending menu process'
    end
    puts 'Quitting the program'
  end
end

m = Main.new
m.main
