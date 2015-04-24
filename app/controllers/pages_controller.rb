class PagesController < ApplicationController
  before_action :set_page, only: [:show]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to URI.encode(@page.path), notice: 'Страница была успешно создана.' }
        format.json { render :show, status: :created, location: @page.path }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page = Page.find_by_slug(params[:id])
    old_name = @page.name

    respond_to do |format|
      if @page.update(page_params)
        @page.rename_children_paths(old_name)
        format.html { redirect_to URI.encode(@page.path), notice: 'Страница была успешно обновлена.' }
        format.json { render :show, status: :ok, location: @page.path }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find_by_path(get_path(params[:path]))
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Страница была успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      path = get_path(params[:path])
      @page = Page.find_by_path(path)
      last_path = params[:path].split('/').last rescue nil
      if last_path
        if last_path == 'edit'
          render :edit
        elsif last_path == 'add'
          @page = Page.new
          p path
          @page.parent_id = Page.find_by_path(path).id
          render :new
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:name, :title, :parent_id, :body)
    end
end
