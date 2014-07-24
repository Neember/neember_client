class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company_name
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :designation
      t.text   :address

      t.timestamps
    end
  end
end
