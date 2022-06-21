# frozen_string_literal: true

class Product
  attr_reader :code, :price

  def initialize(code, price)
    @code = code
    @price = price
  end
end
