class ShortenedUrl < ActiveRecord::Base

  validates :long_url, :short_url, :creator_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to(
    :creator,
    class_name: 'User',
    foreign_key: :creator_id,
    primary_key: :id
  )

  has_many :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :visitors,
    through: :visits,
    source: :visitor

  def self.random_code
    code = SecureRandom::urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64(16)
    end
    code
  end

  def self.create_code!(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      creator_id: user.id
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits
      .select("user_id")
      .where("created_at > ?", 10.minutes.ago)
      .distinct
      .count
  end


end
