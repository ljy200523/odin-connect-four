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
    describe "#check_win" do
      context "when no player has won" do
        subject(:board) { Board.new }
        it "returns exactly false" do
          expect(board.check_win).to be(false)
        end
      end
      context "when a player has won" do
        subject(:board) { Board.new }

        it "returns exactly true with 4 in a row" do
          board.insert_token(0, 0, "red")
          board.insert_token(0, 1, "red")
          board.insert_token(0, 2, "red")
          board.insert_token(0, 3, "red")
          expect(board.check_win).to be(true)
        end

        it "returns exactly true with 4 in a diagonal" do
          board.insert_token(0, 0, "red")
          board.insert_token(1, 1, "red")
          board.insert_token(2, 2, "red")
          board.insert_token(3, 3, "red")
          expect(board.check_win).to be(true)
        end
      end
    end
    describe "#check_full" do
      context "if board is full" do
        subject(:board_obj) { Board.new }
        before do
          board_obj.instance_variable_set(:@board, ["tired"])
        end
        it "returns exactly true" do
          expect(board_obj.check_full).to be(true)
        end
      end
      context "if board is not full" do
        subject(:board) { Board.new }
        it "returns exactly false" do
          expect(board.check_full).to be(false)
        end
      end
    end
  end
end

