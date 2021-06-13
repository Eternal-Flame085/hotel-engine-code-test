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
end