class KittensController < ApplicationController
  before_action :set_kitten, only: %i[ show edit update destroy]
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(allowed_kittens_params)

    if @kitten.save
      redirect_to @kitten, notice: "Created succsessfully"
    else
      flash[:notice] = "Failed to create, #{ @kitten.errors.full_messages }"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def edit
  end

  def update
    if @kitten.update(allowed_kittens_params)
      redirect_to @kitten, notice: "Updated succsessfully"
    else
      flash[:notice] = "Failed to update, #{ @kitten.errors.full_messages }"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten.destroy

    redirect_to kittens_path
  end

  private

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end

  def allowed_kittens_params
    params.expect(kitten: [ :name, :age, :cuteness, :softness ])
  end
end
