class LecturenotesController < ApplicationController
  before_filter :get_course
  before_filter :correct_viewer, only: [:index, :show]
  before_filter :correct_teacher, only: [:new, :edit, :create, :update, :destroy]
  # GET courses/1/lecturenotes
  # GET courses/1/lecturenotes.json
  def index
    @lecturenotes = @course.lecturenotes.paginate(page: params[:page], per_page: 6)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lecturenotes }
    end
  end

  # GET courses/1/lecturenotes/1
  # GET courses/1/lecturenotes/1.json
  def show
    @lecturenote = @course.lecturenotes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecturenote }
    end
  end

  # GET courses/1/lecturenotes/new
  # GET courses/1/lecturenotes/new.json
  def new
    @course = Course.find(params[:course_id])    
    @lecturenote = @course.lecturenotes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecturenote }
    end
  end

  # GET courses/1/lecturenotes/1/edit
  def edit
    @lecturenote = @course.lecturenotes.find(params[:id])
  end

  # POST courses/1/lecturenotes
  # POST courses/1/lecturenotes.json
  def create
    @lecturenote = @course.lecturenotes.build(params[:lecturenote])

    respond_to do |format|
      if @lecturenote.save
        format.html { redirect_to course_lecturenotes_url(@course), notice: 'Lecturenote was successfully created.' }
        format.json { render json: @lecturenote, status: :created, location: @lecturenote }
      else
        format.html { render action: "new" }
        format.json { render json: @lecturenote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT courses/1/lecturenotes/1
  # PUT courses/1/lecturenotes/1.json
  def update
    @lecturenote = @course.lecturenotes.find(params[:id])

    respond_to do |format|
      if @lecturenote.update_attributes(params[:lecturenote])
        format.html { redirect_to course_lecturenotes_url(@course), notice: 'Lecturenote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lecturenote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE courses/1/lecturenotes/1
  # DELETE courses/1/lecturenotes/1.json
  def destroy
    @lecturenote = @course.lecturenotes.find(params[:id])
    @lecturenote.destroy

    respond_to do |format|
      format.html { redirect_to course_lecturenotes_url(@course) }
      format.json { head :no_content }
    end
  end

  private
  def get_course
    @course = Course.find(params[:course_id])
  end
  def correct_viewer
    unless current_user.class.name == "Admin" or current_user == @course.teacher or @course.students.include?(current_user)
      redirect_to root_path, notice: "You are either not part of this course or don't have enough access rights"
    end
  end
  def correct_teacher
    redirect_to root_path, notice: "Only the instructor can do this" unless current_user == @course.teacher
  end
end
