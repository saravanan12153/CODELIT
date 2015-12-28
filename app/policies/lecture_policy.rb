class LecturePolicy
  attr_reader :user, :lecture

  def initialize(user, lecture)
    @user = user
    @lecture = lecture
  end

  def show?
    !lecture.course.enrolled(user)
  end
end