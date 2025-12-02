require "mail"

module MailParser
  class Body
    attr_reader :body_stream, :body_fields, :error_message

    def initialize(body_content)
      @body_stream = body_content
      @body_fields = []
      @error_message = nil
      scan_body_stream!
    end

    def scan_body_stream!
      StringIO.open(@body_stream) do |line|
        line = line.chop!.strip!.downcase!
        next! if line.blank? or line.index(":") < 3
        parts = line.split(":")
        next! if parts.blank? or String(parts[0]).blank? or parts.size > 2
        key = String(parts[0]).tr!(" ", "_")
        @body_fields << { "#{key}": String(parts[1]).strip! }
      end
    rescue IOError, RuntimeError
      @error_message = "Fail on tray parser 'eml' content type"
      @body_stream = nil
      @body_fields = []
    end
  end
end
