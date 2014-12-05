module Graph
  class RoutesFinder
    Inf = 1.0 / 0

    def initialize(graph)
      @graph = {}
      graph.scan(/\w\w\d+/).each do |route|
        start = route[0,1]
        finish = route[1,1]
        @graph[start] ||= { }
        @graph[start][finish] = route[2..-1].to_i
      end    
    end
  
    attr_accessor :graph
  
    def distance(path)
      dist = 0
      path.each_char.map.inject do |prev, cur|
      return nil unless @graph[prev][cur]
        dist += @graph[prev][cur]
        cur
      end
      dist
    end

    def paths_search(start_point, end_point, stops, stats = {distance: 0, stops: 0}, &callback)
      min_stops_number = stats[:stops] >= stops[:min_stops]
      max_stops_number = stats[:distance] <= stops[:max_distance] && stats[:stops] <= stops[:max_stops]
      callback.call(stats[:path]) if start_point == end_point && min_stops_number && max_stops_number
      if max_stops_number
        @graph[start_point].each do |nxt, dist|
          inner_stats = {distance: stats[:distance] + dist, stops: stats[:stops] + 1}
          paths_search(nxt, end_point, stops, inner_stats, &callback)
        end
      end
    end

    def trips_number(start_point, end_point, stops = { })
      stops = { min_stops: 1, max_stops: Inf, max_distance: Inf }.merge(stops)
      total = 0
      paths_search(start_point, end_point, stops) { total += 1}
      total
    end
  
    def shortest_distance(start_point, end_point)
      stops = @graph.each.map { |k,v| [k, v.keys] }.flatten.uniq
      dist = { }
      stops.each { |x| dist[x] = Inf }
      dist[start_point] = 0
      if start_point == end_point then
        stops.delete(start_point)
        dist[start_point] = Inf
        @graph[start_point].each { |nxt, depth| dist[nxt] = depth}
      end
      while not stops.empty? do
        start_stop = stops.min { |a,b| dist[a] <=> dist[b] }
        if !start_stop || start_stop== Inf
          return nil
        end
        stops.delete(start_stop)
      
        @graph[start_stop].each_key do |v|
          altr = dist[start_stop] + (@graph[start_stop][v] || Inf)
          dist[v] = altr if dist[v] && altr < dist[v]
        end
      end
      return nil if dist[end_point] == Inf
      dist[end_point]
    end
  end
end
