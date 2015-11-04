class Card
  attr_reader :value, :suit
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    value_arr = {
      2 => '2',
      3 => '3',
      4 => '4',
      5 => '5',
      6 => '6',
      7 => '7',
      8 => '8',
      9 => '9',
      10 => '10',
      11 => 'J',
      12 => 'Q',
      13 => 'K',
      14 => 'A'
    }

    suit_arr = {
      :heart => '♥',
      :spade => '♠',
      :diamond => '♦',
      :club => '♣'
    }

    "#{value_arr[value]} #{suit_arr[suit]}"
  end

  def ==(card2)
    value == card2.value && suit == card2.suit
  end
end
