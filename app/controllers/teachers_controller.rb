class TeachersController < ApplicationController
  before_filter :admin_user, only: [:index, :new, :create, :destroy]
  before_filter :self_teacher, only: [:edit, :update]
  before_filter :those_who_can_see, only: [:show]
  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teachers }
    end
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    if (params.has_key?(:course_id))
      @course = Course.find(params[:course_id])
      @teacher = @course.teacher
    else
      @teacher = Teacher.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @teacher }
    end
  end

  # GET /teachers/new
  # GET /teachers/new.json
  def new
    @teacher = Teacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @teacher }
    end
  end

  # GET /teachers/1/edit
  def edit
    @teacher = Teacher.find(params[:id])
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(params[:teacher])

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
        format.json { render json: @teacher, status: :created, location: @teacher }
      else
        format.html { render action: "new" }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teachers/1
  # PUT /teachers/1.json
  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_url }
      format.json { head :no_content }
    end
  end

  private
    def admin_user
      redirect_to signin_path, notice: "Only admin can do this" unless current_user.class.name == "Admin"
    end
    def self_teacher
      redirect_to signin_path, notice: "Only the teacher himself/herself can do this" unless current_user == Teacher.find(params[:id])
    end
    def those_who_can_see
      @teacher = Teacher.find(params[:id])
      unless current_user.class.name == "Admin" or current_user == @teacher or (current_user.class.name == "Student" and (@teacher.courses & current_user.courses).present?) 
        redirect_to signin_path, notice: "Teacher profile can be only seen by his/her students or admins"
      end
    end
end
