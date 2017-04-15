class Visit
  def self.record_visit!(user, shortened_url)
    Visit.create!(submitter_id: user.id, shortened_url_id: shortened_url.id)
  end
end
