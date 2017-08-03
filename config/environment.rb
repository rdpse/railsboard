# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Load carrierwave (uploads)
require 'carrierwave/orm/activerecord'
