class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string  :attachable_type
      t.integer :attachable_id
      t.boolean :is_default
      t.timestamps
    end

    add_attachment :images, :file

    add_index :images, [:attachable_type, :attachable_id, :is_default]
  end
end
