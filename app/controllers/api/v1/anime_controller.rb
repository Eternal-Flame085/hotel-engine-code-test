class Api::V1::AnimeController < ApplicationController
    def index
        render json: AnimeSerializer.new(AnimeFacade.fetch_all_db_anime(params))
    end

    def show
        anime = Anime.find_by(id: params[:id])

        return render json: { message: 'Id not found', status: 404}, status: 404 if anime.nil?

        render json: AnimeSerializer.new(anime), status: 200
    end

    def delete
        anime = Anime.find_by(id: params[:id])

        return render json: { message: 'Id not found', status: 404}, status: 404 if anime.nil?

        render json: { message: 'Successfully deleted', status:200}, status: 200
    end

    def search
        anime_search = AnimeFacade.anime_search(params[:anime_title])
        if anime_search.class == Hash
            return render json: anime_search, status: anime_search[:status]
        else
            return render json: AnimeSerializer.new(anime_search), status: 200
        end
    end
end