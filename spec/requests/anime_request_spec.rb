require 'rails_helper'

describe 'fetching anime already in db' do
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

        @one_piece = Anime.create!(
            name_engl: 'One Piece',
            name_native: 'ようこそ実力至上主義の教室へ',
            description: 'One Piece description',
            status: 'FINISHED',
            season: 'SUMMER',
            season_year: 2000,
            episodes: 900,
            score: 86,
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

    it 'should return all anime in the db sorts by default by name_engl asc' do
        get '/api/v1/anime'

        expect(response).to be_successful
        anime_list = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(anime_list.first[:attributes][:name_engl]).to eq(@classroom_of_the_elite.name_engl)
        expect(anime_list.first[:attributes][:name_native]).to eq(@classroom_of_the_elite.name_native)
        expect(anime_list.first[:attributes][:description]).to eq(@classroom_of_the_elite.description)
        expect(anime_list.first[:attributes][:season]).to eq(@classroom_of_the_elite.season)
        expect(anime_list.first[:attributes][:season_year]).to eq(@classroom_of_the_elite.season_year)
        expect(anime_list.first[:attributes][:episodes]).to eq(@classroom_of_the_elite.episodes)
        expect(anime_list.first[:attributes][:score]).to eq(@classroom_of_the_elite.score)

        expect(anime_list[1][:attributes][:name_engl]).to eq(@one_piece.name_engl)
        expect(anime_list[1][:attributes][:name_native]).to eq(@one_piece.name_native)
        expect(anime_list[1][:attributes][:description]).to eq(@one_piece.description)
        expect(anime_list[1][:attributes][:season]).to eq(@one_piece.season)
        expect(anime_list[1][:attributes][:season_year]).to eq(@one_piece.season_year)
        expect(anime_list[1][:attributes][:episodes]).to eq(@one_piece.episodes)
        expect(anime_list[1][:attributes][:score]).to eq(@one_piece.score)
        
        expect(anime_list.last[:attributes][:name_engl]).to eq(@your_name.name_engl)
        expect(anime_list.last[:attributes][:name_native]).to eq(@your_name.name_native)
        expect(anime_list.last[:attributes][:description]).to eq(@your_name.description)
        expect(anime_list.last[:attributes][:season]).to eq(@your_name.season)
        expect(anime_list.last[:attributes][:season_year]).to eq(@your_name.season_year)
        expect(anime_list.last[:attributes][:episodes]).to eq(@your_name.episodes)
        expect(anime_list.last[:attributes][:score]).to eq(@your_name.score)
    end

    it 'should return anime ordered by year in desc order' do
        get '/api/v1/anime?sort=season_year desc'

        expect(response).to be_successful
        anime_list = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(anime_list.first[:attributes][:season_year]).to eq(@classroom_of_the_elite.season_year)
        expect(anime_list.last[:attributes][:season_year]).to eq(@one_piece.season_year)
    end

    it 'should only return anime from a specified year' do
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

        get '/api/v1/anime?year_filter=2018'

        expect(response).to be_successful
        anime_list = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(anime_list.count).to eq(2)

        expect(anime_list.first[:attributes][:name_engl]).to eq(@classroom_of_the_elite.name_engl)
        expect(anime_list.last[:attributes][:name_engl]).to eq(@my_hero_academia.name_engl)
    end

    it 'should only return anime by a specified season' do
        get '/api/v1/anime?season_filter=SUMMER'

        expect(response).to be_successful
        anime_list = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(anime_list.count).to eq(2)

        expect(anime_list.first[:attributes][:name_engl]).to eq(@one_piece.name_engl)
        expect(anime_list.last[:attributes][:name_engl]).to eq(@your_name.name_engl)
    end

    it 'should only return anime by a specified season workes with lowecase' do
        get '/api/v1/anime?season_filter=summer'

        expect(response).to be_successful
        anime_list = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(anime_list.count).to eq(2)

        expect(anime_list.first[:attributes][:name_engl]).to eq(@one_piece.name_engl)
        expect(anime_list.last[:attributes][:name_engl]).to eq(@your_name.name_engl)
    end

    it 'should return an anime from the db by id' do
        get "/api/v1/anime/#{@classroom_of_the_elite.id}"

        expect(response).to be_successful

        anime = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

        expect(anime).to be_a(Hash)
        expect(anime[:name_engl]).to eq(@classroom_of_the_elite.name_engl)
        expect(anime[:name_native]).to eq(@classroom_of_the_elite.name_native)
        expect(anime[:description]).to eq(@classroom_of_the_elite.description)
        expect(anime[:season]).to eq(@classroom_of_the_elite.season)
        expect(anime[:season_year]).to eq(@classroom_of_the_elite.season_year)
        expect(anime[:episodes]).to eq(@classroom_of_the_elite.episodes)
        expect(anime[:score]).to eq(@classroom_of_the_elite.score)
    end

    it 'shuld return an error message if anime id is not found' do
        get "/api/v1/anime/#{@classroom_of_the_elite.id + 1}"

        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error[:message]).to eq('Id not found')
        expect(error[:status]).to eq(404)
    end

    it 'should delete anime in db by id' do
        delete "/api/v1/anime/#{@classroom_of_the_elite.id}"

        expect(response).to be_successful

        confirmation = JSON.parse(response.body, symbolize_names: true)

        expect(confirmation[:message]).to eq('Successfully deleted')
        expect(confirmation[:status]).to eq(200)
    end

    it 'should return an error if id not found to delete' do
        delete "/api/v1/anime/#{@classroom_of_the_elite.id + 1}"

        expect(response.status).to eq(404)

        confirmation = JSON.parse(response.body, symbolize_names: true)

        expect(confirmation[:message]).to eq('Id not found')
        expect(confirmation[:status]).to eq(404)
    end
end