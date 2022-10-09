# frozen_string_literal: true

# Arraycompleted: all? any? include? none?, map, size, count, length, find_index
# select, find, find_all, reject, max, min
#
# Hash:
# not completed: all? any? include? none? each map! map
# find_all find_index reject max min size count length select find

module MyEnumerable
  def my_all?(value = nil)
    case
    when value.nil? && !block_given?
      each do |item|
        return false unless item
      end
      true
    when !value.nil?
      each do |item|
        return false unless value === item
      end
      true
    when block_given?
      each do |item|
        return false unless yield(item)
      end
      true
    else
      "Error: value has an invalid value (#{value})"
    end
  end

  def my_any?(value = nil)
    case
    when value.nil? && !block_given?

      return false unless size.positive?

      true
    when !value.nil?

      return false unless size.positive?

      each do |item|
        return true if value === item
      end
      false
    when block_given?
      each do |item|
        return false unless yield(item)
      end
      true
    else
      "Error: value has an invalid value (#{value})"
    end
  end

  def my_include?(value = nil)
    case
    when !value.nil?

      return false unless size.positive?

      each do |item|
        return true if value === item
      end
      false
    else
      "Error: value has an invalid value (#{value})"
    end
  end

  def my_none?(value = nil)
    case
    when value.nil? && !block_given?

      return true unless size.positive?

      each do |item|
        return true unless item
      end
      false
    when !value.nil?

      return true unless size.positive?

      each do |item|
        return false if value === item
      end
      true
    when block_given?
      each do |item|
        return false unless yield(item)
      end
      true
    else
      "Error: value has an invalid value (#{value})"
    end
  end

  def my_map
    case
    when block_given?

      return false unless size.positive?

      newArray = []
      each do |item|
        newArray << yield(item)
      end
      newArray
    else
      'Error: value has an invalid block given'
    end
  end

  def my_size
    size = 0
    each do |_item|
      size += 1
    end
    size
  end

  def my_count
    size = 0
    each do |_item|
      size += 1
    end
    size
  end

  def my_length
    size = 0
    each do |_item|
      size += 1
    end
    size
  end

  def my_select
    if block_given?
      newArray = []
      each do |item|
        newArray << item if yield(item)
      end
      newArray
    else
      'Error: value has an invalid block given'
    end
  end

  # невдуплил про if_none_proc
  def my_find(_if_none_proc = nil)
    case
    when block_given?
      each do |item|
        return item if yield(item)
      end
      false
    else
      'Error: value has an invalid block given'
    end
  end

  def my_find_all
    if block_given?
      newArray = []
      each do |item|
        newArray << item if yield(item)
      end
      newArray
    else
      'Error: value has an invalid block given'
    end
  end

  def my_find_index(value = nil)
    case
    when !value.nil? && !block_given?
      i = 0
      each do |item|
        return i if item == value

        i += 1
      end
      false
    when block_given?
      i = 0
      each do |item|
        return i if yield(item)

        i += 1
      end
      false
    else
      'Error: value has an invalid block given'
    end
  end

  def my_reject
    if block_given?
      newArray = []
      each do |item|
        newArray << item unless yield(item)
      end
      newArray
    else
      'Error: value has an invalid block given'
    end
  end

  def my_min(value = nil)
    case
    when value.nil?
      return nil unless size.positive?

      minValue = self[0]
      each do |_item|
        each do |i|
          minValue = i if minValue > i
        end
      end
      minValue
    when !value.nil?

      return [] unless size.positive?

      arr = self
      minArr = []
      i = 0
      while i < value
        minArr << arr.my_min
        arr.delete(arr.my_min)
        i += 1
      end
      minArr
    end
  end

  def my_max
    return nil unless my_size.positive?

    case
    when value.nil?
      manValue = self[0]
      each do |_item|
        each do |i|
          manValue = i if manValue < i
        end
      end
      manValue
    when !value.nil?

      return [] unless size.positive?

      arr = self
      minArr = []
      i = 0
      while i < value
        minArr << arr.my_min
        arr.delete(arr.my_min)
        i += 1
      end
      minArr
    end
  end
end

class Array
  include MyEnumerable
end
