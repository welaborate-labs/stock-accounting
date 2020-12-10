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

    it { expect(invalid.errors.full_messages).to eq(["Email can't be blank", "Email is invalid", "Message can't be blank", "Message is too short (minimum is 1 character)"]) }
  end
end
