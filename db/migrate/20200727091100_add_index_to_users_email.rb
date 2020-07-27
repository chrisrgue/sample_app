class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
  def change

    # create index for email column and enforce uniqueness at DB level
    # (in addition to the uniqueness at model level which is not enough when user clicks _fast enough_ on submit button 2 (or more) times
    # ==> Request 1 creates user in memory and passes vaidation
    # ==> Request 2 creates user in memory and passes vaidation
    # ==> request 2 (or 1) gets saved into DB
    # ==> request 1 (or 2) gets saved into DB
    # = end result would be => 2 users with identical email-address (and name) in DB which we prevent with the following:
    add_index :users, :email, unique: true

  end
end
