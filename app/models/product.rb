class Product < ApplicationRecord
  #extend first
  extend Enumerize
  #Associations
  belongs_to :category, optional: true
  #Validatation
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  #Custom Validations
  validate :title_is_shorter_than_description
  before_save :strip_html_from_description
  before_save :lower_title

  scope :published, -> { where(published: true) }
  scope :priced_more_than, ->(price) { where('price > ?', price) }
  #Define Custom Validations methods
  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  def lower_title
    self.title = title.downcase
  end

  def title_is_shorter_than_description
    if title.present? && description.present? && title.length > description.length
      errors.add(:title, 'Title must be shorter than description!')
    end
  end

  enumerize :level, in: { easy: 1, medium: 2, hard: 3 }
  enumerize :country, in: ISO3166::Country.translations.invert
end
