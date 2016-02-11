require 'rails_helper'

RSpec.describe CheckoutService do
  let(:user) { create(:user) }
  let(:order) { create(:order) }
  let(:stripe_token) { "tok_7tDRQQS0nrwl9A" }
  let(:checkout) { CheckoutService.new(user, order, stripe_token) }
  describe "#initialize" do
    it "creates a new CheckoutService object" do
      service = CheckoutService.new(user, order, stripe_token)
      expect(service).to be_a(CheckoutService)
    end
  end

  describe "#retrieve_stripe_customer_id" do
    context "when using a stored credit card" do
      it "returns stripe_customer_id from user" do
        expect(checkout.send(retrieve_stripe_customer_id)).to eq(user.stripe_customer_id)
      end
    end
  end
end
