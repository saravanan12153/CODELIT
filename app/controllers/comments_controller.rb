class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :commentable
  before_action :set_comment, only: [:destroy]

  def create
    @comment = commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to :back, notice: "Your comment has been created"
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to :back, notice: "Your comment has been deleted"
    else
      redirect_to :back, alert: "You cannot do this deletion"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def commentable
    if request.path.include?('blog') # be careful. any path with 'blog' in it will match
      Blog.find(params[:id])
    elsif params[:course_id] && request.path.include?('lecture')
      @course = Course.where(publish: true).friendly.find(params[:course_id])
      @commentable = @course.lectures.where(publish: true).friendly.find(params[:lecture_id]) # assuming Course has_many lectures
    else
      fail 'unable to determine commentable type'
    end
  end

  def set_comment
    @comment = commentable.comments.find(params[:id])
  end
end
