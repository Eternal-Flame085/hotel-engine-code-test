class Search < ApplicationRecord
    validates_presence_of :searched_title, :searched_counter
    validates_uniqueness_of :searched_title
end
