# frozen_string_literal: true

require 'rest-client'
require_relative '../JsonUtils/json_utils'
require_relative 'bad_request_exception'

# this class contains the method to make ticket requests
class TicketRequest
  def initialize(config)
    @subdomain = config['subdomain']

    @email = config['email']

    @pass = config['pass']

    @per_page = config['per_page']
  end

  def make_ticket_all_url(per_page = @per_page, subdomain = @subdomain)
    "https://#{subdomain}.zendesk.com/api/v2/tickets.json?per_page=#{per_page}"
  end

  def make_ticket_one_url(subdomain = @subdomain)
    "https://#{subdomain}.zendesk.com/api/v2/tickets.json?per_page=1"
  end

  def make_ticket_id_url(id, subdomain = @subdomain)
    "https://#{subdomain}.zendesk.com/api/v2/tickets/#{id}.json"
  end

  # this method returns the request return code,
  # just to see if the credentials work
  def check_auth(user = @email, pass = @pass)
    url = make_ticket_one_url
    begin
      request_data = RestClient::Request.new(
        method: :get, url: url,
        user: user, password: pass,
        headers: { accept: :json, content_type: :json }
      ).execute
    rescue RestClient::Unauthorized, RestClient::Forbidden => e
      puts 'REQUEST:' + e.response.body
      puts 'REQUEST: Please ensure that credentials are correct in the config file'
      raise BadRequestException
    rescue RestClient::ExceptionWithResponse => e
      error = JsonUtils.parse_data(e.response.body)
      puts 'REQUEST: something went wrong with the request'
      puts "REQUEST: Error was: #{error['error']['title']}"
      puts "REQUEST: #{error['error']['message']}"
      raise BadRequestException
    end
    request_data.code
  end

  # this code was adapted from an answer at
  # https://stackoverflow.com/questions/3692574/how-do-i-do-basic-authentication-with-restclient#4223252
  # this code raises its own exceptions, exception handling found at
  # https://www.rubydoc.info/gems/rest-client/
  def make_request(url, user = @email, pass = @pass)
    begin
      request_data = RestClient::Request.new(
        method: :get, url: url,
        user: user, password: pass,
        headers: { accept: :json, content_type: :json }
      ).execute
    rescue RestClient::Unauthorized, RestClient::Forbidden => e
      puts "REQUEST: #{e.response.body}"
      puts 'REQUEST: Please ensure that credentials are correct in the config file'
      raise BadRequestException
    rescue SocketError
      puts 'REQUEST: Failed to connect'
      puts 'REQUEST: Please ensure that the url is correctly provided'
      raise BadRequestException
    rescue ArgumentError
      puts 'REQUEST: No URL provided'
      puts 'REQUEST: Please ensure that the url is correctly provided'
      raise BadRequestException
    rescue RestClient::ExceptionWithResponse => e
      puts 'REQUEST: Something went wrong with the request'
      puts "REQUEST: #{e.response.body}"
      raise BadRequestException
    end
    JsonUtils.parse_data(request_data.body)
  end
end
