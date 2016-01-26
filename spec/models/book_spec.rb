require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:published_date) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:price) }

  end
end
