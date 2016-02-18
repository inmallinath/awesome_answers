class AnswersController < ApplicationController

  before_action :authenticate_user
  # before_action :authorize_user, only: destroy
  def create

    @question = Question.find params[:question_id]
    answer_params = params.require(:answer).permit(:body)
    @answer = Answer.new answer_params
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      redirect_to question_path(@question), notice: "Answer created!"
    else

      render "/questions/show"
    end
    #render json: params
  end

  def destroy
    #render json: params
    # question = Question.find params[:question_id]
    # answer = question.find params[:id]
    answer = Answer.find params[:id]
    redirect_to root_path, alert: "Access Denied" unless can? :manage, answer
    answer.destroy
    redirect_to question_path(params[:question_id]), notice: "Answer deleted!"
  end

# end
end
