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
    
    res = OpenSearchClient.new.get_slideshow_by_word(word)
    res_xml = res.elements

    logger.debug("**** res_xml start ****")
    logger.debug(res_xml['//Meta/Query'].text)
    logger.debug(res_xml['//Meta/NumResults'].text)
    logger.debug("**** res_xml end ****")
  end

end
