# frozen_string_literal: true

# app/models/string_calculator.rb
class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiters, numbers = extract_delimiters(numbers)
    num_array = split_numbers(numbers, delimiters)
    validate_negatives(num_array)

    sum_valid_numbers(num_array)
  end

  private

  def extract_delimiters(numbers)
    if numbers.start_with?('//')
      parts = numbers.split("\n", 2)
      delimiters = parts.first[2..].split(/]\[/).map { |d| Regexp.escape(d.gsub(/[\[\]]/, '')) }
      [Regexp.new(delimiters.join('|')), parts.last]
    else
      [/[,|\n]/, numbers]
    end
  end

  def split_numbers(numbers, delimiters)
    numbers.split(delimiters).map(&:to_i)
  end

  def validate_negatives(num_array)
    negatives = num_array.select(&:negative?)
    raise "negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?
  end

  def sum_valid_numbers(num_array)
    num_array.reject { |n| n > 1000 }.sum
  end
end
