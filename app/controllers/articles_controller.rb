class ArticlesController < ApplicationController

	include SessionsHelper
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

 	def index
 		@articles = Article.all
 	end

	def edit
	  @article = Article.find(params[:id])
	end

	def create
		@article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
    	@feed_items = []
      render 'static_pages/home'
    end
  end

  def update
	  @article = Article.find(params[:id])
	 
	  if @article.update(article_params)
	    redirect_to @article
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @article.destroy
	  redirect_to articles_path
	end

  private
	  def article_params
	    params.require(:article).permit(:title, :text, :category, :grade)
	  end

	  def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url unless current_user?(@article.user)
    end


end
