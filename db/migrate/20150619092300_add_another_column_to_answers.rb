class AddAnotherColumnToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :date, :string
  end
end
