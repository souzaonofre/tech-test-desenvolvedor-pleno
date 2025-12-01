require "rails_helper"

RSpec.describe "MailParser", type: :class do
  # Global variables
  let(:email_pedido_valido) { File.read(Rails.root.join("spec/fixtures/files/email_pedido_valido.eml")) }
  let(:valid_args_instance) {
    MailParser.builder(file_content: email_pedido_valido, file_type: :eml)
  }
  let(:only_file_content_arg_instance) {
    MailParser.builder(file_content: email_pedido_valido)
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
end
