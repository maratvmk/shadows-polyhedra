require_relative 'edge'

ed1 = Edge.new(beg: 1, end: 24)
ed2 = Edge.new(:beg=> 24, :end=> 1)

puts ed1 != ed2 
