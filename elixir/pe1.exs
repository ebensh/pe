max = 999
threes = Enum.into(Enum.take_every(3..max, 3), MapSet.new())
fives = Enum.into(Enum.take_every(5..max, 5), MapSet.new())
combined = MapSet.union(threes, fives)
IO.puts "#{Enum.sum combined}"