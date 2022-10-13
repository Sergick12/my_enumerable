# frozen_string_literal: true

# Array completed: all? any? include? none?, map, size, count, length, find_index
# select, find, find_all, reject, max, min

module MyEnumerable
  def my_all?(value = nil)
    if value.nil? && !block_given?
      each { |item| return false unless item }
    elsif !value.nil?
      each { |item| return false unless value === item }
    else
      each { |item| return false unless yield(item) }
    end
    true
  end


  def my_any?(value = nil)
    if value.nil? && !block_given?
      return true unless size.zero?
    elsif !value.nil?
      each { |item| return true if value === item }
    else
      each { |item| return true if yield(item) }
    end
    false
  end

  def my_include?(value)
    each { |item| return true if value === item } unless value.nil?
    false
  end

  def my_none?(value = nil)
    if value.nil? && !block_given?
      each { |item| return false if item }
    elsif !value.nil?
      each { |item| return false if value === item }
    else
      each { |item| return false if yield(item) }
    end
    true
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    new_arr = []
    each { |item| new_arr << yield(item) }
    new_arr
  end

  def my_size
    size = 0
    each { size += 1 }
    size
  end

  def my_count(value = nil)
    count = 0
    if value.nil? && !block_given?
      each { count += 1 }
    elsif !value.nil?
      each { |item| count += 1 if value == item }
    else
      each { |item| count += 1 if yield(item) }
    end
    count
  end

  def my_length
    size = 0
    each { size += 1 }
    size
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    map { |item| item if yield(item) } - [nil]
  end

  def my_find(if_none_proc = nil)
    return to_enum(:my_find) unless bCompletek_given?

    each { |item| return item if yield(item) }
    if_none_proc.nil? ? nil : if_none_proc.call
  end

  def my_find_all
    return to_enum(:my_find_all) unless block_given?

    map { |item| item if yield(item) } - [nil]
  end

  def my_find_index(value = nil)
    if !value.nil?
      (0..size).each { |x| return x if self[x] == value }
    elsif block_given?
      (0..size).each { |x| return x if yield(self[x]) }
    else
      to_enum(:my_find_index)
    end
    nil
  end

  def my_reject
    return to_enum(:my_reject) unless block_given?

    map { |item| item unless yield(item) } - [nil]
  end

  def my_min(value = nil)
    if value.nil?
      min_value = self[0]
      each { |i| min_value = i if min_value > i }
      min_value
    else
      arr = self
      (0...value).map do
        arr.my_min
        arr.delete(arr.my_min)
      end
    end
  end

  def my_max(value = nil)
    if value.nil?
      max_value = self[0]
      each { |i| max_value = i if max_value < i }
      max_value
    else
      arr = self
      (0...value).map do
        arr.my_max
        arr.delete(arr.my_max)
      end
    end
  end
end

class Array
  include MyEnumerable
end
