# frozen_string_literal: true

require 'rest-client'
require_relative '../JsonUtils/json_utils'
require_relative 'bad_request_exception'

# this class contains the method to make ticket requests
class TicketRequest
  def initialize(creds)
    @subdomain = creds['subdomain']

    @email = creds['email']

    @pass = creds['pass']
  end

  def make_ticket_all_url(subdomain = @subdomain)
    "https://#{subdomain}.zendesk.com/api/v2/tickets.json"
  end

  def make_ticket_id_url(id, subdomain = @subdomain)
    "https://#{subdomain}.zendesk.com/api/v2/tickets/#{id}.json"
  end

  # this code was adapted from an answer at
  # https://stackoverflow.com/questions/3692574/how-do-i-do-basic-authentication-with-restclient#4223252
  # this method returns the request return code,
  # just to see if the credentials work
  def check_auth(user = @email, pass = @pass)
    url = make_ticket_id_url('2')
    request_data = RestClient::Request.new(
      method: :get, url: url,
      user: user, password: pass,
      headers: { accept: :json, content_type: :json }
    ).execute
    if request_data.code != 200
      raise BadRequestException.new(
        "ERROR: Could not make request
        Consider checking the credentials in the config file"
      )
    end
    request_data.code
  end

  # this code was adapted from an answer at
  # https://stackoverflow.com/questions/3692574/how-do-i-do-basic-authentication-with-restclient#4223252
  def make_request(url, user = @email, pass = @pass)
    request_data = RestClient::Request.new(
      method: :get, url: url,
      user: user, password: pass,
      headers: { accept: :json, content_type: :json }
    ).execute
    if request_data.code != 200
      raise BadRequestException.new(
        "ERROR: Could not make request
        Consider checking the credentials in the config file"
      )
    end
    JsonUtils.parse_data(request_data.body)
  end
end
