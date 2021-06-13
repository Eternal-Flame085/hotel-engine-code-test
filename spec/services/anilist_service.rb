require 'rails-helpers'

describe 'Anilist api service' do
    it 'should return anime data based on search term' do
        VCR.use_cassette('the_rising_of_the_shield_hero') do
            response = AnilistService.anime_search('The Rising of the Shield Hero')

            expect(response).to be_a(Hash)

            expect(response[:title]).to be_a(Hash)
            expect(response[:title][english]).to be_a(String)
            expect(response[:title][:native]).to be_a(Striing)
            expect(response[:episodes]).to be_a(Integer)
            expect(response[:SeasonYear]).to be_a(Integer)
            expect(response[:avarageScore]).to be_a(Integer)
            expect(response[:season]).to be_a(String)
            expect(response[:status]).to be_a(String)
        end
    end

    it 'should return an error if no anime was found' do
        VCR.use_cassette('not_found') do
            response = AnilistService.anime_search('anime_that_does_not_exists')

            expect(response).to be_a(Hash)

            expect(response[:error]).to eq('Not Found.')
            expect(response[:status]).to eq(404)
        end
    end
end