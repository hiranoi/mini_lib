require 'nokogiri'

class Slide < ActiveRecord::Base

  def self.inquiry_slide_detail(url)
    
    res = OpenSearchClient.new.get_slideshow_by_url(url)
    res_xml = res.elements

    slide = Slide.new()

    slide.slide_id = res_xml['//ID'].text
    slide.title = res_xml['//Title'].text
    slide.url = res_xml['//URL'].text
    slide.thumbnail_url = res_xml['//ThumbnailURL'].text
    slide.embed = res_xml['//Embed'].text

    logger.debug("**** res_xml start ****")
    logger.debug(slide.slide_id)
    logger.debug(slide.title)
    logger.debug(slide.url)
    logger.debug(slide.thumbnail_url)
    logger.debug(slide.embed)
    logger.debug("**** res_xml end ****")

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
