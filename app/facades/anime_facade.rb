class AnimeFacade
    class << self
        def fetch_all_db_anime(params)
            anime_list = Anime.all

            #Sort and filters if any
            if params[:sort].present? && valid_sort_variables?(params[:sort])
                anime_list = anime_list.order(params[:sort])
            else
                anime_list = anime_list.order(name_engl: :asc)
            end
            
            anime_list = anime_list.where(season_year: params[:year_filter]) if params[:year_filter].present?
            anime_list = anime_list.where('season ILIKE ?', "%#{params[:season_filter]}%") if params[:season_filter].present?

            return anime_list
        end

        private

        def valid_sort_variables?(sort_variable)
            accepted_values = ["name_eng", "name_native", "episodes", "season", "season_year", "score", "status"]

            accepted_values.any? { |value| value.in?(sort_variable) }
        end
    end
end