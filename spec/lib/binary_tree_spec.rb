require 'spec_helper'
require 'binary_tree'

describe BinaryTree do

  describe ".from_a" do
    context "when the input array has values" do
      before(:each) do
        @array = [1, 2, 3, 4, 5]
      end
      it "should make a binary tree of the correct size" do
        tree = BinaryTree.from_a(@array)
        expect(tree).not_to be nil
        expect(tree.size).to eq(5)
      end
    end
  end
end