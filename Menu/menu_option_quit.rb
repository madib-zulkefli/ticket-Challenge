# frozen_string_literal: true

# this class creates an object to handle a quit menu option
class MenuOptionQuit < MenuOption
  def display_prompt
    puts "  'quit' to quit to the menu"
  end

  def check_response(response)
    # adapted from https://stackoverflow.com/questions/21331057/string-equalsignorecase-equivalent-in-ruby#21331133
    return true if 'quit'.casecmp(response).zero?

    false
  end

  def execute_action
    raise MenuQuitException
  end
end
