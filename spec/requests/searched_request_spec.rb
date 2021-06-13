require 'rails_helper'

describe 'Fetching data from searhes table' do
    before :each do
        @classroom_of_the_elite = Search.create!(
            searched_title: "Classroom of the Elite",
            searched_counter: 3
        )

        @one_piece = Search.create!(
            searched_title: "One Piece",
            searched_counter: 10
        )
    end

    it 'should return all anime searches done' do
        get '/api/v1/searches'

        expect(response).to be_successful

        list = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(list.count).to eq(2)

        expect(list.first[:attributes][:searched_title]).to eq(@classroom_of_the_elite.searched_title)
        expect(list.last[:attributes][:searched_title]).to eq(@one_piece.searched_title)
    end

    it 'should return search by id' do
        get "/api/v1/searches/#{@classroom_of_the_elite.id}"

        expect(response).to be_successful

        search = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
        
        expect(search[:searched_title]).to eq(@classroom_of_the_elite.searched_title)
        expect(search[:searched_counter]).to eq(@classroom_of_the_elite.searched_counter)
    end

    it 'should return error if id not found' do
        get "/api/v1/searches/#{@one_piece.id + 1}"

        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)
        
        expect(error[:message]).to eq("Id not Found")
        expect(error[:status]).to eq(404)
    end

    it 'should return confirmation of deletion by id' do
        delete "/api/v1/searches/#{@classroom_of_the_elite.id}"

        expect(response).to be_successful

        confirmation = JSON.parse(response.body, symbolize_names: true)

        expect(confirmation[:message]).to eq("Successfully deleted")
        expect(confirmation[:status]).to eq(200)
    end

    it 'should return error if id not found for delete' do
        delete "/api/v1/searches/#{@one_piece.id + 1}"

        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)
        
        expect(error[:message]).to eq("Id not found")
        expect(error[:status]).to eq(404)
    end
end