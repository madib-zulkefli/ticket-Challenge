# frozen_string_literal: true

# this exception is used to handle any errors that may arise
# when making the requests for tickets
class BadRequestException < StandardError
  def initialize(message)
    super(message)
  end
end
