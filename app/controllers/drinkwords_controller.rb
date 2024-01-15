class DrinkwordsController < ApplicationController
  def show
    service = OpenAiService.new
    @generated_results = service.generate_drink_words(params[:keyword])
    # ここで@generated_resultsをビューに渡す
  end
end
