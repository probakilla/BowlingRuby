require_relative 'pannel.rb'

class Game
  def initialize
    @pannels = Array.new(10, Pannel.new())
    @current_pannel = 0
  end

  def roll(value)
    check_pannel_finished()
    if @current_pannel < 10
      puts get_current_pins()
      @pannels[@current_pannel].roll(value)
      update_score(value)
    end
  end

  def total_score()
    total = 0
    for i in 0 .. @current_pannel
      total += @pannels[i].score
    end
    total = total
  end

  def get_current_pins()
    @pannels[@current_pannel].pin_left
  end

  private

  def check_pannel_finished()
    if !@pannels[@current_pannel].can_roll
      @current_pannel += 1
    end
  end

  def update_score(roll)
    @pannels.each { |pannel|
      if pannel.can_add_bonus_score
        pannel.add_bonus_score(roll)
      end
    }
  end
end