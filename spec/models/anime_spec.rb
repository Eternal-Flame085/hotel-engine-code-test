require 'rails_helper'

RSpec.describe Anime, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name_engl }
    it { should validate_presence_of :name_native }
    it { should validate_presence_of :description }
    it { should validate_presence_of :season }
    it { should validate_presence_of :season_year }
    it { should validate_presence_of :score }
    it { should validate_presence_of :episodes }
  end
end
