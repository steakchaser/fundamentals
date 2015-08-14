require 'spec_helper'
require 'binary_tree'

describe BinaryTree::Node do

  describe "#insert" do

    context "when there are no child nodes" do
      it "should add a node to the left if it's <less> than the parent" do
        node = BinaryTree::Node.new(10)
        node.insert(5)
        expect(node.left.value).to eq(5)
      end
      it "should add a node to the right if it's > than the parent" do
        node = BinaryTree::Node.new(10)
        node.insert(11)
        expect(node.right.value).to eq(11)
      end
      it "should do nothing if it's = than the parent" do
        node = BinaryTree::Node.new(10)
        node.insert(10)
        expect(node.right.nil? && node.left.nil?).to be true
      end
    end

  end

  describe "#include?" do
    context "when there is a tree > 1 node" do
      before(:each) do
        @tree = nil
        [1,2,3,4,5].each do |i|
          @tree = BinaryTree::Node.new(i) if @tree.nil?
          @tree.insert(i)
        end
      end
      it "should find the value if it's in the tree" do
        expect(@tree.include?(4)).to be true
      end
      it "should NOT find the value if it's NOT in the tree" do
        expect(@tree.include?(-1)).to be false
      end
    end
  end

  describe "#to_a" do
    context "when there is a tree > 1 node" do
      before(:each) do
        @tree = BinaryTree.from_a([1, 2, 3, 4, 5])
      end
      it "should convert back to an array" do
        expect(@tree.to_a.size).to eq (5)
      end
    end
  end
end