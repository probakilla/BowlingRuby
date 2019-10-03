# frozen_string_literal: true

# Custom error for the Pannel class
class PannelError < StandardError
  attr_reader :object

  def initialize(object)
    @object = object
  end
end
