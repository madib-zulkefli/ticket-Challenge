# frozen_string_literal:true

require 'test/unit'

require_relative '../Menu/menu_option_base'
require_relative '../Menu/menu_option_view_id'
require_relative '../Request/ticket_request'
require_relative '../JsonUtils/json_utils'

# this class contains unit tests for the menu_option class of methods
class TestMenuOption < Test::Unit::TestCase
  @@creds = JsonUtils.retrieve_config
  @@request = TicketRequest.new(@@creds)
  @@test_menu_option = MenuOptionViewID.new(@@request)

  def test_check_response
    test_menu_input = 'id'
    expected_menu_response = true
    assert_equal(
      @@test_menu_option.check_response(test_menu_input),
      expected_menu_response
    )
  end

  def test_bad_response_on_option
    test_menu_input = 'bad'
    expected_menu_response = false
    assert_equal(
      @@test_menu_option.check_response(test_menu_input),
      expected_menu_response
    )
  end

  def test_bad_response_on_invoker
    test_input = 'bad'
    expected_response = nil
    selected_option = nil
    menu_options_list = [@@test_menu_option]
    # code block from menu_invoker
    for menu_option in menu_options_list
      if menu_option.check_response(test_input)
        selected_option = menu_option
        break
      end
    end
    assert_equal(selected_option, expected_response)
  end
end
