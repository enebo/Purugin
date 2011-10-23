require 'fixtures/block_helper'

describe Purugin::Materials do
  before do
    @bed = SpecBlock.new org.bukkit.material.Bed.new
  end

  it "is? can tell a bed from a bunch o dirt" do
    @bed.is?(:bed_block).should == true
    @bed.is?(:grass).should == false
    @bed.is?(:grass, :bed_block).should == true
    @bed.is?(:grass, :dirt).should == false
  end
end
