class AssignmentsController < ApplicationController
  before_filter :get_course
  before_filter :correct_viewer, only: [:index, :show]
  before_filter :correct_teacher, only: [:new, :edit, :create, :update, :destroy]
  # GET courses/1/assignments
  # GET courses/1/assignments.json
  def index
    @assignments = @course.assignments.paginate(page: params[:page], per_page: 6)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET courses/1/assignments/1
  # GET courses/1/assignments/1.json
  def show
    @assignment = @course.assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET courses/1/assignments/new
  # GET courses/1/assignments/new.json
  def new
    @course = Course.find(params[:course_id])
    @assignment = @course.assignments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET courses/1/assignments/1/edit
  def edit
    @assignment = @course.assignments.find(params[:id])
  end

  # POST courses/1/assignments
  # POST courses/1/assignments.json
  def create
    @assignment = @course.assignments.build(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to course_assignments_url(@course), notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT courses/1/assignments/1
  # PUT courses/1/assignments/1.json
  def update
    @assignment = @course.assignments.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to course_assignments_url(@course), notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE courses/1/assignments/1
  # DELETE courses/1/assignments/1.json
  def destroy
    @assignment = @course.assignments.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to course_assignments_url(@course) }
      format.json { head :no_content }
    end
  end

  private
  def get_course
    @course = Course.find(params[:course_id])
  end  
  def correct_viewer
    unless current_user.class.name == "Admin" or current_user == @course.teacher or @course.students.include?(current_user)
      redirect_to root_path, notice: "You are either not enrolled to the course or don't have enough access rights"
    end
  end
  def correct_teacher
    redirect_to root_path, notice: "Only the instructor can do this" unless current_user == @course.teacher
  end
end
