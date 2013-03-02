require 'fixtures/block_helper'

include Purugin::Items

describe Purugin::Items do
  it "Makes a simple item_stack" do
    stack = item_stack(:bed_block)
    stack.type.should == :bed_block.to_material
    stack.amount.should == 1

    stack = item_stack(:bed_block.to_material)
    stack.type.should == :bed_block.to_material
  end

  it "Gives reasonable error with invalid type argument for item_stack" do
    expect { item_stack(:bogus_material) }.to raise_error(ArgumentError)
  end

  it "Makes an item stack with a quantity" do
    stack = item_stack(:iron_ingot, 10)
    stack.amount.should == 10
  end

  it "Gives reasonable error when item_stack quantity is bogus" do
    expect { item_stack(:iron_ingot, :foo) }.to raise_error(ArgumentError)
  end

  it "Make an item stack with a quantity and durability amount" do
    stack = item_stack(:iron_ingot, 10, 5)
    stack.amount.should == 10
    stack.durability.should == 5
  end

  it "Gives reasonable error when invalid value" do
    expect { item_stack(:iron_ingot, nil, 5) }.to raise_error(ArgumentError)
  end
end
