require 'rails_helper'

RSpec.describe ContactUsForm do
  let(:contact) { build(:contact_us_form) }
  let(:invalid) { build(:contact_us_form, email: nil, message: nil) }
  
  describe "valid attributes" do
    subject { contact }
    it { expect( contact.valid? ).to be true }
  end

  describe "invalid attributes" do
    before { invalid.valid? }

    it { expect(invalid.errors.full_messages).to eq(["Email não pode ficar em branco", "Email não é válido", "Message não pode ficar em branco", "Message é muito curto (mínimo: 1 caracter)"]) }
  end
end
