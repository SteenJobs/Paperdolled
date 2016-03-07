class AddColumnToOptions < ActiveRecord::Migration
  def change
    add_column :options, :question_type, :string
  end
end
