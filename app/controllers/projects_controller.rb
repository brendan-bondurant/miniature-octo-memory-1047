class ProjectsController < ActionController::Base
  # def index

  # end

  def show

    # require 'pry'; binding.pry
    @project = Project.find(params[:id])
    @theme = Challenge.find(@project.challenge_id)
  end
end