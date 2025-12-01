require "mail"

module MailParser
  class Eml
    attr_reader :email_content, :message_header_fields, :error_message

    def initialize(file_content)
      @email_content = file_content
      @message_header_fields = nil
      @error_message = nil
    end

    def message_parse
      msg = Mail.new(@email_content)
      @message_header_fields = msg.header_fields
    rescue Mail::Field::NilParseError, Mail::Field::ParseError
      @error_message = "Fail on tray parser 'eml' content type"
      @message_header_fields = nil
    end

    def message_header_fields
      return nil if @message_header_fields.nil? or not @message_header_fields.instance_of?(Mail::FieldList)
      @message_header_fields
    end

    def message_from
      return nil if message_header_fields.nil?
      @message_header_fields.from
    end
  end
end
