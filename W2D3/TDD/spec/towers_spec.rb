require 'towers'

describe Towers do
  subject(:towers) { Towers.new }

  describe '#initialize' do
    it 'initializes towers' do
      expect(towers.towers).to eq([[3, 2, 1], [], []])
    end
  end

  describe '#move' do
    it 'moves disc' do
      towers.move(0, 1)
      expect(towers.towers).to eq([[3, 2], [1], []])
    end

    it 'raises error when moving a large disc ontop of a small disc' do
      towers.move(0, 2)
      expect { towers.move(0, 2) }.to raise_error("Invalid move")
    end

    it 'raises error when selecting from empty pile' do
      expect { towers.move(2, 1) }.to raise_error("Empty tower")
    end
  end

  describe '#won?' do
    it 'returns true if won' do
      towers.towers = [[], [], [3, 2, 1]]
      expect(towers.won?).to be true
    end

    it 'returns false if still playing' do
      expect(towers.won?).to be false
    end

    it 'returns false if still playing' do
      towers.move(0, 2)
      expect(towers.won?).to be false
    end
  end

end
