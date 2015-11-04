require 'deck'

describe 'Deck' do
  let(:deck) { Deck.new }

  it "contains 52 elements" do
    expect(deck.length).to eq(52)
  end

  it "contains 4 Aces" do
    aces = deck.deck.select { |card| card.value == 14 }
    expect(aces.length).to eq(4)
  end

  it "shuffles deck" do
    shuffled = deck.shuffle!
    expect(deck).not_to eq(shuffled)
  end

  it "has a King" do
    king = Card.new(13, :heart)
    expect(deck.deck).to be_include(king)
  end
end
