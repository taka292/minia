class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = Review.new
    @review.releasable_items.build
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to home_index_path, notice: "レビューを投稿しました！"
      # redirect_to @review, notice: "レビューを投稿しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def index
    @reviews = Review.includes(:user).all.page(params[:page])
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: "レビューを更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, releasable_items_attributes: [ :id, :name ])

    # 手放せるものリストの削除機能時には下記に修正
    # params.require(:review).permit(:title, :content, releasable_items_attributes: [:id, :name, :_destroy])
  end

  def set_review
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to review_path, alert: "他のユーザーのレビューは編集・削除できません。"
    end
  end
end
