require 'minitest/autorun'
require 'lazy_priority_queue'
# enqueue(k,v)

# peek() / find-min()

# dequeue() / extract-min() -> coalesce()

# change-priority() / decrease-key(k,v)

# delete(v)


describe MinPriorityQueue do
  before do
    @queue = MinPriorityQueue.new
  end

  it 'must enqueue elements' do
    @queue.enqueue :a, 1
    @queue.enqueue :b, 2
    @queue.enqueue :c, 3

    @queue.dequeue.must_equal :a
    @queue.change_priority :c, -1

    @queue.dequeue.must_equal :c
    @queue.dequeue.must_equal :b
    @queue.dequeue.must_be_nil
  end

  it 'hapiness' do
    10.times do
      n = rand(100)
      @queue.enqueue n, n
    end

    rock = []

    until @queue.empty?
      rock << @queue.dequeue
    end

    rock.must_equal rock.sort
  end
end

