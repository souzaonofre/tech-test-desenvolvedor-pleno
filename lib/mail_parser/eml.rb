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
      @message.nil? || @message.blank? || @message.headers.blank? || @message.body.parts.blank?
    end

    def message_headers_blank?
      @message.nil? || @message.blank? || @message.headers.blank?
    end

    def message_from
      return nil if message_headers_blank? or @message_headers.from.blank?
      @message_headers.from
    end

    def message_to
      return nil if message_headers_blank? or @message_headers.to.blank?
      @message_headers.to
    end

    def message_subject
      return nil if message_headers_blank? or @message_headers.subject.blank?
      @message_headers.subject
    end
  end
end
