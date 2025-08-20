class Api::V1::SearchController < Api::V1::SecureController
  def index
    @text = params[:text]
    scope = PgSearch.multisearch(@text)
    records = scope.map(&:searchable)

    render jsonapi: records
  end
end
