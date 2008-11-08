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
    component_send(:+, other)
  end
  def -(other)
    component_send(:-, other)
  end
  alias component_add +
  alias component_sub -
  def component_mul(other)
    component_send(:*, other)
  end
  def component_div(other)
    component_send(:/, other)
  end

protected
  def scale!(l)
    @x *= l
    @y *= l
    @z *= l
    self
  end
  def component_send(fn_sym, other)
    if other.instance_of? Fixnum
      Vec.new(@x.send(fn_sym, other),
              @y.send(fn_sym, other),
              @z.send(fn_sym, other))
    else
      Vec.new(@x.send(fn_sym, other.x),
              @y.send(fn_sym, other.y),
              @z.send(fn_sym, other.z))
    end
  end
end
