require './lib/tic_tac_toe.rb'

describe Board do
  describe '#check_for_win' do
    #located inside #check_for_win (Public script method)
    subject(:diagonal_win) { described_class.new([['X', ' ', ' '],[' ', 'X', ' '],[' ', ' ', 'X']]) }
    context 'when a player wins' do
      before do
        allow(diagonal_win).to receive(:victory)
      end
      it 'calls #victory' do
        expect(diagonal_win).to receive(:victory)
        diagonal_win.check_for_win
      end
    end

    context 'when no one has won' do
      subject(:no_win) { described_class.new }
      it 'does not call #victory' do
        expect(no_win).not_to receive(:victory)
        no_win.check_for_win
      end
    end
    
    context 'when game has tied' do
      subject(:tie_game) { described_class.new([['X', 'O', 'X'],['O', 'O', 'X'],['X', 'X', 'O']]) }
      before do
        allow(tie_game).to receive(:tie)
      end
      it 'calls #tie' do
        expect(tie_game).to receive(:tie)
        tie_game.check_for_win
      end
    end
  end
end