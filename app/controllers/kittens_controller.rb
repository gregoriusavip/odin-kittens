class KittensController < ApplicationController
  before_action :set_kitten, only: %i[ show edit update destroy]
  def index
    @kittens = Kitten.all
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(allowed_kittens_params)

    if @kitten.save
      redirect_to @kitten
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @kitten.update(allowed_kittens_params)
      redirect_to @kitten
    else
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
