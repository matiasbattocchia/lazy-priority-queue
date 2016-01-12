require 'minitest/autorun'
require 'lazy_priority_queue'

describe MinPriorityQueue do
  before do
    @queue = MinPriorityQueue.new
  end

  it 'sorts lots of elements' do
    Item = Struct.new :id, :priority

    references = @queue.instance_variable_get(:@references)
    items = []

    10000.times do |id|
      case rand(10)
      when 0..5 # enqueue
        priority = rand(1000)
        items << @queue.enqueue(Item.new(id, priority), priority)
      when 6 # change_priority
        item = items.sample
        node = references.delete item
        priority = item.priority -= rand(1000)
        references[item] = node
        @queue.change_priority item, priority
      when 7 # dequeue
        items.delete @queue.dequeue
      when 8 # peek
        @queue.peek
      when 9 # delete
        items.delete @queue.delete(items.sample)
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
