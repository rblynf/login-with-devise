class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :username
      t.string :sex

      t.timestamps
    end
  end
end
