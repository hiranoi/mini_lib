class Book < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :rent_histories

  validates :isbn, length: { maximum: 13 }
  validates :title, presence: true

  def self.inquiry_api(book)
    unless book.isbn.to_s.length == 10 || book.isbn.to_s.length == 13
      return nil
    end
    
    res = OpenSearchClient.new.get_book_info_by_isbn(book.isbn)
    res_xml = res.elements

    book.title     = res_xml['//rss/channel/item/title'].text
    book.author    = res_xml['//rss/channel/item/author'].text.chop
    book.publisher = res_xml['//rss/channel/item/dc:publisher'].text

    # 次巻がある場合はtitleに追加する
    if res.elements['//rss/channel/item/dcndl:volume'] != nil
      book.title += " " + res.elements['//rss/channel/item/dcndl:volume'].text
    end

    book
  end
end
