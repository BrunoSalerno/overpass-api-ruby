require_relative "base"

module OverpassAPI
  class QL < Base
    def build_query(q)
      header = ""
      header << "[bbox:#{@bbox}]" if @bbox
      header << "[timeout:#{@timeout}]" if @timeout
      header << "[maxsize:#{@maxsize}]" if @maxsize

      header << "[out:json]"

      "#{header};#{q}"
    end
  end
end