class StacksController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_stack, only: %i[ show edit update destroy ]

  def index
    @stacks = Stack.all
  end

  def show
  end

  def new
    @stack = Stack.new
  end

  def edit
  end


  def create
    @stack = Stack.new(stack_params)
    @stack.user = current_user

    if @stack.save
      redirect_to stack_url(@stack), notice: "Stack was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @stack.update(stack_params)
      redirect_to stack_url(@stack), notice: "Stack was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stack.destroy!
    redirect_to stacks_url, notice: "Stack was successfully destroyed."
  end

  private
    def set_stack
      @stack = Stack.find(params[:id])
    end

    def stack_params
      params.require(:stack).permit(:title)
    end
end
