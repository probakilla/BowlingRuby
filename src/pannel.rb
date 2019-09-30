require_relative 'pannel_error.rb'

class Pannel
  MAX_PINS = 10
  INIT_NB_ROLLS = 2

  attr_reader :score

  def initialize()
    @roll_left = Pannel::INIT_NB_ROLLS
    @score = 0
    @pin_left = Pannel::MAX_PINS
    @bonus_score = 0
  end

  def roll(nb_pins)
    check_roll(nb_pins)
    change_pin_numbers(nb_pins)
  end

  def can_roll()
    @roll_left > 0
  end

  def can_add_bonus_score()
    @bonus_score > 0
  end

  def add_bonus_score(score)
    check_add_bonus_score(score)
    @score += score
    @bonus_score -= 1
  end

  private

  def check_roll(roll)
    raise ArgumentError unless roll.is_a? (Integer)
    raise PannelError, "Invalid roll value must be between 0 and #{@pin_left}" if roll < 0 or roll > @pin_left
  end

  def check_add_bonus_score(score)
    raise ArgumentError, "Must be integer type" unless score.is_a?(Integer)
    raise PannelError, "Invalid parameter, must be between 0 and 10" if @score < 0 and @score > Pannel::MAX_PINS
    raise PannelError, "Can't add more score" if @bonus_score <= 0
  end

  def change_pin_numbers(roll)
    if can_roll()
      update_score(roll)
      check_spare_or_strike()
    else
      raise PannelError, 'Cannot play anymore'
    end
  end

  def update_score(roll)
    @pin_left -= roll
    @roll_left -= 1
    @score += roll
  end

  def check_spare_or_strike()
    if is_spare_or_strike()
      update_bonus_score()
      @roll_left = 0
    end
  end

  def is_spare_or_strike()
    @pin_left == 0
  end

  def update_bonus_score()
    if @roll_left == 0
      @bonus_score = 1
    elsif @roll_left == 1
      @bonus_score = 2
    end
  end

end