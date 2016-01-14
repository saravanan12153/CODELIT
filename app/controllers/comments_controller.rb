class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :commentable
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      if request.path.include?('recipe')
        @ThreadUsers = @commentable.comments.pluck(:user_id).uniq
        @ThreadUsers.each do |user|
          if current_user.id != user
            Notification.create(recipient_id: user, actor: current_user, action: "also commented in a recipe", notifiable: @commentable)
          end
        end
        @comment.mentioned_users.each do |user|
          Notification.create(recipient_id: user.id, actor: current_user, action: "mentioned you in a comment", notifiable: @commentable)
        end
      elsif request.path.include?('cast')
        @ThreadUsers = @commentable.comments.pluck(:user_id).uniq
        @ThreadUsers.each do |user|
          if current_user.id != user
            Notification.create(recipient_id: user, actor: current_user, action: "also commented in a code-cast", notifiable: @commentable)
          end
        end
        @comment.mentioned_users.each do |user|
          Notification.create(recipient_id: user.id, actor: current_user, action: "mentioned you in a comment", notifiable: @commentable)
        end
      elsif params[:course_id] && request.path.include?('lecture')
        @ThreadUsers = @commentable.comments.pluck(:user_id).uniq
        @ThreadUsers.each do |user|
          if current_user.id != user
            Notification.create(recipient_id: user, actor: current_user, action: "also commented in the lecture", notifiable: @commentable)
          end
        end
        @comment.mentioned_users.each do |user|
          Notification.create(recipient_id: user.id, actor: current_user, action: "mentioned you in a comment", notifiable: @commentable)
        end
      end
    end
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
    if request.path.include?('recipe') # be careful. any path with 'blog' in it will match
      @commentable = Recipe.friendly.find(params[:recipe_id])
    elsif request.path.include?('cast') # be careful. any path with 'blog' in it will match
      @commentable = Cast.friendly.find(params[:cast_id])
    elsif params[:course_id] && request.path.include?('lecture')
      @course = Course.where(publish: true).friendly.find(params[:course_id])
      @commentable = @course.lectures.where(publish: true).friendly.find(params[:lecture_id]) # assuming Course has_many lectures
    else
      fail 'unable to determine commentable type'
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end
end
