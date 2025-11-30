require 'rails_helper'

RSpec.describe MailFile::Parser, type: :class do
  # Global variables
  let(:email_pedido_valido) { File.read(Rails.root.join('spec/fixtures/files/email_pedido_valido.eml')) }
  let(:blob_email_pedido_valid) {
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(email_pedido_valido),
      filename: "email_valid.eml",
      content_type: "message/rfc822"
    )
  }
  let(:valid_args_instance) {
    MailFile::Parser.builder(storage_blob: blob_email_pedido_valid, file_type: :eml)
  }
  let(:only_storage_blob_arg_instance) {
    MailFile::Parser.builder(storage_blob: blob_email_pedido_valid)
  }

  describe '#builder' do
    it 'When has valid args and is instance of MailFile::Parser returns true' do
      expect(valid_args_instance.instance_of?(MailFile::Parser)).to be true
    end
    it 'When has only storage_blob arg. and is instance of MailFile::Parser returns true' do
      expect(only_storage_blob_arg_instance.instance_of?(MailFile::Parser)).to be true
    end
    it 'When is no arguments instance to raise_error' do
      expect { MailFile::Parser.builder() }.to raise_error(ArgumentError)
    end
  end
end
