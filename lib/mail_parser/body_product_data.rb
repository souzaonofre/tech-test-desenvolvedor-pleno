require "mail"

module MailParser
  class BodyProductData
    attr_reader @body_stream, :product_data, :product_unparsed_lines, :error_message

    BODY_PRODUCT_KEY_DICT = [
      "produto:",
      "produto de interesse ",
      "interesse no produto ",
      "produto de código ",
      "produto de codigo "
    ]

    SUBJECT_PRODUCT_KEY_DICT = [
      "- produto ",
      "- prod-"
    ]

    def initialize(body_content)
      @body_stream = body_content
      @product_unparsed_lines = []
      @product_data = nil
      @error_message = nil
      scan_body_stream
    end
  end
end
