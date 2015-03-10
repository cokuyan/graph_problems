# http://www.reddit.com/r/dailyprogrammer/comments/2sfs8f/20150114_challenge_197_intermediate_food_delivery/

require_relative 'dijkstra'

def times_of_day(time)
  case
  when time.between?('0600', '1000') then 0
  when time.between?('1000', '1500') then 1
  when time.between?('1500', '1900') then 2
  else 3
  end
end

def street_names(path, graph)
  streets = []
  0.upto(path.length - 2) do |i|
    edge = graph.edges[path[i]]
    edge = edge.next until edge.adj == path[i + 1]

    streets << edge.name
  end

  streets
end

graph_file = ARGV[0]
graph = GraphGenerator.new(graph_file, false).generate_graph

input_file = ARGV[1]
File.open("#{input_file}", 'r') do |f|
  while (line = f.gets)
    line_parts = line.chomp.split
    time_of_day = times_of_day(line_parts.pop)
    start, target = line_parts

    output = dijkstra(graph, start, target, time_of_day)
    streets = street_names(output[:path], graph)
    time = output[:distance]

    puts "path: #{streets.join(" ")}"
    puts "time: #{time} minutes"
    puts
  end

end
