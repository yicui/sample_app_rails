class LecturenotesController < ApplicationController
  # GET /lecturenotes
  # GET /lecturenotes.json
  def index
    @lecturenotes = Lecturenote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lecturenotes }
    end
  end

  # GET /lecturenotes/1
  # GET /lecturenotes/1.json
  def show
    @lecturenote = Lecturenote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecturenote }
    end
  end

  # GET /lecturenotes/new
  # GET /lecturenotes/new.json
  def new
    @lecturenote = Lecturenote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecturenote }
    end
  end

  # GET /lecturenotes/1/edit
  def edit
    @lecturenote = Lecturenote.find(params[:id])
  end

  # POST /lecturenotes
  # POST /lecturenotes.json
  def create
    @lecturenote = Lecturenote.new(params[:lecturenote])

    respond_to do |format|
      if @lecturenote.save
        format.html { redirect_to @lecturenote, notice: 'Lecturenote was successfully created.' }
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
    @lecturenote = Lecturenote.find(params[:id])

    respond_to do |format|
      if @lecturenote.update_attributes(params[:lecturenote])
        format.html { redirect_to @lecturenote, notice: 'Lecturenote was successfully updated.' }
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
    @lecturenote = Lecturenote.find(params[:id])
    @lecturenote.destroy

    respond_to do |format|
      format.html { redirect_to lecturenotes_url }
      format.json { head :no_content }
    end
  end
end
