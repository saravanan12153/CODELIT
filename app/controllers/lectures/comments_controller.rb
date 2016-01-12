class Lectures::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Lecture.friendly.find(params[:lecture_id])
  end
end