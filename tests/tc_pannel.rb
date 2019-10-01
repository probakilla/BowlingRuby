require 'test/unit'
require_relative '../src/pannel.rb'
require_relative '../src/pannel_error.rb'

class PannelTest < Test::Unit::TestCase

  def setup
    @pannel = Pannel.new
  end

  def test_initialization
    assert_equal(0, @pannel.score())
    assert(@pannel.can_roll())
  end

  def test_roll
    pannel = Pannel.new
    pannel.roll(5)
    assert_equal(5, pannel.score())
    pannel.roll(3)
    assert_equal(8, pannel.score())
  end

  def test_roll_errors
    assert_raise(PannelError) { @pannel.roll(11) }
    assert_raise(PannelError) { @pannel.roll(-1) }
    assert_raise(ArgumentError) { @pannel.roll('hello') }
    assert_raise(ArgumentError) { @pannel.roll(1.1) }
    assert_raise(PannelError) {
      @pannel.roll(5)
      @pannel.roll(6)
    }
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

  def test_can_add_bonus_score_spare
    @pannel.roll(5)
    @pannel.roll(5)
    assert(@pannel.can_add_bonus_score())
    @pannel.add_bonus_score(1)
    assert(!@pannel.can_add_bonus_score())
  end

  def test_can_add_bonus_score_normal
    @pannel.roll(10)
    assert(@pannel.can_add_bonus_score())
    @pannel.add_bonus_score(5)
    assert(@pannel.can_add_bonus_score())
    @pannel.add_bonus_score(5)
    assert(!@pannel.can_add_bonus_score())
  end

  def test_add_bonus_score_strike
    @pannel.roll(10)
    assert_equal(10, @pannel.score())
    @pannel.add_bonus_score(6)
    assert_equal(16, @pannel.score())
    @pannel.add_bonus_score(2)
    assert_equal(18, @pannel.score())
  end

  def test_add_bonus_score_spare
    @pannel.roll(5)
    @pannel.roll(5)
    assert(@pannel.can_add_bonus_score())
    @pannel.add_bonus_score(1)
    assert(!@pannel.can_add_bonus_score())
  end

  def test_add_bonus_score_errors
    assert_raise(PannelError) { @pannel.add_bonus_score(11) }
    assert_raise(PannelError) { @pannel.add_bonus_score(-1) }
    assert_raise(ArgumentError) { @pannel.add_bonus_score('hello') }
    assert_raise(ArgumentError) { @pannel.add_bonus_score(1.1) }
  end
end