# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :created_user, class_name: 'User', foreign_key: 'create_user_id'
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id'

  # soft-delete
  acts_as_paranoid

  require 'csv'

  def self.import(file, create_user_id, updated_user_id)
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8', quote_char: '|',
                           header_converters: :symbol) do |row|
      Post.create! row.to_hash.merge(create_user_id: create_user_id, updated_user_id: updated_user_id)
    end
  end
end
