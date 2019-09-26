require 'test/unit'
require_relative '../src/pannel.rb'

class GameTest < Test::Unit::TestCase
  def setup
    @pannel = Pannel.new()
  end

  def test_initialization
    assert_equal(0, @pannel.get_score())
  end

  def test_roll
    @pannel.roll(5)
    assert_equal(5, @pannel.get_score())
    @pannel.roll(3)
    assert_equal(8, @pannel.get_score())
  end

  def test_can_roll
    assert(@pannel.can_roll())
    @pannel.roll(5)
    assert(@pannel.can_roll())
    @pannel.roll(5)
    assert(!@pannel.can_roll())
    new_pannel = Pannel.new()
    new_pannel.roll(10)
    assert(!new_pannel.can_roll())
  end
end