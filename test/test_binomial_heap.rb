require 'minitest/autorun'
require 'lazy_priority_queue'

describe MinPriorityQueue do
  before do
    @queue = MinPriorityQueue.new
  end

  it 'must enqueue elements' do
    @queue.enqueue :a, 1
    @queue.enqueue :b, 2
    @queue.enqueue :c, 3
    @queue.enqueue :d, 4
    @queue.enqueue :e, 5

    @queue.dequeue.must_equal :a
    @queue.change_priority :c, -1

    @queue.dequeue.must_equal :c
    @queue.dequeue.must_equal :b
    @queue.dequeue.must_equal :d
    @queue.dequeue.must_equal :e
    @queue.dequeue.must_be_nil
  end

  it 'sorts lots of elements' do
    Item = Struct.new :id, :priority

    items = []

    100.times do |id|
      priority = rand(1000)
      items << @queue.enqueue(Item.new(id, priority), priority)
    end

    50.times do
      case rand(2)
      when 0
        item = items.sample
        @queue.change_priority item, item.priority -= rand(100)
      when 1
        items.delete @queue.dequeue
      end
    end

    sorted_items = []

    until @queue.empty?
      sorted_items << @queue.dequeue
    end

    sorted_items.map!(&:priority)

    sorted_items.must_equal sorted_items.sort
  end
end
