class RenamePostalcodeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :postalcode, :postal_code
  end
end
