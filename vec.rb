class Vec
  attr_accessor :x, :y, :z
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
  def coerce(other)
    [Vec.new(other, other, other), self]
  end
  def ==(other)
    if other.instance_of? Vec
      @x == other.x and @y == other.y and @z == other.z
    else
      false
    end
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
    component_send(:+, other)
  end
  def -(other)
    component_send(:-, other)
  end
  def *(other)
    component_send(:*, other)
  end
  def /(other)
    component_send(:/, other)
  end
  alias add +
  alias sub -
  alias mul *
  alias div /
  def **(other)
    @x * other.x + @y * other.y + @z * other.z
  end
  alias dot **
  def %(other)
    Vec.new(@y * other.z - @z * other.y,
            @z * other.x - @x * other.z,
            @x * other.y - @y * other.x)
  end
  alias cross %

protected
  def scale!(l)
    @x *= l
    @y *= l
    @z *= l
    self
  end
  def component_send(fn_sym, other)
    if other.instance_of? Vec
      Vec.new(@x.send(fn_sym, other.x),
              @y.send(fn_sym, other.y),
              @z.send(fn_sym, other.z))
    else
      Vec.new(@x.send(fn_sym, other),
              @y.send(fn_sym, other),
              @z.send(fn_sym, other))
    end
  end
end
