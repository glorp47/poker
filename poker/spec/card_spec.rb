require 'card'

describe Card do
  let(:card) { Card.new(2, :heart) }

  it "creates new Card" do
    expect(card).to eq(Card.new(2, :heart))
  end

  it "interpolates Card to string" do
    expect(card.to_s).to eq("2 ♥")
  end
end
