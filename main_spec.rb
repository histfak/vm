# frozen_string_literal: true

require_relative './main'

RSpec.describe VendingMachine do
  context 'Vending Machine check' do
    let(:p1) { Product.new(100, 5) }
    let(:p2) { Product.new(101, 10) }
    let(:p3) { Product.new(102, 7) }
    let(:p4) { Product.new(104, 10) }
    let(:p5) { Product.new(105, 7) }
    let(:v1) { VendingMachine.new(p1, p2, p3) }
    let(:u1) { User.new('John Doe', 50) }

    it 'creates a new vending machine' do
      expect(v1.products.size).to eq 3
    end

    it 'does not create a new vending machine if any of products is invalid' do
      s1 = String.new
      expect { VendingMachine.new(p1, p2, p3, s1) }.to raise_error(ArgumentError, 'Not a product!')
    end

    it 'restocks vending machine' do
      v1.restock(p4, p5)
      expect(v1.products.size).to eq 5
    end

    it 'stocks vending machine' do
      v1.stock(p4, p5)
      expect(v1.products.size).to eq 2
    end

    it "tries to load the machine, but don't have enough money" do
      expect { v1.buy(105, 100, u1) }.to raise_error(ArgumentError, "You don't have that much money!")
    end

    it 'enters the code, but the code is wrong' do
      expect { v1.buy(111, 10, u1) }.to raise_error(ArgumentError, "Can't find the code")
    end

    it 'tries to buy a product, but its price is more than a loaded amount' do
      expect { v1.buy(101, 8, u1) }.to raise_error(ArgumentError, 'Not enough money!')
    end

    it 'buys a product' do
      v1.buy(101, 45, u1)
      expect(v1.income).to eq 10
      expect(u1.money).to eq 40
    end
  end
end
