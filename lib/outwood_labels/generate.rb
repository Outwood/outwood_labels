# frozen_string_literal: true

require 'csv'
require 'prawn/label_sheet'

module OutwoodLabels
  class Generate
    include Callable

    # @param data [CSV]
    # @param outfile [String]
    # @param template [OutwoodLabels::Template::Base]
    def initialize(data, outfile, template, config = {})
      @config = config
      @data = data
      @outfile = outfile
      @template = template
    end

    # Generate PDF and write to disk
    # @raise [Error] when required columns are missing
    def call
      check_header if @template
      config = @config.merge({ layout: @template.layout })
      labels = Prawn::LabelSheet.new @data, **config, &@template.method(:evaluate)
      labels.document.render_file(@outfile)
    end

    private

    def check_header
      return if @template.valid_for?(@data.headers)

      raise Error, "Required columns: #{@template.columns.join(',')}"
    end
  end
end
