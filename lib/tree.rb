# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array = nil)
    @root = build_tree(array)
  end

  def build_tree(arr)
    return nil if arr.nil? || arr.empty?

    n = arr.size
    mid = n.div(2)

    node = Node.new(arr[mid])
    node.left = build_tree(arr[...mid])
    node.right = build_tree(arr[mid + 1..])
    node
  end

  def insert(value)
    current = @root
    if current.nil?
      @root = Node.new(value)
    else
      while current
        if current.left.nil? && current.data > value
          current.left = Node.new(value)
          break
        elsif current.right.nil? && current.data < value
          current.right = Node.new(value)
          break
        else
          current = if current.data > value
                      current.left
                    else
                      current.right
                    end
        end
      end
    end
  end

  def delete(value)
    @root = delete_node(@root, value)
  end

  def delete_node(root, value)
    return root if root.nil?

    if value < root.data
      root.left = delete_node(root.left, value)
    elsif value > root.data
      root.right = delete_node(root.right, value)
    elsif root.left.nil? && root.right.nil?
      root = nil
    elsif root.left.nil?
      root = root.right
    elsif root.right.nil?
      root = root.left
    else
      successor = find_minimum(root.right)
      root.data = successor.data
      root.right = delete_node(root.right, successor.data)
    end

    root
  end

  def find_minimum(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def find(value)
    return false if @root.nil?

    current = @root
    while current
      return true if current.data === value

      current = if current.data > value
                  current.left
                else
                  current.right
                end
    end
  end

  def level_order
    output = []
    q = Queue.new
    q << @root
    until q.empty?
      node = q.shift
      output << node.data
      q << node.left unless node.left.nil?
      q << node.right unless node.right.nil?
    end
    return output unless block_given?

    i = 0
    while i < output.length

      yield(output[i])
      i += 1
    end
  end
end
