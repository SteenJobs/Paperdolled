class AddColumnToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :type_in, :string
  end
end
