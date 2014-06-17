class TiddlersController < ApplicationController
  respond_to :html, :json

  wrap_parameters :tiddler, include: %w(title text file tags fields content_type)

  before_action :find_space

  self.responder = TiddlerResponder

  def index
      @tiddlers = @space.tiddlers.all
      respond_with @tiddlers do |format|
        format.atom { render layout: false }
      end
  end

  def show
    begin
      @tiddler = @space.tiddlers.find(params[:id])
      respond_with @tiddler
    rescue ActiveRecord::RecordNotFound
      not_found "Tiddler"
    end
  end

  def new
    @tiddler = @space.tiddlers.build
  end

  def edit
    begin
      @tiddler = @space.tiddlers.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      not_found "Tiddler"
    end
  end

  def create
    @tiddler = @space.tiddlers.build
    @tiddler.new_revision tiddler_params

    respond_with do |format|
      if @tiddler.save
        format.html {
          redirect_to PathHelpers::html_path :space_tiddler_path, @space, @tiddler
        }
        format.json {
          created :json, @tiddler, space_tiddler_path(@space, @tiddler)
          }
      else
        format.html {
          redirect_to new_space_tiddler_path
        }
        format.json { unprocessable_entity }
      end
    end
  end

  def update
    begin
      @tiddler = @space.tiddlers.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found "Tiddler"
    end

    if request.patch?
      @tiddler.new_revision_from_previous @tiddler.current_revision.id,
        tiddler_params
    else
      @tiddler.new_revision tiddler_params
    end

    respond_with do |format|
      if @tiddler.save
        format.html {
          redirect_to PathHelpers::html_path :space_tiddler_path, @space, @tiddler
        }
        format.json { no_content }
      else
        format.html {
          redirect_to edit_space_tiddler_path
        }
        format.json { unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @tiddler = @space.tiddlers.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found "Tiddler"
    end

    respond_with do |format|
      if @tiddler.destroy
        format.html {
          redirect_to space_tiddlers_path
        }
        format.json { no_content }
      else
        format.html {
          redirect_to edit_space_tiddler_path
        }
        format.json { unprocessable_entity }
      end
    end
  end

  private

  def find_space
    begin
      @space = Space.find(params[:space_id])
    rescue ActiveRecord::RecordNotFound
      not_found "Space"
    end
  end

  def tiddler_params
    params.require(:tiddler)
      .permit(:title, :text, :file, :fields, :content_type, tags: []).tap do |whitelisted|
        whitelisted[:fields] = params[:tiddler][:fields]
      end
  end
end
