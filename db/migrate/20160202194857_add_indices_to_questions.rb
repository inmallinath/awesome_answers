class AddIndicesToQuestions < ActiveRecord::Migration
  def change
    add_index :questions, :title
    add_index :questions, :body

# to create a composite index you can do:
# add_index :questions, [:title, :body]
# to create a unique index
# add_index :questions, :body, unique: true
  end
end
