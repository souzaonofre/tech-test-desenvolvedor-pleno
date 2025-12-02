require "mail"

module MailParser
  class Eml
    attr_reader :email_content, :message, :message_body, :error_message

    def initialize(file_content)
      @email_content = file_content
      @error_message = nil
      @message_body = nil
      load_message!
    end

    def load_message!
      @message = Mail.new(@email_content)
    rescue Mail::Field::NilParseError, Mail::Field::ParseError
      @error_message = "Fail on tray parser 'eml' content type"
      @message = nil
      @message_body = nil
    end

    def message_blank?
      @message.nil? || @message.blank? || @message.header_fields.blank? || @message.body.raw_source.blank?
    end

    def message_from
      return nil if message_blank? or @message.from.blank?
      @message.from.first
    end

    def message_to
      return nil if message_blank? or @message.to.blank?
      @message.to.first
    end

    def message_subject
      return nil if message_blank? or @message.subject.blank?
      @message.subject
    end

    def message_body
      return nil if message_blank? or @message.body.blank? or @message.body.raw_source.blank?
      @message.body.raw_source
    end

    def has_valid_data?
      (message_from.nil? or message_to.nil? or message_subject.nil? or message_body.nil?) ? false : true
    end

    def to_s
      "\nFrom: #{message_from}\nTo: #{message_to}\nSubject: #{message_subject}\n\nBody:\n#{message_body}\n:EndBody\n\n"
    end

    def to_h
      {
        from: message_from,
        to: message_to,
        subject: message_subject,
        body: message_body
      }
    end
  end
end
