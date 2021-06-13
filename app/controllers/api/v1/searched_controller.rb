class Api::V1::SearchedController < ApplicationController
    def index
        accepted_values = ["searched_titles asc", "searched_titles desc", "search_count asc", "search_count desc"]
        searches = Search.all
        if params[:sort].present? && accepted_values.include?(params[:sort.downcase])
            searches = searches.order(params[:sort])
        else
            searches = searches.order(searched_title: :asc)
        end
        searches = searches.where('searched_titles ILIKE ?', "%#{params[:title_filter]}%") if params[:title_filter].present?
        
        render json: SearchedSerializer.new(searches)
    end

    def show
        search = Search.find_by(id: params[:id])
        
        return render json: {message: "Id not Found", status: 404}, status: 404 if search.nil?
        
        render json: SearchedSerializer.new(search), status:200
    end

    def delete
        search = Search.find_by(id: params[:id])

        return render json: { message: 'Id not found', status: 404}, status: 404 if search.nil?

        render json: { message: 'Successfully deleted', status:200}, status: 200
    end
end