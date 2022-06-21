# frozen_string_literal: true

module Validator
  private

  def validate!(products)
    raise ArgumentError, 'Not a product!' unless (products.reject { |product| product.is_a?(Product) }).empty?
  end

  def not_enough!
    raise ArgumentError, 'Not enough money!'
  end

  def not_found!
    raise ArgumentError, 'Can\'t find the code'
  end

  def too_much!
    raise ArgumentError, 'You don\'t have that much money!'
  end
end

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

    product = products.find { |product| product.code == code }

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

class Product
  attr_reader :code, :price

  def initialize(code, price)
    @code = code
    @price = price
  end
end

class User
  attr_reader :name, :products
  attr_accessor :money

  def initialize(name, money)
    @name = name
    @money = money
    @products = []
  end
end
