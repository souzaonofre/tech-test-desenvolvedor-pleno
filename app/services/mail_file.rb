# encoding: utf-8
# frozen_string_literal: true

module MailFile
    MAIL_FILE_TYPES = [ :eml ]

    class Parser
      attr_reader :storage, :file_type

        def initialize(storage_blob = nil, file_type = nil)
            unless (storage_blob.nil? == false) or storage_blob.instance_of?(ActiveStorage::Attached::One)
              raise ArgumentError.new("Invalid storage_blob param.")
            end
            @storage = storage_blob
            @file_type = file_type.nil? ? :eml : file_type
            raise ArgumentError.new("Invalid file_type param.") unless MailFile::MAIL_FILE_TYPES.index(@file_type) >= 0
        end


        class << self
            def builder(storage_blob, file_type = nil)
                new(storage_blob, file_type)
            end
        end
    end
end
