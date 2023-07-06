# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize
    @root = nil
  end

  # method to convert array to BST

  def build_tree(nums)
    return nil if nums.nil? || nums.empty?

    n = nums.length
    mid = n.div(2)
    root = Node.new(nums[mid])
    root.left = build_tree(nums[...mid])
    root.right = build_tree(nums[(mid + 1)..])

    root
  end
end
