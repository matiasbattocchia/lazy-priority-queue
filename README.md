# Lazy priority queue

Lazy priority queue is a priority queue which implements a lazy binomial heap.
It supports the change priority operation, being suitable for algorithms like Dijkstra's shortest path and Prim's minimum spanning tree.
It can be instantiated as a min-priority queue as well as a max-priority queue.

## Installation

With RubyGems:

```ruby
gem install 'lazy_priority_queue'
```

## Usage

First instantiate a priority queue.

```ruby
require 'lazy_priority_queue'

queue = MinPriorityQueue.new
```

There is also a `MaxPriorityQueue` class.

Use `enqueue(element, priority)` to insert an element with a given priority to the queue.

```ruby
queue.enqueue :a, 1
queue.enqueue :b, 2
queue.enqueue :c, 3
```

`peek()` will retrieve the minimum priority element without removing it from the queue.

```ruby
queue.peek # => :a
```

`change_priority(element, new_priority)` decreases an element's priority.

```ruby
queue.change_priority :c, 0
```

Use `dequeue()` to extract the minimum priority element from the queue.

```ruby
queue.dequeue # => :c
queue.dequeue # => :a
queue.dequeue # => :b
```

Finally, there are these aditional instance methods: `delete(element)`, `size` and `empty?`.

## Complexity

Operation | Time
--------- | ----
enqueue | O(1)
peek | O(1)
change_priority | O(log n)
dequeue | O(log n) amortized
delete | O(log n) amortized

Note: The Fibonacci heap has better amortized time for change priority, O(1) namely, but each node in this heap stores more pointers to other nodes than binomial heap ones, making it more memory consuming.

## Comparison

### Algorithms
https://github.com/kanwei/algorithms

### PQueue
https://github.com/rubyworks/pqueue

### PriorityQueueCxx
https://github.com/boborbt/priority_queue_cxx

### PriorityQueue
https://rubygems.org/gems/PriorityQueue


## Acknowledgments

These two lectures on data structures were helpful for writing this library:
* http://web.stanford.edu/class/cs166/lectures/06/Slides06.pdf
* http://web.stanford.edu/class/cs166/lectures/07/Slides07.pdf

## Licence

The MIT License (MIT)

Copyright (c) 2017 Matías Battocchia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
