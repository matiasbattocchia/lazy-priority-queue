require 'lazy_priority_queue'
require 'ruby-prof'

RubyProf.measure_mode = RubyProf::PROCESS_TIME

results = RubyProf.profile do
  # TODO: Profile Lazy priority queue performing a shortest path search.
end

printer = RubyProf::GraphPrinter.new(results)
printer.print(STDOUT, {})
