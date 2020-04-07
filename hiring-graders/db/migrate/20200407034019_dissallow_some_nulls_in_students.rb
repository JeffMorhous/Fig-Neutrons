class DissallowSomeNullsInStudents < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:students, :first_name, false )
    change_column_null(:students, :last_name, false )
    change_column_null(:students, :email, false )
    change_column_null(:students, :phone, false )
    change_column_null(:students, :password_digest, false )
  end
end
