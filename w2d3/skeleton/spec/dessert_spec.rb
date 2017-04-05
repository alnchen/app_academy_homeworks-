require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  let(:churro) {Dessert.new("churro", 5, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(churro.type).to eq("churro")
    end


    it "sets a quantity" do
      expect(churro.quantity).to be(5)
    end

    it "starts ingredients as an empty array" do
      expect(churro.ingredients.length).to be(0)
    end

    it "raises an argument error when given a non-integer quantity" do
      expect {Dessert.new("cake", "cheese", chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      churro.add_ingredient("cinnamon")
      expect(churro.ingredients).to include("cinnamon")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do

      churro.add_ingredient("first")
      churro.add_ingredient("second")
      current = churro.ingredients.dup
      churro.mix! until churro.ingredients.first != current.first
      expect(churro.ingredients).not_to eq(current)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      churro.eat(2)
      expect(churro.quantity).to be(3)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect {churro.eat(100)}.to raise_error
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with (churro)
      churro.make_more
    end
  end
end
