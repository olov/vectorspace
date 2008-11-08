class Vec
  attr_accessor :x, :y, :z
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
  def ==(other)
    @x == other.x and @y == other.y and @z == other.z
  end
  def to_s
    sprintf "Vec(%.1f, %.1f, %.1f)", @x, @y, @z
  end
end
