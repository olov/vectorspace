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
end
