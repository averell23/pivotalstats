$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'bundler/setup'
require 'pivotal-tracker'

require 'lib/iteration_stats'
require 'lib/stats_aggregator'
require 'lib/csv_processor'
