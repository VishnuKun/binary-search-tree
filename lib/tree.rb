# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array = nil)
    @root = build_tree(array)
  end

  # convert array to BST

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

  def delete(del_value)
    current = @root
    return nil if current.nil?
    # if root is to be deleted
      # when the root have no children
      # when the root have 1 child
      # when the root have 2 children

    # if node is to be deleted
      # when the node have 1 child
      # when the node have 2 childs
      
    # if a child is to be deleted
    while current
    end
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
end
