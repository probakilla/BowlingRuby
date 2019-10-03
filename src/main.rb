# frozen_string_literal: true

require_relative 'game_display.rb'
require_relative 'pannel.rb'

def start_game
  disp = Display.new
  disp.display_pannel
  while disp.current_pannel < 10
    roll = Random.rand(disp.current_pins + 1)
    disp.roll(roll)
  end
  system 'clear'
  puts "Congratulations ! You scored: #{disp.total_score}"
end

start_game
