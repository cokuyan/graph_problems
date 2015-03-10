require_relative 'graph_generator'

class Fixnum
  MAX = 1 << (1.size * 8 - 2) - 1
end

def dijkstra(graph, start, target, time_of_day)

  parent = {}
  distance = Hash.new(Fixnum::MAX)
  unexplored = graph.edges.keys

  parent[start] = nil
  distance[start] = 0

  current = start
  until current == target
    fail "#{current} already explored" unless unexplored.include?(current)

    unexplored.delete(current)
    edge = graph.edges[current]

    until edge.nil?
      adj = edge.adj

      if distance[adj] > (distance[current] + edge.weight[time_of_day])
        distance[adj] = distance[current] + edge.weight[time_of_day]
        parent[adj] = current
      end

      edge = edge.next
    end

    dist = Fixnum::MAX
    unexplored.each do |vertex|
      if dist > distance[vertex]
        dist = distance[vertex]
        current = vertex
      end
    end
  end

  # backtrack using current or target up until nil
  final = []
  until current.nil?
    final << current
    current = parent[current]
  end

  {
    path: final.reverse,
    distance: distance[target]
  }
end
