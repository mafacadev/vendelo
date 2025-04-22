class Product < ApplicationRecord
  before_validation :format_price
  validates :title, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }
  has_one_attached :photo

  enum status: { active: 1, inactive: 0 }

  private

  def format_price
    # Redondea el precio a dos decimales si está presente
    self.price = price.round(2) if price.present?
  end
end
