class CreateShortenedUrLs < ActiveRecord::Migration[5.0]
  def change
    create_table :shortened_urls do |t|
      t.string :short_url, :null => false
      t.string :long_url, :null => false
      t.integer :submitter_id, :null => false
      t.timestamps
    end
  end
end
