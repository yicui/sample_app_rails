class AssignmentsController < ApplicationController
  before_filter :get_course  
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = @course.assignments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = @course.assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @course = Course.find(params[:course_id])
    @assignment = @course.assignments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = @course.assignments.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
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

  # PUT /assignments/1
  # PUT /assignments/1.json
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

  # DELETE /assignments/1
  # DELETE /assignments/1.json
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
end
