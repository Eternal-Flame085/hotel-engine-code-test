class Anime < ApplicationRecord
    validates :name_engl, presence: true, :uniqueness => { :case_insensitive => true}  
    validates :name_native, :description, :status, :season, :season_year, :episodes, :score, presence: true
end
