class QuestionsController < ApplicationController
  # this `before_action` will call the `find_question` method before executing
  # any other action.
  # We can specify :only or :except to be more specific about the actions
  # which the before_action apply to
  # before_action :find_question, except: [:new, :create, :index] # if we are except a few actions
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user, except: [:index, :show]

  before_action :authorize_user, only: [:edit, :update, :destroy]

  def new
    @question = Question.new
  end

  def create
    # params = {"question"=>{"title"=>"hello world", "body"=>"something here"}}
    # question = Question.new
    # question.title = params[:question][:title]
    # question.body = params[:question][:body]

    @question = Question.new question_params

    @question.user = current_user

    if @question.save
      # all these formats are possible ways to redirect in Rails:
      flash[:notice] = "Question created successfully"
      redirect_to question_path(@question)
      # redirect_to question_path({id: @question.id})
      # redirect_to @question
      # redirect_to question_path({id: @question}) this will also work

    else
      # this will render app/views/questions/new.html.erb template
      # we need to be explicit about rendering the new template because
      # the default behavior is to render `create.html.erb`
      # you can specify full path such as: render "/questions/new"
      flash[:alert] = "Question wasn't created. Check errors below"
      render :new
    end
  end

  def show
    #@question = Question.find params[:id]
    @question.view_count += 1
    @question.save
    @answer = Answer.new
  end

  def index
    @questions = Question.order("view_count DESC")
  end

  def edit
    # we need to find the question that will be edited
    #@question = Question.find params[:id]

  end

  def update
    # We need to fetch the question first to update it
    #@question = Question.find params[:id]

      # We call the update with sanitized params
    if @question.update question_params
      # We redirect to the question show page
      redirect_to question_path(@question), notice: "Question Updated!"
    else
      render :edit
    end
  end

  def destroy
    #@question = Question.find params[:id]
    @question.destroy
    # We redirect to the index page
    redirect_to questions_path, notice: "Question deleted!"
  end

  private

  def question_params
    # using params. require ensures that there is a key called `question` in my
    # params. the `permit` method will only allow parameters that you explicitly
    # list, in this case: title and body
    question_params = params.require(:question).permit([:title, :body, :category_id])
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize_user
    unless can? :manage, @question
    #if @question.user != current_user
      redirect_to root_path, alert: "Access Denied"
    end
  end
end
