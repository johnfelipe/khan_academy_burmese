class ChangeDueDateDataType < ActiveRecord::Migration
  def change
    change_column :videos, :due_date, :date
  end
end
