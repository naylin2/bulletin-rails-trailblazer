# README
* Ruby version (3.0.3)
* Rails version (6.1.4.4)

# Gem Install
* run: bundle install

# Project Setup
* delete these two lines in user.rb (temporarily)
    belongs_to :created_user, class_name: 'User', foreign_key: 'create_user_id'
    belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id'
    
* run: rails db:seed

* add these two lines back in user.rb
    belongs_to :created_user, class_name: 'User', foreign_key: 'create_user_id'
    belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id'

# Project Run
* run: rails s
