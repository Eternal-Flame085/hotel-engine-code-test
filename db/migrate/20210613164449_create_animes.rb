class CreateAnimes < ActiveRecord::Migration[6.1]
  def change
    create_table :animes do |t|
      t.string :name_engl, unique: true
      t.string :name_native
      t.string :description
      t.string :status
      t.string :season
      t.integer :season_year
      t.integer :episodes
      t.integer :score

      t.timestamps
    end
  end
end
