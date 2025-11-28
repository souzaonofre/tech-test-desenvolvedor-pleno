class ImportedFile < ApplicationRecord
    has_one_attached :upload_file
    validates :upload_file, presence: true
end
