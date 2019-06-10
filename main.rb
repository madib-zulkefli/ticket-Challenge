# frozen_string_literal:true

require_relative 'JsonUtils/json_utils'
require_relative 'Menu/menu_interface'
require_relative 'Request/ticket_request'
require_relative 'Request/bad_request_exception'

# this is the main class,containing the main method
# this is where the program will be run from
class Main
  def main
    puts 'getting credentials from config'
    creds = JsonUtils.retrieve_credentials
    puts 'test credentials on ticket request'
    request = TicketRequest.new(creds)
    menu = MenuInterface.new(request)

    begin
      request.check_auth
      puts 'run menu process'
      loop do
        menu.display_menu
        menu.run_menu_process
      end
    rescue BadRequestException, MenuQuitException
      puts 'ending menu process'
    end
    puts 'quitting the program'
  end
end

m = Main.new
m.main
