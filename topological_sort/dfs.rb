require_relative 'graph_generator'

class DFS

  attr_reader :graph, :discovered, :entry_time, :exit_time, :parent, :processed
  attr_accessor :time

  def initialize(graph)
    @graph = graph
    @time = 0
    @discovered = Hash.new(false)
    @processed = Hash.new(false)
    @finished = false
    @entry_time = {}
    @exit_time = {}
    @parent = {}
  end

  def finished?
    @finished
  end

  def dfs(start)
    initialize_vertex(start)

    edge = graph.edges[start]
    until edge.nil?
      adj = edge.adj

      if !discovered[adj]
        parent[adj] = start
        process_edge(start, adj)
        dfs(adj)
      elsif !processed[adj] || graph.directed
        process_edge(start, adj)
      end

      return if finished?
      edge = edge.next
    end

    finish_vertex(start)
  end

  def initialize_vertex(vertex)
    discovered[vertex] = true
    self.time += 1
    entry_time[vertex] = time

    process_vertex_early(vertex)
  end

  def finish_vertex(vertex)
    process_vertex_late(vertex)

    self.time += 1
    exit_time[vertex] = time
    processed[vertex] = true
  end

  def edge_classification(vertex1, vertex2)
    case
    when parent[vertex2] == vertex1 then :tree
    when discovered[vertex2] && !processed[vertex2] then :back
    when processed[vertex2] && entry_time[vertex2] > entry_time[vertex1] then :forward
    when processed[vertex2] && entry_time[vertex2] < entry_time[vertex1] then :cross
    else fail "unclassified edge: (#{vertex1}, #{vertex2})"
    end
  end

  def process_vertex_early(vertex)
  end

  def process_vertex_late(vertex)
  end

  def process_edge(vertex1, vertex2)
  end

end
