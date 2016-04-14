require_relative '../tsp'

describe "Traveling Salesman Problem" do
  let(:cities) { [[1, 2], [3, 4], [8, 7], [10, 12], [2, 4]] }

  it 'determines the shortest route for first city' do
    tsp = TSP.new(cities)
    answer_route = [[3, 4], [8, 7], [10, 12], [2, 4], [1, 2]]
    expect(tsp.route == answer_route || tsp.route == answer_route.reverse).to be true
  end

  it 'calculates length of the best route for first city' do
    tsp = TSP.new(cities)
    expect(tsp.dist.round(2)).to eq 32.00
  end

  let(:cities_2) { [[1,1], [8,4], [10, 11], [4, 5], [3,3], [5,6], [3,2]] }
  
  it 'determines the shortest route for second city' do
    tsp = TSP.new(cities_2)
    answer_route = [[1, 1], [3, 3], [4, 5], [5, 6], [10, 11], [8, 4], [3, 2]]
    expect(tsp.route == answer_route || tsp.route == answer_route.reverse).to be true
  end

  it 'calculates length of the best route for second city' do
    tsp = TSP.new(cities_2)
    expect(tsp.dist.round(2)).to eq 31.23
  end
end