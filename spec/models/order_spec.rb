require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:order_status) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:order_items) }

  describe "#update_total" do

  end
end
