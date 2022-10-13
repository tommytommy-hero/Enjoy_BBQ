class Contact < ApplicationRecord
  belongs_to :user

  validates :content, length: { maximum: 300 }, presence: true

  enum process_status: { confirming: 0, finished: 1 }
end
