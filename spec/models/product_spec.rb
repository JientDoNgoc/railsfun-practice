require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:all) do
    @product = Product.create(title: 'Title', description: '<p>This is description</p>', price: 12)
  end

  context 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).
      is_greater_than_or_equal_to(0)}

    it 'lower title' do
      expect(@product.title).to eq 'title'
    end

    it 'strip html from description' do
      expect(@product.description).to eq 'This is description'
    end

    it 'title is shorter than description' do
      @product.title = 'This title is longer than <p>This is description</p>'
      expect(@product.save).to eq false
    end
  end

  context 'Association' do
    it { should belong_to(:category) }
  end
end
