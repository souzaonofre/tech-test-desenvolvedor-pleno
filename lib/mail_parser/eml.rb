require "mail"

module MailParser
  class Eml
    attr_reader :email_content, :message, :message_headers, :message_body, :error_message

    def initialize(file_content)
      @email_content = file_content
      @error_message = nil
      @message = Mail.new(@email_content)
      @message_headers = @message.headers
      @message_body = @message.body
    rescue Mail::Field::NilParseError, Mail::Field::ParseError
      @error_message = "Fail on tray parser 'eml' content type"
      @message = nil
      @message_headers = nil
      @message_body = nil
    end

    def message_blank?
      @message.nil? || @message.blank? || @message.header_fields.blank? || @message.body.raw_source.blank?
    end

    def message_from
      return nil if message.from.blank?
      @message.from.first
    end

    def message_to
      return nil if message.to.blank?
      @message.to.first
    end

    def message_subject
      return nil if mssage.subject.blank?
      @message.subject
    end
  end
end
