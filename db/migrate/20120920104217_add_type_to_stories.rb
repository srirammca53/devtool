class AddTypeToStories < ActiveRecord::Migration
  def change
    add_column :stories, :Type, :string
  end
end
