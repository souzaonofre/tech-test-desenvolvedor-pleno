# encoding: utf-8
# frozen_string_literal: true

module MailParser
  require "mail_parser/constants"
  require "mail_parser/base"

  def self.builder(storage_blob, file_type = nil)
    Base.new(storage_blob, file_type)
  end
end
