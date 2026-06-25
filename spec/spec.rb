require_relative "../lib/main"

describe ConnectFour do
  describe "#play" do
    describe "#insert_token" do
     context "player inserts token into empty column" do
      subject(:connect_four) { described_class.new }
      let(:player_one) { Player.new("red") }
      let(:board) { Board.new }
        xit "occupies lowest available space in the column" do
          expect{ board.insert_token(1, 2, player_one.colour) }.to change { board }
        end
      end
    end
    describe "#get_input" do
      context "when player gives valid input from col: 1 to 7" do
        it "returns the input" do
          player = Player.new("red")
          allow(player).to receive(:gets).and_return("1")
          expect(player.get_input).to eq(1)
        end
      end
      context "when player gives invalid input first then a valid input" do
        it "rejects the input first before accepting" do
          player = Player.new("red")
          allow(player).to receive(:gets).and_return("0", "2")
          prompt = 'Give a column(1-7) for red: '
          expect{ player.get_input }.to output(prompt * 2).to_stdout # will output twice
        end
      end
    end
  end
end

