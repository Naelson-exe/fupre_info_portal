class CreateAdminUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.string :role, default: "admin"
      t.datetime :last_login_at
      t.integer :failed_attempts, default: 0
      t.datetime :locked_at
      t.string :unlock_token

      t.timestamps
    end

    add_index :admin_users, :email, unique: true
  end
end
