# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LancarAbadi::Application.initialize!

require 'will_paginate'
require 'barby'
require 'barby/barcode/code_128'
require 'barby/barcode/code_39'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/prawn_outputter'