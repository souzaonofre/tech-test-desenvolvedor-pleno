require "rails_helper"
require "mail"

RSpec.describe "MailParser", type: :class do
  # Global variables
  let(:email_pedido_valido) { File.read(Rails.root.join("spec/fixtures/files/email_pedido_valido.eml")) }
  let(:valid_args_instance) {
    MailParser.builder(file_content: email_pedido_valido, file_type: :eml)
  }

  let(:only_file_content_arg_instance) {
    MailParser.builder(file_content: email_pedido_valido)
  }

  let(:invalid_content_instance) {
    MailParser.builder(file_content: "invalid content", file_type: :eml)
  }

  describe "#builder" do
    it "When has valid args and is instance of MailParser::Eml returns true" do
      expect(valid_args_instance.instance_of?(MailParser::Eml)).to be true
    end
    it "When has only file_content arg. and is instance of MailParser::Eml returns true" do
      expect(only_file_content_arg_instance.instance_of?(MailParser::Eml)).to be true
    end
    it "When is no arguments instance to raise_error" do
      expect { MailParser.builder() }.to raise_error(ArgumentError)
    end
  end
  describe "::Eml" do
    context "#message_parse" do
      it "When is valid file_content and is instance of Mail::Message returns true" do
        msg = valid_args_instance.message_parse
        expect(msg.instance_of?(Mail::Message)).to be true
      end
      it "When instance of Mail::Message has header or body.parts blanl returns false" do
        msg = valid_args_instance.message_parse
        expect(msg.instance_of?(Mail::Message)).to be true
        headers = msg.headers
        body_parts = msg.body.parts
        expect(headers.blank? || body_parts.blank?).to be true
      end
    end
  end
end
