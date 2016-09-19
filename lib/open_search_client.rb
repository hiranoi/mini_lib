require "faraday"
require 'rexml/document'

# open_search_client.rb
class OpenSearchClient

  URL_HEAD = 'http://iss.ndl.go.jp'

  def get_book_info_by_isbn(isbn)
    response = get('/api/opensearch', {:isbn => isbn})
    res_xml = REXML::Document.new(response.body)
  end

  private

  def get(path, pram)
    con = Faraday.new(:url => URL_HEAD) do |f|
      f.request  :url_encoded
      f.response :logger
      f.adapter  Faraday.default_adapter
    end
    con.get path, pram # GET http://iss.ndl.go.jp/api/opensearch?isbn=9784774163666
  end
end
