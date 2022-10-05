class Contact < ApplicationRecord
  belongs_to :user

  enum process_status: { confirming: 0, responding: 1, finished: 2 }
end
