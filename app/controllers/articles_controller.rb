class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :set_search

  def index
    @articles = @q.result(distinct: true).joins(:user).order('id DESC').page(params[:page]).per(20)

    @articles.collect! do |article|
      if article.url_title.nil?
        Article.get_url_info(article)
        article.save
      end
      article
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

      if @article.save
        redirect_to new_article_path, notice: '記事を登録しました。'
      else
        render :new
      end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: '記事を更新しました。' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: '記事を削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :url, :owner)
    end

    def set_search
      @q = Article.search(params[:q])
    end
end
