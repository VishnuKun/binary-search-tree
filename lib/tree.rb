# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array = nil)
    array = array.sort
    array.uniq!
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

  def inorder
    current = @root
    def inorder_array(root)
      arr = []
      if root
        arr << inorder_array(root.left)
        arr << root.data
        arr << inorder_array(root.right)
      end
      arr.flatten!
      arr
    end
    inorder_array(current)
  end

  def preorder
    current = @root
    def preorder_array(root)
      arr = []
      if root
        arr << root.data
        arr << preorder_array(root.left)
        arr << preorder_array(root.right)
      end
      arr.flatten!
      arr
    end
    preorder_array(current)
  end

  def postorder
    current = @root
    def postorder_array(root)
      arr = []
      if root
        arr << postorder_array(root.left)
        arr << postorder_array(root.right)
        arr << root.data
      end
      arr.flatten!
      arr
    end
    postorder_array(current)
  end

  def height(value)
    node = find_node(value)
    return node_height(node) unless node.nil?

    -1
  end

  def node_height(node)
    return -1 if node.nil?

    left = node_height(node.left)
    right = node_height(node.right)
    [left, right].max + 1
  end

  def find_node(value)
    current = @root
    while current
      if current.data == value
        return current
        break
      end
      current = if current.data > value
                  current.left
                else
                  current.right
                end
    end
    nil
  end

  def depth(value)
    node = find_node(value)
    node_depth(node)
  end

  def node_depth(node)
    return 0 if node.nil?

    left = node_depth(node.left)
    right = node_depth(node.right)
    [left, right].max + 1
  end

  def balanced?
    is_balanced?(@root)
  end

  def is_balanced?(root)
    return true if root.nil?
  
    left_height = root.left.nil? ? -1 : height(root.left.data)
    right_height = root.right.nil? ? -1 : height(root.right.data)
  
    height_difference = (left_height - right_height).abs
  
    if height_difference <= 1
      is_balanced?(root.left) && is_balanced?(root.right)
    else
      false
    end
  end

  def rebalance
    current = @root
    rebalanced_arr(@root)
  end

  def rebalanced_arr(root)
    # get the sorted array 
    arr = self.level_order.sort
    # make a new balanced binary search tree
    @root = build_tree(arr)
  end
end
