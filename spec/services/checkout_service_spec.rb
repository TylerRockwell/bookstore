require 'rails_helper'

RSpec.describe CheckoutService do
  let!(:user) { create(:user) }
  let!(:order) { create(:order) }
  let!(:stripe_token) { "cus_7tDRQQS0nrwl9A" }

  describe "#initialize" do
    it "creates a new CheckoutService object" do
      service = CheckoutService.new(user, order, stripe_token)
      expect(service).to be_a(CheckoutService)
    end
  end
end
