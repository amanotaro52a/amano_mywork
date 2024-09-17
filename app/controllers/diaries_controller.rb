class DiariesController < ApplicationController
  def index
    @q = Diary.ransack(params[:q])
    @diaries = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @diary = Diary.new
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path, success: t('defaults.flash_message.created', item: Diary.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Diary.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def diary_params
    params.require(:diary).permit(:title, :content, :diary_image)
  end

  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  def update
    @diary = current_user.diaries.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diary_path(@diary), success: t('defaults.flash_message.updated', item: Diary.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Diary.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    diary = current_user.diaries.find(params[:id])
    diary.destroy!
    redirect_to diaries_path, success: t('defaults.flash_message.deleted', item: Diary.model_name.human), status: :see_other
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :content, :diary_image, :diary_image_cache)
  end
end
