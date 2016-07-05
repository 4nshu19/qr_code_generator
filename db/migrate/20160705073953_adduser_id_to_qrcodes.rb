class AdduserIdToQrcodes < ActiveRecord::Migration
  def change
    add_column :qrcodes, :user_id, :integer
  end
end
