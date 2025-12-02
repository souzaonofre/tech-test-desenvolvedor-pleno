module MailParser
  module Constants
    MAX_FILE_CONTENT_SIZE = 1024 # bytes
    CONTENT_PARSER_TYPES = [ :eml, :body_client, :body_subject_product ]
    DEFAULT_FILE_TYPE = :eml
  end
end
