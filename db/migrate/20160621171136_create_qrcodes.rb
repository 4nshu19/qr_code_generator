class CreateQrcodes < ActiveRecord::Migration
  def change
    create_table :qrcodes do |t|
      t.string :link

      t.timestamps null: false
    end
  end
end
