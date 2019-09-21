<<<<<<< HEAD
<<<<<<< HEAD
class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces
  validates :username, presence: true, length: { minimum: 4, maximun: 10 }
=======
class Game < Board < ApplicationRecord
  belongs_to :user
  has_many :pieces

  validates :name, presence: true
>>>>>>> 6d0cfcb939150325807db57d6c09403f60bc8f89

end
=======
# frozen_string_literal: true

class Game < Board < ApplicationRecord
  belongs_to :user
  has_many :pieces

  validates :name, presence: true
end
>>>>>>> 1284bebaef62edf7c164123120eaba13241d1a65
