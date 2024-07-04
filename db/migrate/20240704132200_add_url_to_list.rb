class AddUrlToList < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :url, :string
  end
end
