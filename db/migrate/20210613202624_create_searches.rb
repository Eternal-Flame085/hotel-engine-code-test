class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :searched_title, unique: true
      t.integer :searched_counter, default: 1

      t.timestamps
    end
  end
end
