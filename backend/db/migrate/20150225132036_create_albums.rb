class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string     :name, null: false
      t.text       :description
      t.references :albumable, polymorphic: true, index: true

      t.timestamps null: false
    end

    add_index :albums, :name
  end
end

