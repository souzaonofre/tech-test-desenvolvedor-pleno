# encoding: utf-8
# frozen_string_literal: true

module MailParser
  require "mail_parser/constants"
  require "mail_parser/eml"

  def self.builder(content_text, content_type = nil)
    unless (content_text.nil? == false) or content_text.instance_of?(String) or (content_text.blank? == false)
      raise ArgumentError.new("Invalid 'content_text' param.")
    end

    raise ArgumentError.new("Exceeded max size limit to 'content_text'.") if content_text.size > Constants::MAX_content_text_SIZE

    content_type = content_type.nil? ? Constants::DEFAULT_content_type : content_type
    raise ArgumentError.new("Invalid 'content_type' param.") unless Constants::MAIL_content_typeS.index(content_type) >= 0

    case content_type
    when :eml then Eml.new(content_text)
    when :body then body.new(content_text)
    else
      nil
    end
  end
end
