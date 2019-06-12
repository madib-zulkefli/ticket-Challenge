# frozen_string_literal: true

require_relative '../Request/ticket_request'

# this class is a "command" class, part of a command pattern
# it contains the methods for viewing all tickets in a list
class MenuOptionViewList < MenuOption
  def initialize(request)
    @request = request
  end

  def display_prompt
    puts "  'All' to view all tickets in a list"
  end

  def check_response(response)
    # adapted from https://stackoverflow.com/questions/21331057/string-equalsignorecase-equivalent-in-ruby#21331133
    return true if 'All'.casecmp(response).zero?

    false
  end

  def execute_action
    # initialise some url data to use for next page and
    # previous page requests
    url = @request.make_ticket_all_url
    page_start = url.index('.json?') + 6
    # begin the loop for displaying pages and menu options
    loop do
      # make the request to get all the data
      ticket_data = @request.make_request(url)
      # get the page numbers from the urls in the hash
      prev_page_num = make_page_num(ticket_data, page_start, 'previous_page')
      next_page_num = make_page_num(ticket_data, page_start, 'next_page')
      #   display the ticket info and menu options
      puts '   TICKET OVERVIEW'
      puts 'Ticket ID, Subject, Created at, Status'
      ticket_data['tickets'].each do |ticket|
        puts "ID: #{ticket['id']}, Subject: #{ticket['subject']}, Created At: #{ticket['created_at']}, Status: #{ticket['status']}"
      end
      puts '----------'
      puts 'Please Enter'
      puts "  'prev' for previous page -> #{prev_page_num}"
      puts "  'next' for next page -> #{next_page_num}"
      puts "  'quit' to quit back to the menu"
      puts 'Enter your choice:'
      #   get and process the data from the user
      input = gets.chomp
      if 'prev'.casecmp(input).zero?
        url = ticket_data['previous_page']
      elsif 'next'.casecmp(input).zero?
        url = ticket_data['next_page']
      elsif 'quit'.casecmp(input).zero?
        puts 'MENU: Returning to the menu'
        return
      else
        puts 'MENU: Input not recognised'
      end
    end
  end

  def make_page_num(ticket_data, page_start, page)
    # get the page numbers by the index of the url
    #   if it fails then there is no previous page
    begin
        page_end = ticket_data[page]&.index('&per')
        page_end -= 1
        page_num = ticket_data[page][page_start..page_end]
        page_num.sub! '=', ' '
    rescue NoMethodError
      page_num = 'End Of List'
      end
    page_num
  end
end
