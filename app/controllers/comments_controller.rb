class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to :back, notice: "Your comment has been created"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def commentable
    if request.path.include?('blog') # be careful. any path with 'blog' in it will match
      Blog.find(params[:id])
    elsif params[:course_id] && request.path.include?('lecture')
      Course.where(publish: true).friendly.find(params[:course_id]).lectures.where(publish: true).friendly.find(params[:lecture_id]) # assuming Course has_many lectures
    else
      fail 'unnable to determine commentable type'
    end
  end
end
