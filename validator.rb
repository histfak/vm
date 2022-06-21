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
