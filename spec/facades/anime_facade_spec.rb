require 'rails_helper'

describe 'anime facade' do
    before :each do
        @your_name = Anime.create!(
            name_engl: 'Your Name',
            name_native: 'ようこそ実力至上主義の教室へ',
            description: 'Your Name description',
            status: 'FINISHED',
            season: 'SUMMER',
            season_year: 2016,
            episodes: 1,
            score: 76,
        )

        @classroom_of_the_elite = Anime.create!(
            name_engl: 'Classroom of the Elite',
            name_native: 'ようこそ実力至上主義の教室へ',
            description: 'Classroom of the Elite description',
            status: 'FINISHED',
            season: 'WINTER',
            season_year: 2018,
            episodes: 12,
            score: 90,
        )
    end

    it 'should return Anime objects when fetching all anime from db' do
        anime_list =  AnimeFacade.fetch_all_db_anime({})

        expect(anime_list.count).to eq(2)
        expect(anime_list[0]).to be_a(Anime)
        expect(anime_list[1]).to be_a(Anime)
    end

    it 'anime_search should return an Anime object and add it to the db' do
        VCR.use_cassette('the_rising_of_the_shield_hero') do
            expect(Anime.all.count).to eq(2)

            anime = AnimeFacade.anime_search('The Rising of the Shield Hero')

            expect(Anime.all.count).to eq(3)
            shield_hero = Anime.last

            expect(anime).to be_a(Anime)
            expect(anime.id).to eq(shield_hero.id)
        end
    end

    it 'anime_search should return Anime object from db if it exists with no anilist api call' do
        @my_hero_academia = Anime.create!(
            name_engl: 'My Hero Academia',
            name_native: 'ようこそ実力至上主義の教室へ',
            description: 'My Hero Academia description',
            status: 'FINISHED',
            season: 'WINTER',
            season_year: 2018,
            episodes: 25,
            score: 89,
        )
        expect(Anime.all.count).to eq(3)

        anime = AnimeFacade.anime_search('My Hero Academia')
        expect(Anime.all.count).to eq(3)

        expect(anime.id).to eq(@my_hero_academia.id)
    end
end