require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:title)}
  end

  context 'Association' do
    it { should have_many(:products) }
  end
end
