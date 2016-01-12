require 'benchmark'
require 'lazy_priority_queue'
require 'algorithms'
require 'pqueue'
require 'fc' # priority_queue_cxx
require 'priority_queue' # PriorityQueue
require 'priorityqueue' # priority_queue
# To avoid a namespace collision between PriorityQueue and priority_queue,
# filename and main class of the latter were monkeypatched.

def iterator n, push, pop
  n.times do |i|
    (n - i).times do |j|
      push.call i.to_s + ':' + j.to_s
    end

    i.times do
      pop.call
    end
  end
end

N = 1_000

Benchmark.bm do |bm|
  bm.report('Lazy priority queue') do
    q = MinPriorityQueue.new
    iterator N, ->(n){ q.enqueue n, rand }, ->{ q.dequeue }
  end

  bm.report('Algorithms') do
    q = Containers::PriorityQueue.new
    iterator N, ->(n){ q.push n, rand }, ->{ q.pop }
  end

  bm.report('PQueue') do
    q = PQueue.new
    iterator N, ->(n){ q.push rand }, ->{ q.pop }
  end

  bm.report('PriorityQueueCxx') do
    q = FastContainers::PriorityQueue.new(:min)
    iterator N, ->(n){ q.push n, rand }, ->{ q.pop }
  end

  bm.report('PriorityQueue (supertinou)') do
    q = CPriorityQueue.new
    iterator N, ->(n){ q.push n, rand }, ->{ q.delete_min }
  end

  bm.report('PriorityQueue (ninjudd)') do
    q = PQ.new
    iterator N, ->(n){ q[rand] << n }, ->{ q.shift }
  end
end
