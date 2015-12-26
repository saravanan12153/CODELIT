class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to courses_path
    else
      render layout: "empty"
      @mainTitle = "Welcome in Inspinia Rails Seed Project"
      @mainDesc = "It is an application skeleton for a typical Ruby on Rails web app. You can use it to quickly bootstrap your webapp projects and dev/prod environment."
    end
  end
end
