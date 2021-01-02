class Map
  attr_reader :start_xy, :goal_xy, :field

  START,GOAL = "S","G"
  WALL = "#"

  def initialize
    @field = DATA.read.split.map{|r|r.split("")}
    @h = @field.size
    @w = @field[0].size
    @start_xy = find_xy(START)
    @goal_xy = find_xy(GOAL)
  end

  def find_xy(char)
    @field.each_with_index do |ar,y|
      if ar.include?(char) then
        x = ar.index(char)
        return[x,y]
      end
    end
  end

  def description
    puts"地図サイズは#{@h}x#{@w}です"
    puts"スタート座標は#{@start_xy}です"
    puts"ゴール座標は#{goal_xy}です"
  end
  
  def display(route=[])
    route.each do |x,y|
      @field[y][x] = "\e[32m*\e[0m"
    end

    puts "-" * 30

    @field.each do |ar|
      puts ar.join
    end
  end

  def valid?(x,y)
    return false if x < 0
    return false if y < 0
    return false if x >= @w
    return false if y >= @h
    return false if @field[y][x] == WALL
    return true
  end

  def distance2goal(x,y)
    hen1 = (@goal_xy[0] - x).abs ** 2
    hen2 = (@goal_xy[1] - y).abs ** 2
    ans = Math.sqrt(hen1 + hen2)
    return ans
  end
end

# __FILE__== $0
#   map = Map.new
#   map.description
#   map.display
#   p map.valid?(1,0)
#   p map.valid?(2,0)
#   p map.valid?(-2,0)
#   p map.valid?(10,0)
#   p map.distance2goal(0,0)
#   p map.distance2goal(0,4)
#   p map.distance2goal(4,4)

#ここから下は実行されない
# DATAから読み出し可能
__END__

S.#.G
..#..
.....
..#..
..#..
