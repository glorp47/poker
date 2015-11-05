require_relative 'hand'

class Player

  attr_accessor :name, :hand, :pot

  def initialize(name, hand=[], pot=500)
    @name = name
    @hand = Hand.new
    @pot = pot
  end

  def discard
    puts "#{@hand}"
    puts "Select index of card you want to discard"
    index = gets.chomp.to_i
    @hand.discard(index)
  end

  def add(card)
    @hand.add(card)
  end

  def fold
  end

  def raise_pot(game_pot)
    puts "Your pot = #{pot}, how much you wanna raise"
    amount = gets.chomp.to_i
    @pot -= amount
    amount
  end

  def see(game_pot, amount)
    @pot -= amount
    amount
  end

  def won?
    pot == 0
  end

end
