require "./map.rb"

class Explorer

  def initialize
    @map = Map.new
    @map.description
    @map.display

    @memo = {
      @map.start_xy => [
        0,
        0,
        true,
        [nil,nil]
      ]
    }
  end

  def move
    arr = @memo.select{|_,v|v[2]}.sort_by{|_,v|v[1]}
    xy = arr.to_h.keys.shift
    @memo[xy][2] = false
    return xy
  end
  
  #     上     右    下      左
  V = [[0,-1],[1,0],[0,1],[-1,0]]

  def look_around(xy)
    x,y = xy
    next_xy_list = []
    V.each do |vx,vy|
      next_x = x + vx
      next_y = y+ vy
      next_xy_list << [next_x,next_y]
    end

    next_xy_list.select! do |x,y|
      @map.valid?(x,y) and !@memo[[x,y]]
    end

    return next_xy_list
  end

  def take_memo(xy_list,pxy)
    step = @memo[pxy][0] + 1
    xy_list.each do |x,y|
      score = @map.distance2goal(x,y) + step
      memo = [step, score, true, pxy]
      @memo[[x,y]] = memo
    end
    return @memo
  end

  def goal?(xy)
    return true if xy.nil?
    return true if xy == @map.goal_xy
    return false
  end

  def check_route(xy)
    route = []
    until xy == @map.start_xy do
      route << xy
      xy = @memo[xy][3]
    end
    route.shift if route[0] == @map.goal_xy
    route.pop if route[-1] == @map.start_xy

    @map.display(route)
  end
end

if __FILE__== $0 then
  takashi = Explorer.new
  xy = takashi.move

  until takashi.goal?(xy) do
    next_xy_list = takashi.look_around(xy)
    takashi.take_memo(next_xy_list, xy)
    xy = takashi.move
  end
  takashi.check_route(xy)
  puts "ゴールしたよ！"
end
#ここから下は実行されない
# DATAから読み出し可能
__END__

S.#.G
..#..
.....
..#..
..#..
