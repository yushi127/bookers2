class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book,optional: true
  validates :user_id, uniqueness: { scope: :book_id }
end
