class AddDueDateToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :due_date, :string
  end
end
