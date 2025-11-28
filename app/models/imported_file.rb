class ImportedFile < ApplicationRecord
    has_one_attached :upload_file
end
