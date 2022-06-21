# frozen_string_literal: true

class User
  attr_reader :name, :products
  attr_accessor :money

  def initialize(name, money)
    @name = name
    @money = money
    @products = []
  end
end
