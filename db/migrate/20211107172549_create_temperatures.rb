class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|
      t.string :pi_name
      t.float :reading

      t.timestamps
    end
  end
end
