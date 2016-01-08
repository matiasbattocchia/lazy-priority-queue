require 'priority_queue'
require 'lazy_priority_queue'
require 'benchmark'

N = 50_000

pq_pq = PriorityQueue.new
fc_pq = MinPriorityQueue.new

Benchmark.bm do |bm|
  bm.report('pq:push') { N.times { |n| pq_pq.push(n.to_s,rand) } }
  bm.report('fc:push')   { N.times { |n| fc_pq.enqueue(n.to_s, rand) } }
  bm.report('pq:pop') { N.times { pq_pq.delete_min } }
  bm.report('fc:pop')    { N.times { fc_pq.dequeue } }
end
