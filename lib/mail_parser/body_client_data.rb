require "mail"

module MailParser
  class BodyClientData
    attr_reader :body_stream, :body_fields, :body_unparsed_lines, :error_message

    CLIENT_DATA_KEY_DICT = [
      { nome_do_cliente: [ "nome do cliente", "nome cliente", "nome completo", "nome", "cliente" ] },
      { email_do_cliente: [ "e-mail do cliente", "email do cliente", "e-mail cliente", "email cliente", "e-mail", "email" ] },
      { telefone_do_cliente: [ "telefone", "fone", "tel", "celular", "cel" ] }
    ]

    def initialize(body_content)
      @body_stream = body_content
      @body_fields = []
      @body_unparsed_lines = []
      @error_message = nil
      scan_body_stream
    end

    def tr_key_by_dict(search_name)
      found = search_name
      CLIENT_DATA_KEY_DICT.each do |tr_data|
        list = tr_data.values[0]
        found = tr_data.keys[0] unless list.index(search_name).nil?
      end
      found.to_s
    end

    def scan_body_stream
      StringIO.new(@body_stream).each_line do |line|
        # clean line break and spaces
        line.chop!.strip!
        # check current is valid and have field record
        unless line.blank? or line.index(":").nil? or (line.index(":") < 3)
          # save raw field record data
          @body_unparsed_lines << line
          # split key and value side of record
          parts = line.split(":")
          # verify if have valid parts of key->value record
          unless parts.blank? or parts[0].blank? or (parts.size > 2)
            # down case key chars
            key = String(parts[0]).downcase
            # normalize key name to valid identifier atom rule, like a slug
            key.tr!(" ", "_").tr!("-", "_") unless Mail::Utilities.atom_safe?(key)
            # search and translate dict key names to default identifier
            new_key = tr_key_by_dict(key)
            # save normalized field found
            @body_fields << { "#{new_key}": String(parts[1]).strip } unless new_key.nil?
          end
        end
      end
    rescue IOError, RuntimeError
      @error_message = "Fail on tray parser 'eml' content type"
      @body_stream = nil
      @body_fields = []
    end

    def to_s
      "\nUnparsed_lines: #{@body_unparsed_lines}\nBody_fields: #{@body_fields}\n"
    end

    def to_h
      out = {}
      @body_fields.each do |it|
        out.merge(it)
      end
    end
  end
end
