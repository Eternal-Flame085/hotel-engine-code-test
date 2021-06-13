require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :searched_title }
    it { should validate_presence_of :searched_counter}
    it { should validate_uniqueness_of :searched_title }
  end
end
