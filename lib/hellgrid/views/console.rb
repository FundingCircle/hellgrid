module Hellgrid
  module Views
    class Console
      attr_reader :matrix

      def initialize(matrix)
        @matrix = matrix
      end

      def render
        puts render_as_string
      end

      def render_as_string
        string = []

        string << row_as_string(matrix[0])
        string << column_widths.map { |width| '-' * width }.join('+')

        matrix[1..matrix.size].each do |row|
          string << row_as_string(row)
        end

        string.join("\n") + "\n"
      end

      private

      def row_as_string(row)
        column_widths.map.with_index { |width, i| (row[i] || 'x').center(width) }.join('|')
      end

      def column_widths
        widths = Array.new(matrix[0].size, 0)

        matrix.each do |row|
          row.each_with_index do |value, col_i|
            if value && (widths[col_i] < value.size)
              widths[col_i] = value.size
            end
          end
        end

        widths.map { |width| width + 2 }
      end
    end
  end
end
