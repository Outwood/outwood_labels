# frozen_string_literal: true

module OutwoodLabels
  class CsvLoader
    include Callable

    # @param [IO]
    # @param template [Template::Base]
    # @param has_headers [Boolean]
    def initialize(io, template, has_headers)
      @io = io
      @template = template
      @has_headers = has_headers
    end

    # @return [CSV]
    # @raise [Error] when no template or headers are given
    def call
      raise Error, "Missing template" unless @template || @has_headers

      return CSV.new(@io, headers: @template.headers) unless @has_headers

      data = CSV.new @io, headers: true, return_headers: true
      data.shift
      data
    end
  end
end
