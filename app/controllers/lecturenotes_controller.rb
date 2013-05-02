class LecturenotesController < ApplicationController
  before_filter :get_course
  # GET /lecturenotes
  # GET /lecturenotes.json
  def index
    @lecturenotes = @course.lecturenotes.paginate(page: params[:page], per_page: 6)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lecturenotes }
    end
  end

  # GET /lecturenotes/1
  # GET /lecturenotes/1.json
  def show
    @lecturenote = @course.lecturenotes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecturenote }
    end
  end

  # GET /lecturenotes/new
  # GET /lecturenotes/new.json
  def new
    @course = Course.find(params[:course_id])    
    @lecturenote = @course.lecturenotes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecturenote }
    end
  end

  # GET /lecturenotes/1/edit
  def edit
    @lecturenote = @course.lecturenotes.find(params[:id])
  end

  # POST /lecturenotes
  # POST /lecturenotes.json
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

  # PUT /lecturenotes/1
  # PUT /lecturenotes/1.json
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

  # DELETE /lecturenotes/1
  # DELETE /lecturenotes/1.json
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
end
