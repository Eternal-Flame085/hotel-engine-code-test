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
end