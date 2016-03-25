class Book < ActiveRecord::Base
  belongs_to :user

  def self.inquiry_api(isbn)
    require 'net/http'
    require 'uri'
    require 'rexml/document'

    base = 'http://iss.ndl.go.jp/api/opensearch?isbn='
    url = URI.parse(base + isbn.to_s)
    res = Net::HTTP.new(url.host, url.port, 'proxy.cmn.mdx', 1088, 'hiranoi', 'Ivers0n33').get(url)
    REXML::Document.new(res.body).elements
  end
end
