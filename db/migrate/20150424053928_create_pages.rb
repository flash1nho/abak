class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.integer :parent_id
      t.text :body
      t.string :slug
      t.string :path

      t.timestamps
    end
  end
end
