#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/combine'
  t.test_files = FileList['test/lib/combine/*_test.rb']
  t.verbose = true
end