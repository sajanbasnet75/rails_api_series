# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  fullname   :string
#  email      :string
#  password   :string
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :email, :fullname, :password, presence: true
  validates_uniqueness_of :email
end
