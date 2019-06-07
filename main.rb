# frozen_string_literal:true

require_relative 'JsonUtils/json_utils'

# this is the main class,containing the main method
# this is where the program will be run from
class Main
  def main
    puts 'get credentials from config'
    JsonUtils.retrieve_credentials
    puts 'test credentials on ticket request'
    puts 'run menu process'
    puts 'quitting the program'
  end
end

m = Main.new
m.main
