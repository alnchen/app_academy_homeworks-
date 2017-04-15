class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true
  validates :long_url, uniqueness: true

  def self.random_code
    short = SecureRandom::urlsafe_base64
    if ShortenedUrl.exists?(short_url: short)
      self.random_code
    else
      short
    end
  end

  def create_with_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      short_url: ShortenedUrl.random_code,
      long_url: long_url,
      user: user.id
    )
  end

  belongs_to(
    :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: 'User'
  )

  has_many(
    :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: 'Visit',
  )

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.uniq
  end

  def num_recent_uniques
    self.
  end

end
