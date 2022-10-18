# frozen_string_literal: true

require_relative '../my_enumerable'
require 'rspec'

RSpec.describe MyEnumerable do
  arr_char = %w[bar baz bat bam]
  let(:arr) { [1, 2, 3, 4] }

  describe '#my_all?' do
    context 'when no argument and no block given' do
      it { expect(arr.my_all?).to eq(true) }
    end

    context 'when argument' do
      it { expect(arr_char.my_all?(/ba/)).to eq(true) }
    end

    context 'when block given' do
      it { expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(true) }
    end
  end
  describe '#my_any?' do
    context 'when no argument and no block given' do
      it { expect(arr.my_any?).to eq(true) }
    end

    context 'when argument and no block given' do
      it { expect(arr_char.my_any?(/m/)).to eq(true) }
    end

    context 'when block given' do
      it { expect(arr.my_any? { |element| element < 2 }).to eq(true) }
    end
  end

  describe '#my_none?' do
    context 'when no argument and no block given' do
      it { expect([nil, false].my_none?).to eq(true) }
    end

    context 'when argument and no block given' do
      it { expect(arr_char.my_none?('ba')).to eq(true) }
    end

    context 'when block given' do
      it { expect(arr.my_none? { |element| element < 1 }).to eq(true) }
    end
  end

  describe '#my_map' do
    context 'when no argument and no block given' do
      it { expect(arr.my_map) == arr.to_enum(:my_map) }
    end

    context 'when argument and no block given' do
      it { expect { arr.my_map(5) }.to raise_error(ArgumentError) }
    end

    context 'when block given' do
      it { expect(arr.my_map { |i| i * i }).to eq([1, 4, 9, 16]) }
    end
  end

  describe '#my_include?' do
    context 'when no argument and no block given' do
      it { expect { arr.my_include? }.to raise_error(ArgumentError) }
    end
    context 'when argument' do
      it { expect(arr.my_include?(2)).to eq(true) }
    end
  end

  describe '#my_select' do
    context 'when no argument and no block given' do
      it { expect(arr.my_select) == arr.to_enum(:my_reject) }
    end

    context 'when argument' do
      it { expect { arr.my_select(2) }.to raise_error(ArgumentError) }
    end

    context 'when block given' do
      it { expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |element| (element % 3).zero? }).to eq([0, 3, 6, 9]) }
    end
  end

  describe '#my_min' do
    context 'when no argument and no block given' do
      it { expect(arr.my_min).to eq(1) }
    end

    context 'when argument' do
      it { expect(arr.my_min(2)).to eq([1, 2]) }
    end

    context 'when block given' do
      it { expect(arr.my_min(3)).to eq([1, 2, 3]) }
    end
  end

  describe '#my_max' do
    context 'when no argument and no block given' do
      it { expect(arr.my_max).to eq(4) }
    end

    context 'when argument' do
      it { expect(arr.my_max(3)).to eq([4, 3, 2]) }
    end
    context 'when block given' do
      it { expect(arr.my_max(2)).to eq([4, 3]) }
    end
  end

  describe '#my_reject' do
    context 'when no argument and no block given' do
      it { expect(arr.my_reject) == arr.to_enum(:my_reject) }
    end

    context 'when argument' do
      it { expect { [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_reject(5) }.to raise_error(ArgumentError) }
    end

    context 'when block given' do
      it { expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_reject { |i| i * 2 if i.even? }).to eq([1, 3, 5, 7, 9]) }
    end
  end

  describe '#my_find_index' do
    context 'when no argument and no block given' do
      it { expect(arr.my_find_index) == arr.to_enum(:my_find_index) }
    end

    context 'when argument' do
      it { expect(%w[a b c b].my_find_index('b')).to eq(1) }
    end

    context 'when block given' do
      it { expect(%w[a b c b].my_find_index { |element| element.start_with?('b') }).to eq(1) }
    end
  end

  describe '#my_find_all' do
    context 'when no argument and no block given' do
      it { expect(arr.my_find_all) == arr.to_enum(:my_find_all) }
    end
    context 'when argument' do
      it { expect { arr.my_find_all(3) }.to raise_error(ArgumentError) }
    end
    context 'when block given' do
      it { expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_find_all { |element| (element % 3).zero? }).to eq([3, 6, 9]) }
    end
  end

  describe '#my_find' do
    context 'when no argument and no block given' do
      it { expect(arr.my_find) == arr.to_enum(:my_find) }
    end
    context 'when proc argument and no block given' do
      it { expect(arr.my_find(proc { false })) == arr.to_enum(:my_find, proc { false }) }
    end
    context 'when proc argument and block given' do
      it { expect(arr.my_find(proc { false }) { |x| x > 10 }).to eq(false) }
      it { expect(arr.my_find(proc { false }) { |x| x > 2 }).to eq(3) }
    end
    context 'when no argument and block given' do
      it { expect(arr.my_find { |x| x > 2 }).to eq(3) }
      it { expect(arr.my_find { |x| x > 10 }).to eq(nil) }
    end
    context 'when argument != proc and block given' do
      it { expect(arr.my_find(3) { |x| x > 2 }).to eq(3) }
      it { expect { arr.my_find(3) { |x| x > 10 } }.to raise_error(NoMethodError) }
    end
    context 'when argument != proc and no block given' do
      it { expect(arr.my_find(3)) == arr.to_enum(:my_find) }
    end
    context 'when empty array' do
      it { expect([].my_find { |x| x > 2 }).to eq(nil) }
    end
  end

  describe '#my_count' do
    arr1 = [1, 2, 4, 2]
    context 'when no argument and no block given' do
      it { expect(arr1.my_count).to eq(4) }
    end

    context 'when argument and no block given' do
      it { expect(arr1.my_count(2)).to eq(2) }
    end

    context 'when block given' do
      it { expect(arr1.my_count { |element| (element % 2).zero? }).to eq(3) }
    end
  end
end
