# frozen_string_literal: true

module OutwoodLabels
  module Template
    class Base
      include Callable

      class << self
        attr_reader :columns, :name, :layout

        # @param name [String] template name
        def template_name(name)
          @name = name
        end

        # @param columns [Array<String>] required column names
        def accept_columns(*columns)
          @columns = columns
        end

        # @param layout [String] label page layout
        def page_layout(layout)
          @layout = layout
        end

        # @param columns [Array<String>] verify required columns are present
        # @return [Boolean] true when columns are present
        def valid_for?(columns)
          (@columns - columns).empty?
        end
      end
    end
  end
end
