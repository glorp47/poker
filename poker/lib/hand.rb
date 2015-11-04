require_relative 'card'

HAND_VALUES = [
  :high_card,
  :one_pair,
  :two_pair,
  :three_of_a_kind,
  :straight,
  :flush,
  :full_house,
  :four_of_a_kind,
  :straight_flush
]

class Hand
attr_accessor :hand, :hand_value

  def initialize()
    @hand = []
    @hand_value = nil
  end

  def add(card)
    @hand << card if hand.length < 5
    self.sort!
    self
  end

  def discard(index)
    @hand.delete_at(index) unless hand.empty?
    self
  end

  def to_s
    "#{@hand.join(", ")}"
  end

  def ==(hand2)
    @hand.each_index do |idx|
      return false unless self[idx] == hand2[idx]
    end
    true
  end

  def [](index)
    @hand[index]
  end

  def each
    @hand.each do |card|
      yield(card)
    end
  end

  def sort!
    @hand.sort! {|card1, card2 | card1.value <=> card2.value}
  end

  def find_hand
    if straight_flush?
      @hand_value = :straight_flush
      break
    elsif four_of_a_kind?
      @hand_value = :four_of_a_kind
      break
    elsif full_house?
      @hand_value = :full_house
      break
    elsif flush?
      @hand_value = :flush
      break
    elsif straight?
      @hand_value = :straight
      break
    elsif three_of_a_kind?
      @hand_value = :three_of_a_kind
      break
    elsif two_pair?
      @hand_value = :two_pair
      break
    elsif one_pair?
      @hand_value = :one_pair
      break
    else
      @hand_value = :high_card
    end
  end

  def compare_hands(opp_hand)
    my_value = HAND_VALUES.find_index(hand_value)
    opp_value = HAND_VALUES.find_index(opp_hand.hand_value)

    case my_value <=> opp_value
    when -1
      puts "opp wins"
    when 0
      break_tie(opp_hand)
    when 1
      puts "you win"
    end
  end

  def break_tie(opp_hand)
    puts "in break_tie"
    puts "you win"
  end

  def count_hand
    count = Hash.new(0)
    self.each do |card|
      count[card.value] += 1
    end

    count
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    count = count_hand
    count.values.include?(4)
  end

  def full_house?
    count = count_hand
    count.values.sort == [2, 3]
  end

  def flush?
    beginning_card = hand[0]
    (1..4).each do |i|
      return false if hand[i].suit != beginning_card.suit
    end
    true
  end

  def straight?
    beginning_card = hand[0]
    (1..4).each do |i|
      return false if hand[i].value != (beginning_card.value + i)
    end
    true
  end

  def three_of_a_kind?
    count = count_hand
    count.values.include?(3)
  end

  def two_pair?
    count = count_hand
    count.values.sort == [1, 2, 2]
  end

  def one_pair?
    count = count_hand
    count.values.include?(2)
  end



end
