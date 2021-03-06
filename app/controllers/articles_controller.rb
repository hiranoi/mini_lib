class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index

    category_id = Category.exists?(params[:category_id]) ? params[:category_id] : nil
    user_id = User.exists?(params[:user_id]) ? params[:user_id] :nil

    if category_id.nil? && user_id.nil?
      @articles = Article.order('created_at DESC').page(params[:page]).per(10)
    elsif !user_id.nil? 
      @articles = Article.where(user_id: user_id).order('created_at DESC').page(params[:page]).per(10)
    elsif !category_id.nil? 
      @articles = Article.where(category_id: category_id).order('created_at DESC').page(params[:page]).per(10)
    end

    @articles.collect! do |article|
      if article.url_title.nil?
        begin
          Article.get_url_info(article)
          article.save
        rescue => e
          logger.error e.message + ":不正なURLが存在します"
        end
      end
      article
    end
  end

  def show
    @article_view = ArticleView.new()
    @article_view.article_id = params[:id]
    @article_view.user_id = current_user.id
    @article_view.save

    redirect_to @article.url
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit
  end

  def search
    @categories = Category.all
    @users = User.order('last_sign_in_at DESC').limit(20)
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
      params.require(:article).permit(:title, :url, :category_id)
    end
end
