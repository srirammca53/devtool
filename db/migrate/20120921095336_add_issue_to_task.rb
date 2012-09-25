class AddIssueToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :issue_current_id, :string
  end
end
