# frozen_string_literal: true

require 'json'
require 'base64'

# this class contains all the methods that parse Json Data
class JsonUtils
  # this method gets the encrypted data from the json file and decodes it
  # into usable data
  def self.retrieve_config(filename = 'config.json')
    credsraw = File.read(filename)
    credsencrypted = JSON.parse(credsraw)
    config = {
      'subdomain' => Base64.decode64(credsencrypted['subdomain']),
      'email' => Base64.decode64(credsencrypted['email']),
      'pass' => Base64.decode64(credsencrypted['pass']),
      'per_page' => credsencrypted['per_page']
    }
    config
  end

  def self.parse_data(data_string)
    JSON.parse(data_string)
  end
end
