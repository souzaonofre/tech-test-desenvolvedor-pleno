require "rails_helper"

RSpec.describe MailImport, type: :class do
  let(:email_pedido_valido) { File.read(Rails.root.join("spec/fixtures/files/email_pedido_valido.eml")) }
  let(:blob_email_pedido_valid) {
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(email_pedido_valido),
      filename: "email_valid.eml",
      content_type: "message/rfc822",
    )
  }
end
