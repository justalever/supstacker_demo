class StacksController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_stack, only: %i[ show edit update destroy ]

  # GET /stacks or /stacks.json
  def index
    @stacks = Stack.all
  end

  # GET /stacks/1 or /stacks/1.json
  def show
  end

  # GET /stacks/new
  def new
    @stack = Stack.new
  end

  # GET /stacks/1/edit
  def edit
  end

  # POST /stacks or /stacks.json
  def create
    @stack = Stack.new(stack_params)
    @stack.user = current_user

    respond_to do |format|
      if @stack.save
        format.html { redirect_to stack_url(@stack), notice: "Stack was successfully created." }
        format.json { render :show, status: :created, location: @stack }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stacks/1 or /stacks/1.json
  def update
    respond_to do |format|
      if @stack.update(stack_params)
        format.html { redirect_to stack_url(@stack), notice: "Stack was successfully updated." }
        format.json { render :show, status: :ok, location: @stack }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stacks/1 or /stacks/1.json
  def destroy
    @stack.destroy!

    respond_to do |format|
      format.html { redirect_to stacks_url, notice: "Stack was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stack
      @stack = Stack.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stack_params
      params.require(:stack).permit(:title)
    end
end
