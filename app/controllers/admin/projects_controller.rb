class Admin::ProjectsController < ApplicationController
  include AdminHelper

  before_action :set_project
  before_action :check_if_admin

  def index
    @projects = Project.all
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:status_project] == "true"
      @project.update(validated: true)
    elsif params[:status_project] == "false"
      @project.update(validated: false)
    end
    redirect_to project_fr_path(@project)
  end

  def destroy
    @project.delete
    if @project.delete
      flash[:success] = "Le projet a bien été supprimé"
      Donation.where(project_id: @project.id).each do |donation|
      donation.delete
      end
      redirect_to root_path
    else 
      flash[:danger] = "Le projet n'a pas pu être supprimé, veuillez rééssayer ultérieurement"
      redirect_to root_path
    end
  end

  private

  def set_project
    @project = Project.friendly.find_by_slug(params[:id])
  end

end
