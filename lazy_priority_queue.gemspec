Gem::Specification.new do |s|
  s.name        = 'lazy_priority_queue'
  s.version     = '0.1.1'
  s.date        = '2016-04-06'
  s.author      = 'Matías Battocchia'
  s.email       = 'matias@riseup.net'

  s.summary     = "A priority queue implemented using a lazy binomial heap. It allows change priority operation."
  s.description = "A priority queue which implements a lazy binomial heap. It supports the change priority operation, being suitable for algorithms like Dijkstra's shortest path and Prim's minimum spanning tree. It can be instantiated as a min-priority queue as well as a max-priority queue."
  s.homepage    = 'https://github.com/matiasbattocchia/lazy_priority_queue'
  s.license     = 'FreeBSD'

  s.files       = ['lib/lazy_priority_queue.rb']

  s.add_development_dependency('bundler')
  s.add_development_dependency('minitest')
end
