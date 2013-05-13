# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ticketstats::Application.initialize!

#For paginate FUCK took me an hour
require 'will_paginate/array'
