class AddIssueToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :issue_id, :string
  end
end
