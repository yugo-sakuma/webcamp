class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = search_for(User, 'name')
    else
      @records = search_for(Book, 'title')
    end
  end

  private

  def search_for(model, column)
    case @method
    when 'perfect'
      model.where("#{column} = ?", @content)
    when 'forward'
      model.where("#{column} LIKE ?", @content + '%')
    when 'backward'
      model.where("#{column} LIKE ?", '%' + @content)
    when 'partial'
      model.where("#{column} LIKE ?", '%' + @content + '%')
    end
  end
end
