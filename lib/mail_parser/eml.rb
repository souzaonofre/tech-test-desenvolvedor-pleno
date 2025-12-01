require "mail"

module MailParser
  class Eml
    attr_reader :storage

    def initialize(storage_blob = nil)
      unless (storage_blob.nil? == false) or storage_blob.instance_of?(ActiveStorage::Attached::One)
        raise ArgumentError.new("Invalid storage_blob param.")
      end
      @storage = storage_blob
    end
  end
end
