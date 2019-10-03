# frozen_string_literal: true

require_relative 'pannel.rb'

# Class for the game which use the pannel class
class Game
  attr_reader :current_pannel

  def initialize
    @pannels = Array.new(10, Pannel.new)
    @pannels[0] = Pannel.new
    @current_pannel = 0
  end

  def roll(value)
    pannel_finished?
    return unless @current_pannel < 10

    @pannels[@current_pannel].roll(value)
    update_score(value)
  end

  def total_score
    total = 0
    @pannels.each do |pannel|
      total += pannel.score
    end
    total = total
  end

  def current_pins
    @pannels[@current_pannel].pin_left
  end

  private

  def pannel_finished?
    return if @pannels[@current_pannel].can_roll?

    @current_pannel += 1
    @pannels[@current_pannel] = Pannel.new
  end

  def update_score(roll)
    for i in 0..(@current_pannel - 1)
      @pannels[i].add_bonus_score(roll) if @pannels[i].can_add_bonus_score?
    end
  end
end
