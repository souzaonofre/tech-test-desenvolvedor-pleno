require "rails_helper"
require "mail"

RSpec.describe "MailParser", type: :class do
  # Global variables
  let(:email_pedido_valido) { File.read(Rails.root.join("spec/fixtures/files/email_pedido_valido.eml")) }
  let(:valid_content_instance) {
    MailParser.builder(email_pedido_valido, :eml)
  }

  let(:only_file_content_arg_instance) {
    MailParser.builder(email_pedido_valido)
  }

  let(:invalid_content_instance) {
    MailParser.builder("invalid content", :eml)
  }

  describe "#builder" do
    it "When has valid args and is instance of MailParser::Eml returns true" do
      expect(valid_content_instance.instance_of?(MailParser::Eml)).to be true
    end
    it "When has only file_content arg. and is instance of MailParser::Eml returns true" do
      expect(only_file_content_arg_instance.instance_of?(MailParser::Eml)).to be true
    end
    it "When is no arguments instance to raise_error" do
      expect { MailParser.builder() }.to raise_error(ArgumentError)
    end
  end
  describe "::Eml" do
    context "#message" do
      it "When is valid_content_instance and #message is Mail::Message returns true" do
        message = valid_content_instance.message
        expect(message.instance_of?(Mail::Message)).to be true
      end
      it "When is valid_content_instance and '#message_blank?' returns false" do
        expect(valid_content_instance.message_blank?).to be false
      end
      it "When is valid_content_instance and '#has_valid_data?' returns true" do
        expect(valid_content_instance.has_valid_data?).to be true
      end
      it "When is valid_content_instance and '#respond_to?(to_s) returns true" do
        expect(valid_content_instance.respond_to?("to_s")).to be true
      end
      it "When is valid_content_instance and '#respond_to?(to_h) returns true" do
        expect(valid_content_instance.respond_to?("to_h")).to be true
      end
    end
    context "#message_blank?" do
      it "When is invalid_content_instance and '#message_blank?' returns true" do
        expect(invalid_content_instance.message_blank?).to be true
      end
    end
  end
end
