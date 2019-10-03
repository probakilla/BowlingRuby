# frozen_string_literal: true

require_relative 'game.rb'

# Display the game in the console
class Display < Game
  def initialize
    super
    initialize_pins
  end

  def display_pannel
    system 'clear'
    display = first_line + second_line + third_line + fourth_line + "\n"
    puts display
    puts screen_number
  end

  def roll(value)
    super(value)
    knock_down_pins(value)
    display_pannel
    puts "Knocked #{value} pins"
    puts '===GUTTER===' if value.zero?
    display_strike_or_spare
    gets
  end

  private

  def initialize_pins
    @display_pins = Array.new(Pannel::MAX_PINS, true)
  end

  def pannel_finished?
    return if @pannels[@current_pannel].can_roll?

    @current_pannel += 1
    @pannels[@current_pannel] = Pannel.new
    initialize_pins
  end

  def first_line
    " #{get_pin_from_array(0)} #{get_pin_from_array(1)}" \
    " #{get_pin_from_array(2)} #{get_pin_from_array(3)}\n"
  end

  def second_line
    "  #{get_pin_from_array(4)} #{get_pin_from_array(5)} "\
    "#{get_pin_from_array(6)}\n"
  end

  def third_line
    "   #{get_pin_from_array(7)} #{get_pin_from_array(8)}\n"
  end

  def fourth_line
    "    #{get_pin_from_array(9)}"
  end

  def screen_number
    "Roll number: #{@current_pannel + 1}"
  end

  def get_pin_from_array(index)
    @display_pins[index] ? '*' : ' '
  end

  def display_strike_or_spare
    puts '===STRIKE===' if @pannels[@current_pannel].strike?
    puts '===SPARE===' if @pannels[@current_pannel].spare?
  end

  def knock_down_pins(number)
    while number.positive?
      random_num = Random.rand(10)
      if @display_pins[random_num]
        @display_pins[random_num] = false
        number -= 1
      end
    end
  end
end
