class ImportedFile < ApplicationRecord
    has_one_attached :file
    validates :file, :file_hash, presence: true
end
