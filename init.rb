require_relative'routes_finder'
include Graph
#p "Enter routes"
routes = gets.chomp
routes_search = RoutesFinder.new(routes)

  def answers(task, answer)
    if !answer
     puts "#{task}: NO SUCH ROUTE"
    else
     puts "#{task}: #{answer}"
    end
  end 
 
 answer = routes_search.distance("ABC")
 answers(1,answer)
 answer = routes_search.distance("AD")
 answers(2,answer)
 answer = routes_search.distance("ADC")
 answers(3,answer)
 answer = routes_search.distance("AEBCD")
 answers(4,answer)
 answer = routes_search.distance("AED")
 answers(5,answer)
 answer = routes_search.trips_number('C', 'C', max_stops: 3)
 answers(6,answer)
 answer = routes_search.trips_number('A', 'C', min_stops: 4, max_stops: 4)
 answers(7,answer)
 answer = routes_search.shortest_distance('A', 'C')
 answers(8,answer)
 answer = routes_search.shortest_distance('B', 'B')
 answers(9,answer)
 answer = routes_search.trips_number('C', 'C', max_distance: 29)
 answers(10,answer)
