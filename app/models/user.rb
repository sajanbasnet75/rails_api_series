# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string
#  encrypted_password :string
#  fullname           :string
#  gender             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class User < ApplicationRecord
  validates :email, :fullname, :encrypted_password, presence: true
  validates_uniqueness_of :email
end
