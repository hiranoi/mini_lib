class Slide < ActiveRecord::Base

  def self.inquiry_slide_detail(url)
    
    res = OpenSearchClient.new.get_slideshow_by_url(url)
    res_xml = res.elements

	logger.debug("**** res_xml start ****")
    logger.debug(res_xml['//ID'].text)
    logger.debug(res_xml['//Title'].text)
    logger.debug(res_xml['//Description'].text)
    logger.debug(res_xml['//URL'].text)
    logger.debug(res_xml['//ThumbnailURL'].text)
    logger.debug(res_xml['//ThumbnailSmallURL'].text)
    logger.debug(res_xml['//Embed'].text)
    logger.debug("**** res_xml end ****")

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
