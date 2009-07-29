# http://sneaq.net/textmate-wtf
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'test/unit'
require 'matchy'
require 'context'
require 'mocha'

require File.dirname(__FILE__) + '/../lib/mongolytics'