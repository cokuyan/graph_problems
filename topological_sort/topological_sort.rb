require_relative 'dfs'

class TopologicalSort < DFS

  attr_reader :sorted

  def initialize(graph)
    @sorted = []
    super
  end

  def sort
    graph.edges.keys.each do |vertex|
      dfs(vertex) if !discovered[vertex]
    end
  end

  def print
    puts sorted.reverse.join(" ")
  end

  def process_vertex_late(vertex)
    sorted << vertex
  end

  def process_edge(vertex1, vertex2)
    if edge_classification(vertex1, vertex2) == :back
      fail "directed cycle found, not a DAG"
    end
  end

end
