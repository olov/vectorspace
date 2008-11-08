# Copyright (c) 2008 Olov Lassus <olov.lassus@gmail.com>
# See LICENSE file for license details.

require 'test/unit'
require 'vec'

class TestVec < Test::Unit::TestCase
  def setup
  end
  def teardown
  end

  def test_new_constructor
    assert_nothing_raised { Vec.new(1, 2, 3) }
    assert_nothing_raised { Vec.new(1, 2.3, 3) }
  end
  def test_new_array
    assert_nothing_raised { Vec[1, 2, 3] }
    assert_nothing_raised { Vec[1, 2.3, 3] }
  end
  def test_bad_new_constructor
    assert_raise (ArgumentError) { Vec.new }
    assert_raise (ArgumentError) { Vec.new(1) }
    assert_raise (ArgumentError) { Vec.new(1, 2) }
    assert_raise (ArgumentError) { Vec.new(1, 2, 3, 4) }
  end
  def test_bad_new_array
    assert_raise (ArgumentError) { Vec[] }
    assert_raise (ArgumentError) { Vec[1] }
    assert_raise (ArgumentError) { Vec[1, 2] }
    assert_raise (ArgumentError) { Vec[1, 2, 3, 4] }
  end
  def test_new_array_equals_constructor
    assert_equal(Vec.new(1, 2, 3), Vec[1, 2, 3])
    assert_equal(Vec.new(1, 2.3, 3), Vec[1, 2.3, 3])
  end
  def test_string_representation
    assert_equal("Vec[1.0, 2.0, 3.0]", Vec[1, 2, 3].to_s)
    assert_equal("Vec[1.0, 2.3, 3.4]", Vec[1, 2.3, 3.36].to_s)
  end
  def test_equal
    assert_equal(Vec[1, 2, 3], Vec[1, 2, 3])
    assert_equal(Vec[1, 2.3, 3], Vec[1, 2.3, 3.0])
  end
  def test_not_equal
    assert_not_equal(Vec[1, 2, 3], Vec[0, 2, 3])
    assert_not_equal(Vec[1, 2.3, 3], Vec[1, 2, 3])
    assert_not_equal(Vec[1, 2.33, 3], Vec[1, 2.3, 3])
  end
  def test_get_attributes
    v = Vec[1, 2.3, 3]
    assert_equal(1, v.x)
    assert_equal(2.3, v.y)
    assert_equal(3.0, v.z)
  end
  def test_set_attributes
    v = Vec[1, 2.3, 3]
    v.x = 2
    v.y = 3
    v.z = 4.3
    assert_equal(2, v.x)
    assert_equal(3.0, v.y)
    assert_equal(4.3, v.z)
  end
  def test_get_length
    assert_equal(1, Vec[1, 0, 0].length)
    assert_equal(2, Vec[0, 2, 0].length)
    assert_equal(3, Vec[0, 0, 3].length)
    assert_equal(Math.sqrt(1**2 + 2**2 + 3**2), Vec[1, 2, 3].length)
  end
  def test_set_length
    v1 = Vec[1, 2, 3]
    v2 = Vec[1, 2, 3]
    v2.length = 2
    assert_equal(v2.length, 2)
    assert_equal(v2.length / v1.length, v2.x / v1.x)
    assert_equal(v2.length / v1.length, v2.y / v1.y)
    assert_equal(v2.length / v1.length, v2.z / v1.z)
  end
  def test_scale_up
    v1 = Vec[1, 2, 3]
    v2 = Vec[2, 4, 6]
    v1.length *= 2
    assert_equal(v2, v1)
  end
  def test_scale_down
    v1 = Vec[1, 2, 3]
    v2 = Vec[2, 4, 6]
    v2.length /= 2
    assert_equal(v1, v2)
  end
  def test_normalize
    v1 = Vec[1, 2, 3]
    v2 = Vec[1, 2, 3].normalize!
    assert_equal(1, v2.length)
    assert_equal(v1.x, v1.length * v2.x)
    assert_equal(v1.y, v1.length * v2.y)
    assert_equal(v1.z, v1.length * v2.z)
  end
  def test_add
    v1 = Vec[1, 2, 3]
    v2 = Vec[4, 5, 6]
    assert_equal(Vec[5, 7, 9], v1 + v2)
    assert_equal(v1 + v2, v1.add(v2))
    assert_equal(Vec[3, 4, 5], v1 + 2)
    assert_equal(v1 + 2, v1.add(2))
  end
  def test_sub
    v1 = Vec[4, 6, 8]
    v2 = Vec[1, 2, 3]
    assert_equal(Vec[3, 4, 5], v1 - v2)
    assert_equal(v1 - v2, v1.sub(v2))
    assert_equal(Vec[2, 4, 6], v1 - 2)
    assert_equal(v1 - 2, v1.sub(2))
  end
  def test_mul
    v1 = Vec[4, 6, 8]
    v2 = Vec[1, 2, 3]
    assert_equal(Vec[4, 12, 24], v1 * v2)
    assert_equal(v1 * v2, v1.mul(v2))
    assert_equal(Vec[12, 18, 24], v1 * 3)
    assert_equal(v1 * 3, v1.mul(3))
  end
  def test_div
    v1 = Vec[4, 6, 15]
    v2 = Vec[1, 2, 3]
    assert_equal(Vec[4, 3, 5], v1 / v2)
    assert_equal(v1 / v2, v1.div(v2))
    assert_equal(Vec[4/3.0, 2, 5], v1 / 3.0)
    assert_equal(v1 / 3, v1.div(3))
  end
  def test_dot_angle
    v1 = Vec[3, 0, 0]
    v2 = Vec[1, 1, 0]
    angle = Math.acos((v1 ** v2) / (v1.length * v2.length))
    assert_in_delta((Math::PI/4), angle, 0.01)
    assert_equal(v1 ** v2, v1.dot(v2))
  end
  def test_cross_is_perpendicular
    v1 = Vec[1, 1, -1]
    v2 = Vec[-1, 1, 1]
    v3 = v1 % v2
    assert_equal(0, v1 ** v3)
    assert_equal(0, v2 ** v3)
    assert_equal(v1 % v2, v1.cross(v2))
  end
  def test_coerce
    v = Vec[-1, 1, 3]
    assert_equal(Vec[1, 3, 5], 2 + v)
    assert_equal(Vec[3, 1, -1], 2 - v)
    assert_equal(Vec[-2, 2, 2.0/3], 2.0 / v)
    assert_equal(Vec[-2, 2, 6], 2 * v)
  end
end
