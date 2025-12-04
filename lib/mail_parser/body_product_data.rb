require "mail"

module MailParser
  class BodyProductData
    attr_reader :body_stream, :subject_product, :body_product, :product_unparsed_lines, :error_message

    BODY_PRODUCT_KEY_DICT = [
      "produto:",
      "produto de interesse ",
      "interesse no produto ",
      "produto de código ",
      "produto de codigo "
    ]

    SUBJECT_DATA_KEY = "subject:"

    SUBJECT_PRODUCT_KEY_DICT = [
      "- Produto ",
      "- PROD-"
    ]

    def initialize(body_with_subject_content)
      @body_stream = body_with_subject_content
      @product_unparsed_lines = []
      @body_product = nil
      @error_message = nil
      @subject_product = nil
      scan_subject_product!
    end

    def parse_subject_product(subject_data)
      return if subject_data.nil?
      subject_data = String(subject_data)
      SUBJECT_PRODUCT_KEY_DICT.each do |pattern|
        pattern = String(pattern)
        # debugger
        pos = subject_data.index(pattern)
        unless pos.nil?
          pos += pattern.size
          @subject_product = subject_data.slice(pos, subject_data.size) unless pos.nil?
        end
      end
    end

    def scan_subject_product!
      StringIO.new(@body_stream).each_line do |line|
        line.chop!.strip!
        rcd = Utils.basic_record_parser(line, ":")
        unless rcd.nil? or (rcd.keys.size == 0) or (rcd.values.size == 0) or (String(rcd.keys[0]) != "subject")
          @product_unparsed_lines << line
          subject_data = String(rcd.values[0]).strip
          parse_subject_product(subject_data)
        end
      end
    end

    # def scan_body_stream
    #   StringIO.new(@body_stream).each_line do |line|
    #     line.chop!.strip!
    #     unless line.blank? or line.index(":").nil? or (line.index(":") < 3)
    #       @body_unparsed_lines << line
    #       parts = line.split(":")
    #       unless parts.blank? or parts[0].blank? or (parts.size > 2)
    #         key = String(parts[0]).downcase
    #         key.tr!(" ", "_").tr!("-", "_") unless Mail::Utilities.atom_safe?(key)
    #         @body_fields << { "#{key}": String(parts[1]).strip }
    #       end
    #     end
    #   end
    # rescue IOError, RuntimeError
    #   @error_message = "Fail on tray parser 'eml' content type"
    #   @body_stream = nil
    #   @body_fields = []
    # end
  end

  def to_s
    "product_unparsed_lines: #{@product_unparsed_lines}\n subject_product: #{@subject_product}"
  end
end
