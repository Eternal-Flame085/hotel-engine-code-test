class AnilistService
    class << self
        def anime_search(anime_title)
            query = "query {
                Media(search: \"#{anime_title}\", type: ANIME) {
                title {
                    english
                    native
                }
                description
                episodes
                season
                seasonYear
                averageScore
                status
                }
            }"

            result = make_request(query)
            
            return { error: result[:errors][0][:message],  status: result[:errors][0][:status] } if result.has_key?(:errors)

            result[:data][:Media]
        end

        private

        def make_request(query)
            url = "https://graphql.anilist.co"
            header_hash = { 
                'Content-Type' => 'application/json'
            }

            response = Faraday.post(url, JSON.generate({query: query}), header_hash)
            JSON.parse(response.body, symbolize_names: true)
        end
    end
end