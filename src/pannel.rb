# frozen_string_literal: true

require_relative 'pannel_error.rb'

# Class representing a roll for the Bowling game
class Pannel
  MAX_PINS = 10
  INIT_NB_ROLLS = 2

  attr_reader :score
  attr_reader :pin_left

  def initialize
    @roll_left = Pannel::INIT_NB_ROLLS
    @score = 0
    @pin_left = Pannel::MAX_PINS
    @bonus_score = 0
  end

  def roll(nb_pins)
    check_roll(nb_pins)
    change_pin_numbers(nb_pins)
  end

  def can_roll?
    @roll_left.positive?
  end

  def can_add_bonus_score?
    @bonus_score.positive?
  end

  def add_bonus_score(score)
    check_add_bonus_score(score)
    return unless @bonus_score.positive?

    @score += score
    @bonus_score -= 1
  end

  def strike?
    @roll_left == 1 && @pin_left.zero?
  end

  def spare?
    @roll_left.zero? && @pin_left.zero?
  end

  private

  def check_roll(roll)
    raise ArgumentError unless roll.is_a? Integer
    return unless roll.negative? || roll > @pin_left

    raise PannelError, "Invalid roll value must be between 0 and #{@pin_left}"
  end

  def check_add_bonus_score(score)
    raise ArgumentError, 'Must be integer type' unless score.is_a? Integer
    return unless score.negative? || score > 10

    raise PannelError, 'Invalid parameter, must be between 0 and 10'
  end

  def change_pin_numbers(roll)
    raise PannelError, 'Cannot play anymore' unless can_roll?

    update_score(roll)
    check_spare_or_strike
  end

  def update_score(roll)
    @pin_left -= roll
    @roll_left -= 1
    @score += roll
  end

  def check_spare_or_strike
    return unless spare_or_strike?

    update_bonus_score
    @roll_left = 0
  end

  def spare_or_strike?
    @pin_left.zero?
  end

  def update_bonus_score
    if @roll_left.zero?
      @bonus_score = 1
    elsif @roll_left == 1
      @bonus_score = 2
    end
  end
end
