class BookCart < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  scope :info_book_author, ->{select :id, :cart_id, :book_id}
end