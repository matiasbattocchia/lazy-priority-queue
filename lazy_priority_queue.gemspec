Gem::Specification.new do |s|
  s.name        = 'lazy_priority_queue'
  s.version     = '0.0.0'
  s.date        = '2016-01-11'
  s.summary     = 'A priority queue which implements a lazy binomial heap.'
  s.description = "Lazy priority queue is a priority queue which implements a lazy binomial heap. It supports the change priority operation, being suitable for algorithms like Dijkstra's shortest path and Prim's minimum spanning tree. It can be instantiated as a min-priority queue as well as a max-priority queue."
  s.author      = 'Matías Battocchia'
  s.email       = 'matias@riseup.net'
  s.files       = ['lib/lazy_priority_queue.rb']
  s.homepage    = 'https://github.com/matiasbattocchia/lazy_priority_queue'
  s.license     = 'MIT'
end
