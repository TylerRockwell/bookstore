require 'rails_helper'

RSpec.describe CheckoutService do
  before { StripeMock.start }
  after { StripeMock.stop }
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:user) { create(:user) }
  let(:shipping_address) { create(:address) }
  let(:order) { shipping_address.order }
  let(:stripe_token) { stripe_helper.generate_card_token }
  let(:checkout) { CheckoutService.new(user, order, stripe_token) }
  describe "#initialize" do
    it "creates a new CheckoutService object" do
      service = CheckoutService.new(user, order, stripe_token)
      expect(service).to be_a(CheckoutService)
    end
  end

  describe "#place_order" do
    context "when order is valid and everything goes smoothly" do
      it "charges the customer" do
        checkout.place_order do
          expect(checkout).to receive(:charge_customer).with(stripe_token)
        end
      end
      it "empties the cart" do
        checkout.place_order do
          expect(user.cart).to receive(:empty)
        end
      end
      it "finalizes the order" do
        checkout.place_order do
          expect(order).to receive(:change_order_status_to).with("Payment Complete")
        end
      end
      it "sends an invoice to the customer" do
        checkout.place_order do
          expect(OrderMailer).to receive(:invoice).with(order)
        end
      end
    end
    context "when something goes wrong" do
      let(:stripe_token) { "invalid token" }
      it "returns false" do
        expect(checkout.place_order).to eq(false)
      end
      it "does not empty the cart" do
        checkout.place_order do
          expect(user.cart).to_not receive(:empty)
        end
      end
      it "does not finalize the order" do
        checkout.place_order do
          expect(order).to receive(:change_order_status_to).with("Payment Complete")
        end
      end
      it "does not send an invoice to the customer" do
        checkout.place_order do
          expect(OrderMailer).to_not receive(:invoice).with(order)
        end
      end
      # it "does not pass go"
      # it "does not collect $200"
    end
  end

  describe "#retrieve_stripe_customer_id" do
    context "when using a new credit card" do
      it "returns a new customer_id" do
        expect(checkout.send(:retrieve_stripe_customer_id)).to include("test_cus")
      end
    end
    context "when using a stored credit card" do
      let(:stripe_token) { nil }
      it "returns stripe_customer_id from user" do
        expect(checkout.send(:retrieve_stripe_customer_id)).to eq(user.stripe_customer_id)
      end
    end
  end

  describe "#charge_customer(customer_id)" do
    context "when all information is valid" do
      let!(:order_item) { create(:order_item, :complete, order: order) }
      it "returns a Stripe::Charge object" do
        expect(checkout.send(:charge_customer, user.stripe_customer_id)).to be_a(Stripe::Charge)
      end
    end
    context "when invalid data is sent" do
      # order total is 0, which is invalid
      it "returns false" do
        expect(checkout.send(:charge_customer, user.stripe_customer_id)).to eq(false)
      end
    end
  end

  describe "#finalize" do
    let!(:complete_status) { create(:order_status, name: "Payment Complete") }
    it "changes the order status to 'Payment Complete'" do
      checkout.send(:finalize)
      expect(order.order_status_name).to eq("Payment Complete")
    end
  end

  describe "#send_invoice" do
    it "sends an invoice to the customer" do
      checkout.send(:send_invoice) do
        expect(OrderMailer).to receive(:invoice).with(order)
      end
    end
  end
end
