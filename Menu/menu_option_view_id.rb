# frozen_string_literal: true

require_relative '../Request/ticket_request'

# this class is a "command" class, part of a command pattern
# it contains the methods for viewing a ticket by ID
class MenuOptionViewID < MenuOption
  def initialize(request)
    @request = request
  end

  def display_prompt
    puts "  'ID' to view a ticket by ID"
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
    # output ticket data
    puts "\n   TICKET DETAILS   \n"
    puts "ID: #{ticket_data['ticket']['id']}"
    puts "Status: #{ticket_data['ticket']['status']}"
    puts "Priority: #{ticket_data['ticket']['priority']}"
    puts "Created at: #{ticket_data['ticket']['created_at']}"
    puts "Updated at: #{ticket_data['ticket']['updated_at']}"
    puts "Due at: #{ticket_data['ticket']['due_at']}"
    puts "Type: #{ticket_data['ticket']['type']}"
    puts "Subject: #{ticket_data['ticket']['subject']}\n\n"
    puts "Description: #{ticket_data['ticket']['description']}\n\n"
    puts "Recipient: #{ticket_data['ticket']['recipient']}"
    puts "Requester ID: #{ticket_data['ticket']['requester_id']}"
    puts "Submitter ID: #{ticket_data['ticket']['submitter_id']}"
    puts "Assignee ID: #{ticket_data['ticket']['assignee_id']}"
    puts "Organization ID: #{ticket_data['ticket']['organization_id']}"
    puts "Group ID: #{ticket_data['ticket']['group_id']}"
    puts "Problem ID: #{ticket_data['ticket']['problem_id']}"
    puts "Satisfaction Rating: #{ticket_data['ticket']['satisfaction_rating']}"
    puts "is_public status: #{ticket_data['ticket']['is_public']}"
    puts "Tags: #{ticket_data['ticket']['tags']}"
  end
end
