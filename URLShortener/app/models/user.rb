class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  has_many :urls,
    class_name: "ShortenedUrl",
    foreign_key: :creator_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :user_id,
    primary_key: :id

  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_url


end
