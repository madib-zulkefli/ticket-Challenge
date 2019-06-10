# frozen_string_literal: true

# this is the base class for the abstract structure
# of menu option classes
class MenuOption
  def display_prompt; end

  def check_response; end

  def execute_action; end
end
