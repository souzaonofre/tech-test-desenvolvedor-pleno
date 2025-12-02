require "mail"

module MailParser
  class BodyProductData
    attr_reader :body_stream, :subject_line, :product_data, :product_unparsed_lines, :error_message

    BODY_PRODUCT_KEY_DICT = [
      "produto:",
      "produto de interesse ",
      "interesse no produto ",
      "produto de código ",
      "produto de codigo "
    ]

    SUBJECT_DATA_KEY = "subject:"

    SUBJECT_PRODUCT_KEY_DICT = [
      "- produto ",
      "- prod-"
    ]

    def initialize(body_with_subject_content)
      @body_stream = body_with_subject_content
      @product_unparsed_lines = []
      @product_data = nil
      @error_message = nil
      scan_body_stream
    end

    def get_subject_data
    end

    def scan_body_stream
      StringIO.new(@body_stream).each_line do |line|
        # line = strio.gets
        line.chop!.strip!
        unless line.blank?
          unless line.blank? or line.index(":").nil? or (line.index(":") < 3)
            @body_unparsed_lines << line
            parts = line.split(":")
            key = parts[0]
            unless parts.blank? or key.blank? or (parts.size > 2)
              key.downcase!
              key.tr!(" ", "_").tr!("-", "_") unless Mail::Utilities.atom_safe?(key)
              @body_fields << { "#{key}": parts[1].strip! }
            end
          end
        end
      end
    rescue IOError, RuntimeError
      @error_message = "Fail on tray parser 'eml' content type"
      @body_stream = nil
      @body_fields = []
    end
  end
end
