# frozen_string_literal: true

require_relative '../Request/ticket_request'

# this class is a "command" class, part of a command pattern
# it contains the methods for viewing a ticket by ID
class MenuOptionViewID < MenuOption
    def initialize(request)
        @request = request
    end
  def display_prompt
    puts " 'ID' to view a ticket by ID"
  end

  def check_response(response)
    # adapted from https://stackoverflow.com/questions/21331057/string-equalsignorecase-equivalent-in-ruby#21331133
    return true if 'ID'.casecmp(response).zero?

    false
  end

  def execute_action
    puts 'Enter the ID of the ticket: '
    ticket_id = gets.chomp
    url = @request.make_ticket_id_url(ticket_id)
    ticket_data = @request.make_request(url)
    puts ticket_data
  end
end
