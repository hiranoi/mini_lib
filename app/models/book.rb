class Book < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :isbn, length: { maximum: 13 }

  def self.inquiry_api(isbn)
    require 'net/http'
    require 'uri'
    require 'rexml/document'

    base = 'http://iss.ndl.go.jp/api/opensearch?isbn='
    url = URI.parse(base + isbn.to_s)
    res = Net::HTTP.new(url.host, url.port).get(url)
    res_xml = REXML::Document.new(res.body).elements
  end
end
