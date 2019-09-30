require_relative 'pannel.rb'

class Pannel
  MAX_PINS = 10
  INIT_NB_ROLLS = 2

  attr_reader :score

  def initialization
    @roll_left = INIT_NB_ROLLS
    @score = 0
    @pin_left = MAX_PINS
    @bonus_score = 0
  end

  def roll(nb_pins)
    raise ArgumentError unless nb_pins.is_a? (Integer)
    check_roll(nb_pins)
    change_pin_numbers(nb_pins)
  end

  def can_roll
    @roll_left > 0
  end

  def can_add_bonus_score
    false
  end

  def add_bonus_score(score)
    check_add_bonus_score(score)
  end

  private

  def check_roll(roll)
    raise PannelError, "Invalid roll value must be between 0 and #{@pin_left}" unless roll >= 0 and roll <= @pin_left
  end

  def check_add_bonus_score(score)
    raise PannelError, "Invalid parameter, must be between 0 and 10" unless score >= 0 and roll <= MAX_PINS
  end

  def change_pin_numbers(roll)
    if can_roll()
      @pin_left -= roll
      @roll_left -= 1
    else
      raise PannelError, 'Cannot play anymore'
    end
    @pin_left = 0 if @pin_left < 0
  end
end