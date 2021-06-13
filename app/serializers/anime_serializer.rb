class AnimeSerializer
    include JSONAPI::Serializer

    attribute :name_engl, :name_native, :description, :episodes, :season, :season_year, :status, :score
end