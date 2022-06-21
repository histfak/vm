# frozen_string_literal: true

require_relative './validator'
require_relative './user'
require_relative './product'

class VendingMachine
  include Validator

  attr_reader :products, :income

  def initialize(*products)
    @products = products
    @income = 0
    validate!(@products)
  end

  def buy(code, amount, user)
    too_much! if amount > user.money

    product = products.find { |p| p.code == code }

    not_found! if product.nil?
    not_enough! if amount < product.price

    begin
      products.delete(product)
      user.products << product
      user.money -= product.price
      @income = + product.price
    rescue StandardError => e
      raise "Something (extremely unpredictable) went wrong!\n#{e.class}\n#{e.message}"
    end
  end

  def restock(*products)
    @products.concat(products)
  end

  def stock(*products)
    @products = products
  end
end
