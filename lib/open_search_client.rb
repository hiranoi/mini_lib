require 'faraday'
require 'rexml/document'

# open_search_client.rb
class OpenSearchClient

  SLIDESHARE_DOMAIN = "https://www.slideshare.net"

  def get_book_info_by_isbn(isbn)
    response = get('http://iss.ndl.go.jp','/api/opensearch', {:isbn => isbn})
    res_xml = REXML::Document.new(response.body)
  end

  def get_slideshow_by_url(url)

    now_time = Time.now.to_i
    hash = Digest::SHA1.hexdigest("#{ENV['SLIDESHARE_SECRET_KEY']}#{now_time}")

    pram = {
      :api_key => ENV['SLIDESHARE_API_KEY'],
      :ts => now_time,
      :hash => hash,
      :slideshow_url => url
    }

    response = get(SLIDESHARE_DOMAIN, '/api/2/get_slideshow', pram)
    res_xml = REXML::Document.new(response.body)
  end

  def get_slideshow_by_word(word)

    now_time = Time.now.to_i
    hash = Digest::SHA1.hexdigest("#{ENV['SLIDESHARE_SECRET_KEY']}#{now_time}")

    pram = {
      :api_key => ENV['SLIDESHARE_API_KEY'],
      :ts => now_time,
      :hash => hash,
      :q => word,
      :lang => 'ja',
      :sort => 'mostviewed',
      :file_type => 'presentations',
      :detailed => '0'
    }

    response = get(SLIDESHARE_DOMAIN, '/api/2/search_slideshows', pram)
    res_xml = REXML::Document.new(response.body)
  end

  def send_push(title, body)

    pram = {
        :title => title,
        :body => body,
        :icon => 'https://dashboard.push7.jp/uploads/b620a8a9979d498aa3de16cab4ac34e2.png',
        :url => 'http://dev01jaqlib.herokuapp.com/',
        :apikey => ENV['PUSH7_API_KEY']
    }

    response = post('https://api.push7.jp', '/api/v1/6633be7a3c4d46628d47460d401d9737/send', pram)
  end


  private

  def get(domain, path, pram)
    con = Faraday.new(:url => domain) do |f|
      f.request  :url_encoded
      f.response :logger
      f.adapter  Faraday.default_adapter
    end
    con.get path, pram
  end

  def post(domain, path, pram)
    con = Faraday.new(:url => domain) do |f|
      f.request  :url_encoded
      f.response :logger
      f.adapter  Faraday.default_adapter
    end
    con.post do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.body = pram.to_json
    end
  end
end
