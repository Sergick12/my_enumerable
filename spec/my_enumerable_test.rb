# frozen_string_literal: true

require_relative '../my_enumerable'
require 'rspec'

RSpec.describe Enumerable do
  arr = [1, 2, 3, 4]
  arr_char = %w[bar baz bat bam]

  it 'my_all_test' do
    expect(arr.my_all?).to eq(true)
    expect(%w[a b c d].my_all?).to eq(true)
    expect([1, 2, nil].my_all?).to eq(false)
    expect(['a', 'b', false].my_all?).to eq(false)
    expect([].my_all?).to eq(true)
    expect(arr.my_all?(Integer)).to eq(true)
    expect(arr.my_all?(Numeric)).to eq(true)
    expect(arr.my_all?(Float)).to eq(false)
    expect(arr_char.my_all?(/ba/)).to eq(true)
    expect(arr_char.my_all?(/bar/)).to eq(false)
    expect(arr_char.my_all?('ba')).to eq(false)
    expect([].my_all?(Float)).to eq(true)
    expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(true)
    expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eq(false)
  end

  it 'my_any_test' do
    expect(arr.my_any?).to eq(true)
    expect(%w[a b c d].my_any?).to eq(true)
    expect([1, 2, nil].my_any?).to eq(true)
    expect([].my_any?).to eq(false)
    expect([nil, false, 0].my_any?(Integer)).to eq(true)
    expect([nil, false, 0].my_any?(Numeric)).to eq(true)
    expect([nil, false, 0].my_any?(Float)).to eq(false)
    expect([].my_any?(Integer)).to eq(false)
    expect(arr_char.my_any?(/m/)).to eq(true)
    expect(arr_char.my_any?(/foo/)).to eq(false)
    expect(arr_char.my_any?('ba')).to eq(false)
    expect(arr.my_any? { |element| element < 2 }).to eq(true)
    expect(arr.my_any? { |element| element < 1 }).to eq(false)
  end

  it 'my_none_test' do
    expect(arr.my_none?).to eq(false)
    expect([nil, false].my_none?).to eq(true)
    expect([].my_none?).to eq(true)
    expect([nil, false, 1.1].my_none?(Integer)).to eq(true)
    expect(arr_char.my_none?(/m/)).to eq(false)
    expect(arr_char.my_none?(/foo/)).to eq(true)
    expect(arr_char.my_none?('ba')).to eq(true)
    expect(arr.my_none? { |element| element < 1 }).to eq(true)
    expect(arr.my_none? { |element| element < 2 }).to eq(false)
  end

  it 'my_map_test' do
    expect([0, 1, 2, 3, 4].my_map { |i| i * i }).to eq([0, 1, 4, 9, 16])
    # expect([0, 1, 2, 3, 4].my_map).to eq()
  end

  it 'my_include_test' do
    expect(arr.my_include?(2)).to eq(true)
    expect(arr.my_include?(5)).to eq(false)
    expect(arr.my_include?('2')).to eq(false)
    expect(%w[a b c d].my_include?('b')).to eq(true)
    expect(%w[a b c d].my_include?('2')).to eq(false)
  end

  it 'my_select_test' do
    expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |element| (element % 3).zero? }).to eq([0, 3, 6, 9])
  end

  it 'my_min_test' do
    expect(arr.my_min).to eq(1)
    expect([-4, -3, -2, -1].my_min).to eq(-4)
    expect(%w[d c b a].my_min).to eq('a')
    expect([].my_min).to eq(nil)
    expect(arr.my_min(2)).to eq([1, 2])
    expect([-4, -3, -2, -1].my_min(2)).to eq([-4, -3])
  end
  it 'my_max_test' do
    expect(arr.my_max).to eq(4)
    expect([-4, -3, -2, -1].my_max).to eq(-1)
    expect(%w[d c b a].my_max).to eq('d')
    expect([].my_max).to eq(nil)
    expect(arr.my_max(2)).to eq([4, 3])
    expect([-4, -3, -2, -1].my_max(2)).to eq([-1, -2])
  end

  it 'my_reject_test' do
    expect([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].my_reject { |i| i * 2 if i.even? }).to eq([1, 3, 5, 7, 9])
  end

  it 'my_find_index_test' do
    expect(%w[a b c b].my_find_index('b')).to eq(1)
    expect(%w[a b c b].my_find_index { |element| element.start_with?('b') }).to eq(1)
  end

  it 'test_my_find_all' do
    expect([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_find_all { |element| (element % 3).zero? }).to eq([3, 6, 9])
  end

  it 'test_my_count' do
    arr1 = [1, 2, 4, 2]
    expect(arr1.my_count { |element| (element % 2).zero? }).to eq(3)
    expect(arr1.my_count).to eq(4)
    expect(arr1.my_count(2)).to eq(2)
  end
end
