# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :password
      t.integer :gender

      t.timestamps
    end
  end
end
