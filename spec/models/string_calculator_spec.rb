# frozen_string_literal: true

# spec/models/string_calculator_spec.rb
require 'rails_helper'

RSpec.describe StringCalculator, type: :model do
  let(:calculator) { StringCalculator.new }

  describe '#add' do
    context 'with an empty string' do
      it 'returns 0' do
        expect(calculator.add('')).to eq(0)
      end
    end

    context 'with a single number' do
      it 'returns the number itself' do
        expect(calculator.add('1')).to eq(1)
      end
    end

    context 'with two numbers' do
      it 'returns the sum of two numbers' do
        expect(calculator.add('1,5')).to eq(6)
      end
    end

    context 'with newlines as delimiters' do
      it 'handles newlines correctly' do
        expect(calculator.add("1\n2,3")).to eq(6)
      end
    end

    context 'with different delimiters' do
      it 'supports a single custom delimiter' do
        expect(calculator.add("//;\n1;2")).to eq(3)
      end

      it 'handles multiple delimiters' do
        expect(calculator.add("//[*][%]\n1*2%3")).to eq(6)
      end

      it 'handles multiple delimiters of varying lengths' do
        expect(calculator.add("//[***][%%]\n1***2%%3")).to eq(6)
      end
    end

    context 'with negative numbers' do
      it 'throws an exception for a single negative number' do
        expect { calculator.add('1,-2,3') }.to raise_error('negative numbers not allowed: -2')
      end

      it 'shows all negative numbers in the exception message' do
        expect { calculator.add('-1,-2,3') }.to raise_error('negative numbers not allowed: -1, -2')
      end
    end

    context 'with numbers greater than 1000' do
      it 'ignores numbers greater than 1000' do
        expect(calculator.add('2,1001')).to eq(2)
      end

      it 'ignores large numbers in a string with multiple delimiters' do
        expect(calculator.add("//[***][%%]\n1001***2%%3")).to eq(5)
      end
    end

    context 'with complex cases' do
      it 'handles complex cases with different delimiters and ignores large numbers' do
        expect(calculator.add("//[***][%]\n1***1001%2***3")).to eq(6)
      end
    end
  end
end
