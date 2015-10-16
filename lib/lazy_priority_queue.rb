require 'pry'
require 'pry-byebug'

module PriorityQueue

  Node = Struct.new :element,
                    :key,
                    :rank,
                    :parent,
                    :left_child,
                    :left_sibling
                    :right_sibling

  def initialize top_condition, &heap_property
    @references = {}
    @top_condition = top_condition
    @heap_property = heap_property
  end

  def enqueue element, key
    raise 'The provided element already is in the queue.' if @references[element]

    node = Node.new element, key, 0

    # If there is no head also there is no top (and viceversa).
    @top = if @head
      @head.left_sibling, node.right_sibling = node, @head
      @heap_property[@top, node]
    else
      node
    end

    @head = node

    @references[element] = node

    element
  end

  def change_priority element, new_key
    node = @references[element]

    raise 'Element provided is not in the queue.' unless node

    node.key = new_key

    sift_up node

    # Not checking if node is a root before comparing it with top;
    # it's cheaper to compare directly.
    @top = @heap_property[@top, node]

    element
  end

  def peek
    @top and @top.element
  end

  def dequeue
    return unless @top

    element = @top.element

    if @top.left_sibling
      @top.left_sibling.right_sibling = @top.right_sibling
    else # @top is @head.
      @head = @top.right_sibling
    end

    @top.right_sibling.left_sibling = @top.left_sibling if @top.right_sibling
    # @top.left_sibling = nil
    # @top.right_sibling = nil

    @references.delete element

    if node = @top.left_child
      # @top.left_child = nil
      # @top has no parent node.
      # @top's children conform a linked list to be added to tree's list.
      # The rightmost child links with @head then @top.left_child would be the new head.

      while node
        rightmost_sibling = node
        node.parent = nil

        node = node.right_sibling
      end

      @head.left_sibling, rightmost_sibling.right_sibling = rightmost_sibling, @head
      @head = @top.left_child
    end

    @head = coalesce @head

    node = @head

    while node
      @top = @heap_property[@top, node]

      node = node.right_sibling
    end

    element
  end

  def delete element
    change_priority element, @top_condition
    dequeue
  end

  def empty?; @references.empty? end
  def size; @references.size end

  private

  def sift_up node
    return node unless node.parent and @heap_property[node, node.parent] == node

    node.parent.rank, node.rank = node.rank, node.parent.rank

    node.parent.left_child, node.left_child = node.left_child,
      node.parent.left_child == node ? node.parent : node.parent.left_child

    node.parent.right_sibling, node.right_sibling = node.right_sibling, node.parent.right_sibling
    node.parent.left_sibling, node.left_sibling = node.left_sibling, node.parent.left_sibling

    # This line must be at the end.
    node.parent.parent, node.parent = node, node.parent.parent

    sift_up node
  end

  def coalesce trees
    coalesced_trees = []

    while tree = trees.pop
      if coalesced_tree = coalesced_trees[tree.rank]
        trees << add(tree, coalesced_tree)
        coalesced_trees[tree.rank] = nil
      else
        coalesced_trees[tree.rank] = tree
      end
    end

    coalesced_trees.compact
  end

  def add node_one, node_two
    raise 'Both nodes must hold the same rank.' if node_one.rank != node_two.rank
    raise 'Both nodes must be roots (no parents).' if node_one.parent || node_two.parent

    adder_node, addend_node = @heap_property[node_one, node_two]

    addend_node.parent = adder_node

    addend_node.left_sibling.right_sibling = addend_node.right_sibling if addend_node.left_sibling
    addend_node.right_sibling.left_sibling = addend_node.left_sibling if addend_node.right_sibling

    addend_node.left_sibling = nil

    # This line must go before than
    addend_node.right_sibling = adder_node.left_child
    # this one
    adder_node.left_child = addend_node

    adder_node.rank += 1

    adder_node
  end
end

class MinPriorityQueue
  include PriorityQueue

  def initialize
    super(-Float::INFINITY) { |parent_node, child_node| parent_node.key <= child_node.key }
  end
end

class MaxPriorityQueue
  include PriorityQueue

  def initialize
    super( Float::INFINITY) { |parent_node, child_node| parent_node.key >= child_node.key }
  end
end
