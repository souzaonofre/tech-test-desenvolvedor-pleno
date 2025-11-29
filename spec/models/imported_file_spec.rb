require 'rails_helper'

RSpec.describe ImportedFile, type: :model do
  # Global variables
  let(:email_pedido_valido) { File.read(Rails.root.join('spec/fixtures/files/email_pedido_valido.eml')) }
  let(:blob_email_pedido_valid) {
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(email_pedido_valido),
      filename: "email_valid.eml",
      content_type: "message/rfc822"
    )
  }
  let(:valid_instance) {
    ImportedFile.new(file: blob_email_pedido_valid, file_hash: blob_email_pedido_valid.key)
  }
  let(:void_instance) {
    ImportedFile.new()
  }
  let(:blob_blank_email_content) {
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(''),
      filename: "blank_email.eml",
      content_type: "text/plain"
    )
  }
  let(:blank_email_instance) {
    ImportedFile.new(file: blob_blank_email_content, file_hash: blob_blank_email_content.key)
  }

  describe '#instance_of?' do
    it 'When imported_file object is instance of ImportedFile returns true' do
      imported_file = ImportedFile.new(file: blob_email_pedido_valid, file_hash: blob_email_pedido_valid.key)
      expect(imported_file.instance_of?(ImportedFile)).to be true
    end
  end

  describe '#file' do
    context '#attached?' do
      it 'has file attached returns true' do
        expect(valid_instance.file.attached?).to be true
      end
      it 'not has file attached returns false' do
        expect(void_instance.file.attached?).to be false
      end
    end
    context '#open' do
      it 'file content is same of source file' do
        # read file content
        content = valid_instance.file.open { |f| f.read }
        expect(content).to eq(email_pedido_valido)
      end
      it 'file content is blank string' do
        # read file content
        content = blank_email_instance.file.open { |f| f.read }
        expect(content).to eq('')
      end
    end
  end
end
