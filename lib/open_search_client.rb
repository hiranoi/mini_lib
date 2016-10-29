require 'faraday'
require 'rexml/document'

# open_search_client.rb
class OpenSearchClient

  def get_book_info_by_isbn(isbn)
    response = get('http://iss.ndl.go.jp','/api/opensearch', {:isbn => isbn})
    res_xml = REXML::Document.new(response.body)
  end

  def get_slideshow_by_url(url)

    api_key = "BXUZhtwB"
    secret_key = "zIZsdVoU"
    now_time = Time.now.to_i
    hash = Digest::SHA1.hexdigest("#{secret_key}#{now_time}")

    pram = {
      :api_key => api_key,
      :ts => now_time,
      :hash => hash,
      :slideshow_url => url
    }

    response = get('https://www.slideshare.net', '/api/2/get_slideshow', pram)
    res_xml = REXML::Document.new(response.body)
  end

  private

  def get(domain, path, pram)
    con = Faraday.new(:url => domain) do |f|
      f.request  :url_encoded
      f.response :logger
      f.adapter  Faraday.default_adapter
    end
    con.get path, pram # GET http://iss.ndl.go.jp/api/opensearch?isbn=9784774163666
  end
end
