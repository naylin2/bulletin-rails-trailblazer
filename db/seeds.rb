# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
User.destroy_all
User.create!([{
  name: "Ag Ag",
  email: "agag@gmail.com",
  password: "aaaaaaaa",
  role: '0',
  create_user_id: 1,
  updated_user_id: 1,
},
{
  name: "Mg Mg",
  email: "mgmg@gmail.com",
  password: "mmmmmmmm",
  role: '1',
  create_user_id: 1,
  updated_user_id: 1,
}])
