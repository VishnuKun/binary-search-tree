# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize
    @root = nil
  end

  # method to convert array to BST
  # and return root of tree

  def array_to_BST(nums)
    # if array.empty? return nil
    return nil if nums.nil?

    # else
    # find middle element
    # make it the root
    # divide array into two parts
    # left and right from the middle element
    # repeat process using recursion
    # make middle of left, root
    # make middle of right, root
    # return pre-order of tree
  end
end
