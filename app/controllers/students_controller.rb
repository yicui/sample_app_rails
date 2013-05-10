class StudentsController < ApplicationController
  before_filter :admin_user, only: [:index, :destroy, :courses]
  before_filter :self_student, only: [:edit, :update, :course_add, :course_remove]
  before_filter :those_who_can_see, only: [:show]
  # GET /students
  # GET /students.json
  def index
    @students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  # GET /students/1/courses
  # GET /students/1/courses.json  
  def courses
    @student = Student.find(params[:id])
    @courses = @student.courses
    
    respond_to do |format|
      format.html # courses.html.erb
      format.json { render json: @student.courses }
    end    
  end

  # POST /students/1/course_add?course_id=1
  def course_add
    #Convert ids from routing to objects
    @student = Student.find(params[:id])
    @course = Course.find(params[:course])
    if not @student.courses.include?(@course)      
      @student.courses << @course
      flash[:notice] = 'Student was successfully enrolled'
    else
      flash[:error] = 'Student was already enrolled'
    end
    redirect_to courses_student_url(@student)
  end
  
  # POST /students/1/course_remove?courses[]=
  def course_remove
    @student = Student.find(params[:id])
    course_ids = params[:courses]
    unless course_ids.blank?
      course_ids.each do |course_id|
        course = Course.find(course_id)
        if @student.courses.include?(course)
          logger.info "Removing student from course #{course.id}"
          @student.courses.delete(course)
          flash[:notice] = 'Course was successfully deleted'
        end
      end
    end
    redirect_to courses_student_url(@student)
  end

  private
    def admin_user
      redirect_to signin_path, notice: "Only admin can do this" unless current_user.class.name == "Admin"
    end
    def self_student
      redirect_to signin_path, notice: "Only the student himself/herself can do this" unless current_user == Student.find(params[:id])
    end
    def those_who_can_see
      @student = Student.find(params[:id])
      unless current_user.class.name == "Admin" or current_user == @student or (current_user.class.name == "Teacher" and (@student.courses & current_user.courses).present?) 
        redirect_to signin_path, notice: "Student profile can be only seen by his/her teachers or admins"
      end
    end
end
