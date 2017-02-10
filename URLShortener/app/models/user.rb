class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  has_many :urls,
    class_name: "ShortenedUrl",
    foreign_key: :creator_id,
    primary_key: :id

end
