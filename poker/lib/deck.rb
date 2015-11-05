require_relative 'card'

class Deck
  attr_accessor :deck

  def initialize
    @deck =[]
    populate_deck
  end

  def populate_deck
    suits = [:heart, :spade, :club, :diamond]

    (2..14).each do |val|
      suits.each do |suit|
        deck << Card.new(val, suit)
      end
    end
  end

  def shuffle!
    @deck.shuffle!
  end

  def length
    @deck.length
  end

  def pop
    @deck.pop
  end
  
end
