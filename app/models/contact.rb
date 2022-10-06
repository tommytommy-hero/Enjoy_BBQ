class Contact < ApplicationRecord
  belongs_to :user

  enum process_status: { confirming: 0, finished: 1 }
end
