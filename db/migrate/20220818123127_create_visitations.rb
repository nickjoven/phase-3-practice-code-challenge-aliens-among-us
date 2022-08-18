class CreateVisitations < ActiveRecord::Migration[5.2]
  def change
    create_table :visitations do |t|
      t.datetime :date
      t.integer :alien_id
      t.integer :earthling_id
    end
  end
end
