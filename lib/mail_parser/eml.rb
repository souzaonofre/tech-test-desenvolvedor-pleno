require "mail"

module MailParser
  class Eml
    attr_reader :storage

    def initialize(file_content)
      @email_content = file_content
    end

    def header_parse
    end
  end
end
