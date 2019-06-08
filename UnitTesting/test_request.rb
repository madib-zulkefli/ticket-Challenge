# frozen_string_literal:true

require 'test/unit'

require_relative '../Request/ticket_request'
require_relative '../JsonUtils/json_utils'

# this class contains unit tests for the JsonUtils class of methods
class TestTicketRequests < Test::Unit::TestCase
  @@creds = JsonUtils.retrieve_credentials
  @@requester = TicketRequest.new(@@creds)

  def test_make_request_all_tickets
    url = @@requester.make_ticket_all_url
    req_code = @@requester.make_request(url)
    assert_equal(req_code, 200)
  end
end
