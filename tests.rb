#!/usr/bin/env ruby1.9
require 'test/unit'
require 'vec'

class TestVec < Test::Unit::TestCase
  def setup
  end
  def teardown
  end

  def test_new
    assert_nothing_raised { Vec.new(1, 2, 3) }
    assert_nothing_raised { Vec.new(1, 2.3, 3) }
  end
  def test_bad_new
    assert_raise (ArgumentError) { Vec.new }
    assert_raise (ArgumentError) { Vec.new(1) }
    assert_raise (ArgumentError) { Vec.new(1, 2) }
    assert_raise (ArgumentError) { Vec.new(1, 2, 3, 4) }
  end
  def test_string_representation
    assert_equal("Vec(1.0, 2.0, 3.0)", Vec.new(1, 2, 3).to_s)
    assert_equal("Vec(1.0, 2.3, 3.4)", Vec.new(1, 2.3, 3.36).to_s)
  end
  def test_equal
    assert_equal(Vec.new(1, 2, 3), Vec.new(1, 2, 3))
    assert_equal(Vec.new(1, 2.3, 3), Vec.new(1, 2.3, 3.0))
  end
  def test_not_equal
    assert_not_equal(Vec.new(1, 2, 3), Vec.new(0, 2, 3))
    assert_not_equal(Vec.new(1, 2.3, 3), Vec.new(1, 2, 3))
    assert_not_equal(Vec.new(1, 2.33, 3), Vec.new(1, 2.3, 3))
  end
  def test_get_attributes
    v = Vec.new(1, 2.3, 3)
    assert_equal(v.x, 1)
    assert_equal(v.y, 2.3)
    assert_equal(v.z, 3.0)
  end
  def test_set_attributes
    v = Vec.new(1, 2.3, 3)
    v.x = 2
    v.y = 3
    v.z = 4.3
    assert_equal(v.x, 2)
    assert_equal(v.y, 3.0)
    assert_equal(v.z, 4.3)
  end
  def test_get_length
    assert_equal(1, Vec.new(1, 0, 0).length)
    assert_equal(2, Vec.new(0, 2, 0).length)
    assert_equal(3, Vec.new(0, 0, 3).length)
    assert_equal(Math.sqrt(1**2 + 2**2 + 3**2), Vec.new(1, 2, 3).length)
  end
  def test_set_length
    v1 = Vec.new(1, 2, 3)
    v2 = Vec.new(1, 2, 3)
    v2.length = 2
    assert_equal(v2.length, 2)
    assert_equal(v2.x / v1.x, v2.length / v1.length)
    assert_equal(v2.y / v1.y, v2.length / v1.length)
    assert_equal(v2.z / v1.z, v2.length / v1.length)
  end
  def test_scale_up
    v1 = Vec.new(1, 2, 3)
    v2 = Vec.new(2, 4, 6)
    v1.length *= 2
    assert_equal(v1, v2)
  end
  def test_scale_down
    v1 = Vec.new(1, 2, 3)
    v2 = Vec.new(2, 4, 6)
    v2.length /= 2
    assert_equal(v1, v2)
  end
  def test_normalize
    v1 = Vec.new(1, 2, 3)
    v2 = Vec.new(1, 2, 3).normalize!
    assert_equal(v2.length, 1)
    assert_equal(v1.length * v2.x, v1.x)
    assert_equal(v1.length * v2.y, v1.y)
    assert_equal(v1.length * v2.z, v1.z)
  end
  def test_add
    v1 = Vec.new(1, 2, 3)
    v2 = Vec.new(4, 5, 6)
    assert_equal(v1 + v2, Vec.new(5, 7, 9))
    assert_equal(v1.component_add(v2), Vec.new(5, 7, 9))
    assert_equal(v1 + 2, Vec.new(3, 4, 5))
    assert_equal(v1.component_add(2), Vec.new(3, 4, 5))
#    assert_equal(2 + v1, Vec.new(3, 4, 5))
  end
  def test_sub
    v1 = Vec.new(4, 6, 8)
    v2 = Vec.new(1, 2, 3)
    assert_equal(v1 - v2, Vec.new(3, 4, 5))
    assert_equal(v1.component_sub(v2), Vec.new(3, 4, 5))
    assert_equal(v1 - 2, Vec.new(2, 4, 6))
    assert_equal(v1.component_sub(2), Vec.new(2, 4, 6))
#    assert_equal(2 - v2, Vec.new(1, 0, -1))
  end
  def test_mul
    v1 = Vec.new(4, 6, 8)
    v2 = Vec.new(1, 2, 3)
    assert_equal(v1.component_mul(v2), Vec.new(4, 12, 24))
    assert_equal(v1.component_mul(3), Vec.new(12, 18, 24))
  end
  def test_div
    v1 = Vec.new(4, 6, 15)
    v2 = Vec.new(1, 2, 3)
    assert_equal(v1.component_div(v2), Vec.new(4, 3, 5))
    assert_equal(v1.component_div(3), Vec.new(4/3, 2, 5))
  end
  def test_dot_angle
    v1 = Vec.new(3, 0, 0)
    v2 = Vec.new(1, 1, 0)
    angle = Math.acos((v1 * v2) / (v1.length * v2.length))
    assert_equal((Math::PI/4).round(4), angle.round(4))
    assert_equal(v1 * v2, v1.dot(v2))
  end
  def test_cross_is_perpendicular
    v1 = Vec.new(1, 1, -1)
    v2 = Vec.new(-1, 1, 1)
    v3 = v1 ** v2
    assert_equal(0, v1 * v3)
    assert_equal(0, v2 * v3)
    assert_equal(v1 ** v2, v1.cross(v2))
  end
end
