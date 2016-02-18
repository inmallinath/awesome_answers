class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      # the t.references :question will generate an integer field that
      # is called: question_id (Rails Convention)
      # index: true -> will automatically create an index on the `question_id` field
      # foreign_key: true -> will automatically create a foreign_key constraint
      #                       for the `question_id` field
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
