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
  def length
    Math.sqrt(@x ** 2 + @y ** 2 + @z ** 2)
  end
  def length=(l)
    scale!(l/length)
  end
  def normalize!
    scale!(1/length)
  end


  def +(other)
    if other.instance_of? Fixnum
      Vec.new @x + other, @y + other, @z + other
    else
      Vec.new @x + other.x, @y + other.y, @z + other.z
    end
  end
  alias component_add +

  def -(other)
    if other.instance_of? Fixnum
      Vec.new @x - other, @y - other, @z - other
    else
      Vec.new @x - other.x, @y - other.y, @z - other.z
    end
  end
  alias component_sub -

protected
  def scale!(l)
    @x *= l
    @y *= l
    @z *= l
    self
  end
end
