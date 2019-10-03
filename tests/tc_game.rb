# frozen_string_literal: true

require 'test/unit'
require_relative '../src/game.rb'

# Unit testing the pannel class
class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new
  end

  def test_scenario
    @game.roll(5)
    assert_equal(5, @game.current_pins)
    @game.roll(2)
    assert_equal(3, @game.current_pins)
    assert_equal(7, @game.total_score)

    @game.roll(4)
    assert_equal(6, @game.current_pins)
    @game.roll(1)
    assert_equal(5, @game.current_pins)
    assert_equal(12, @game.total_score)

    @game.roll(5)
    assert_equal(5, @game.current_pins)
    assert_equal(17, @game.total_score)
    @game.roll(5)
    assert_equal(0, @game.current_pins)
    assert_equal(22, @game.total_score)

    @game.roll(2)
    assert_equal(8, @game.current_pins)
    @game.roll(3)
    assert_equal(5, @game.current_pins)
    assert_equal(29, @game.total_score)

    @game.roll(10)
    assert_equal(0, @game.current_pins)
    assert_equal(39, @game.total_score)

    @game.roll(4)
    assert_equal(6, @game.current_pins)
    @game.roll(2)
    assert_equal(4, @game.current_pins)
    assert_equal(51, @game.total_score)

    @game.roll(7)
    assert_equal(3, @game.current_pins)
    @game.roll(3)
    assert_equal(0, @game.current_pins)
    assert_equal(61, @game.total_score)

    @game.roll(1)
    assert_equal(9, @game.current_pins)
    @game.roll(1)
    assert_equal(8, @game.current_pins)
    assert_equal(64, @game.total_score)

    @game.roll(10)
    assert_equal(0, @game.current_pins)
    assert_equal(74, @game.total_score)

    @game.roll(5)
    assert_equal(5, @game.current_pins)
    @game.roll(5)
    assert_equal(0, @game.current_pins)
    assert_equal(94, @game.total_score)
  end
end
