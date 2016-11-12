class Slide < ActiveRecord::Base

  def self.inquiry_slide_detail(url)

    res = OpenSearchClient.new.get_slideshow_by_url(url)
    res_hash = Hash.from_xml(res.elements['//Slideshow'].to_s)

    slide = parseFromHash(res_hash.fetch("Slideshow"))

    slide
  end

  def self.inquiry_slide_list(word)
    slides = Array.new

    # スライド検索API
    res = OpenSearchClient.new.get_slideshow_by_word(word)
    res_hash = Hash.from_xml(res.elements['//Slideshows'].to_s)
    slideshows_hash = res_hash.fetch("Slideshows")

    # 0件チェック
    if slideshows_hash.fetch("Meta").fetch("TotalResults").to_i == 0
        return slides
    end

    # スライド情報の詰め替え
    slideshows_hash.fetch("Slideshow").each do |slide|
      slides.push(parseFromHash(slide))
    end

    slides
  end

  def self.parseFromHash(hash)
    slide = Slide.new()
    
    slide.slide_id = hash.fetch("ID")
    slide.title = hash.fetch("Title")
    slide.url = hash.fetch("URL")
    slide.thumbnail_url = hash.fetch("ThumbnailURL")
    slide.embed = hash.fetch("Embed")

    slide
  end

end
