class EdgeNode

  attr_accessor :weight, :next, :adj

  def initialize(adj)
    @adj = adj
    @weight = nil
    @next = nil
  end
end

class Graph

  attr_accessor :vertex_count
  attr_reader :edges, :out_degree, :directed

  def initialize(directed = false)
    @vertex_count = @edge_count = 0
    @edges = {}
    @out_degree = Hash.new(0)
    @directed = directed
  end

  def insert_edge(from_vertex, to_vertex, directed = @directed)
    node = EdgeNode.new(to_vertex)
    node.next = @edges[from_vertex]
    @edges[from_vertex] = node
    @edges[to_vertex] = nil

    @out_degree[from_vertex] += 1

    directed ? @edge_count += 1 : insert_edge(to_vertex, from_vertex, true)
  end

end

class GraphGenerator

  attr_reader :filename, :directed

  def initialize(filename, directed)
    @filename = filename
    @directed = directed
  end

  def generate_graph
    graph = Graph.new(directed)

    File.open("#{filename}", 'r') do |f|
      while (line = f.gets)
        graph.insert_edge(*line.chomp.split)
      end
    end

    graph.vertex_count = graph.edges.keys.count

    graph
  end

end
