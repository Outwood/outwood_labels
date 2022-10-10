# frozen_string_literal: true

module OutwoodLabels
  class FileNamer
    include Callable

    # @param root [String]
    def initialize(root)
      @root = root
    end

    # @return [String]
    def call
      return "#{@root}.pdf" unless File.exist?("#{@root}.pdf")

      base_name = "#{@root}-1"
      base_name = base_name.next while File.exist?("#{base_name}.pdf")
      "#{base_name}.pdf"
    end
  end
end
