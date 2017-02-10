class ShortenedUrl < ActiveRecord::Base

  validates :long_url, :short_url, :creator_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to(
    :creator,
    class_name: 'User',
    foreign_key: :creator_id,
    primary_key: :id
  )

  def self.random_code
    code = SecureRandom::urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64(16)
    end
    code
  end

  def self.create_code(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      creator_id: user.id
    )
  end
end
