class CreateSecretCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :secret_codes do |t|
      t.string :secret_code, :null => true
      t.references :user, index: true
      t.timestamps
    end
  end
end
