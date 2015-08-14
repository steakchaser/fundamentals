module BinaryTree

  def self.from_a(a)
    Node.new(a.first).tap {|node| a[1..a.length].each{|value| node.insert(value)} }
  end

  class Node
    attr_accessor :left, :right
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def insert(value)
      case value <=> self.value
        when -1
          if left.nil?
            self.left = Node.new(value)
          else
            left.insert(value)
          end
        when 1
          if right.nil?
            self.right = Node.new(value)
          else
            right.insert(value)
          end
        else
          return
      end
    end

    def inspect
      "{#{value}::#{left.inspect}|#{right.inspect}}"
    end

    def include?(value)
      case value <=> self.value
        when -1
          if !left.nil?
            left.include?(value)
          else
            false
          end
        when 1
          if !right.nil?
            right.include?(value)
          else
            false
          end
        else
          true
      end
    end

    def size(count=0)
      count += 1
      if !left.nil?
        count = left.size(count)
      end
      if !right.nil?
        count = right.size(count)
      end
      count
    end

    def to_a
      left.to_a + [value] + right.to_a
    end

  end

end