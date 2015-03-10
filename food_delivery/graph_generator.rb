class EdgeNode

  attr_accessor :weight, :next, :adj, :name

  def initialize(adj, weight, name)
    @adj = adj
    @weight = weight
    @name = name
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

  def insert_edge(from_vertex, to_vertex, weight, name, directed = @directed)
    node = EdgeNode.new(to_vertex, weight, name)
    node.next = @edges[from_vertex]
    @edges[from_vertex] = node
    @edges[to_vertex] ||= nil

    @out_degree[from_vertex] += 1

    directed ? @edge_count += 1 : insert_edge(to_vertex, from_vertex, weight, name, true)
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
        line_parts = line.chomp.split('"')

        from_vertex = line_parts[0][0]
        to_vertex = line_parts[0][2]
        name = line_parts[1]
        weight = line_parts[2].split.map(&:to_i)

        graph.insert_edge(from_vertex, to_vertex, weight, name)
      end
    end

    graph.vertex_count = graph.edges.keys.count

    graph
  end

end
