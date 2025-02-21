# frozen_string_literal: true

require 'spec_helper'

describe Hellgrid::Views::Console do
  subject(:console) do
    described_class.new(
      [
        [nil, 'bar', 'foo'],
        ['b', '2.0.2', '2.0.1'],
        ['c', '3.0.2', '3.0.1'],
        ['a', nil, '1.0.1'],
        ['d', '4.0.2', nil]
      ]
    )
  end

  describe '#render_as_string' do
    it 'renders matrix' do
      expected_result = <<~TABLE
         x |  bar  |  foo#{'  '}
        ---+-------+-------
         b | 2.0.2 | 2.0.1#{' '}
         c | 3.0.2 | 3.0.1#{' '}
         a |   x   | 1.0.1#{' '}
         d | 4.0.2 |   x#{'   '}
      TABLE

      expect(console.render_as_string).to eq(expected_result)
    end
  end
end
