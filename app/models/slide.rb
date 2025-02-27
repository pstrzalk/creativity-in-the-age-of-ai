class Slide < ApplicationRecord
  has_many :parts, dependent: :destroy
end
