class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :comments, dependent: :destroy
  belongs_to :user

  # Adding this will ensure that an answer's body is unique for a given question.
  # This means that you can't submit the same answer body twice for the same question
  # but you can submit the same answer body for two different questions.
  validates :body, presence: true, uniqueness: {scope: :question_id}

  def user_full_name
    user.full_name if user
  end

end
