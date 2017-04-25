class CreatePrerequisites < ActiveRecord::Migration[5.0]
  def change
    create_table :prerequisites do |t|
      t.string :name

      t.timestamps
    end
  end
end
