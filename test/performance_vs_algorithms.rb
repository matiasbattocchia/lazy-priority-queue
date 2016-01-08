require 'algorithms'
require 'lazy_priority_queue'
require 'benchmark'

N = 50_000

algo_pq = Containers::PriorityQueue.new
fc_pq = MinPriorityQueue.new

Benchmark.bm do |bm|
  bm.report('algo:push') { N.times { |n| algo_pq.push(n.to_s, rand) } }
  bm.report('fc:push')   { N.times { |n| fc_pq.enqueue(n.to_s, rand) } }
  bm.report('algo:pop')  { N.times { algo_pq.pop } }
  bm.report('fc:pop')    { N.times { fc_pq.dequeue } }
end
