# encoding: utf-8
# frozen_string_literal: true

module MailParser
  require "mail_parser/constants"
  require "mail_parser/eml"

  def self.builder(storage_blob, file_type = nil)
    file_type = file_type.nil? ? Constants::DEFAULT_FILE_TYPE : file_type
    raise ArgumentError.new("Invalid file_type param.") unless Constants::MAIL_FILE_TYPES.index(file_type) >= 0

    case file_type
    when :eml then Eml.new(storage_blob)
    end
  end
end
