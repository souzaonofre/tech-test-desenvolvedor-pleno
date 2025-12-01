# encoding: utf-8
# frozen_string_literal: true

module MailParser
  require "mail_parser/constants"
  require "mail_parser/eml"

  def self.builder(file_content, file_type = nil)
    unless (file_content.nil? == false) or file_content.instance_of?(String) or ()
      raise ArgumentError.new("Invalid 'file_content' param.")
    end

    raise ArgumentError.new("Exceeded max size limit to 'file_content'.") if file_content.size > Constants::MAX_FILE_CONTENT_SIZE

    file_type = file_type.nil? ? Constants::DEFAULT_FILE_TYPE : file_type
    raise ArgumentError.new("Invalid 'file_type' param.") unless Constants::MAIL_FILE_TYPES.index(file_type) >= 0

    case file_type
    when :eml then Eml.new(file_content)
    end
  end
end
