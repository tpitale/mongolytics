# Mongolytics

## Description

Simple analytics tracking for Rails using the awesomest: MongoDB

## Dependencies

    Rails
    MongoDB
    MongoMapper

## Installation

    sudo gem install mongolytics

## Setup

  Just be sure to setup MongoMapper to connect to MongoDB in environment.rb:
  
    Rails::Initializer.run do |config|
      config.gem 'mongomapper', :version => '>= 0.2.1'
    end
    
    MongoMapper.database = "databasename-#{Rails.env}"
  
  [More Information](http://railstips.org/2009/7/23/getting-started-with-mongomapper-and-rails)

## Usage

    class ApplicationController < ActionController::Base
      include Mongolytics::Tracker
    end

  In your controllers call any of these (creates an after_filter):

    track_all_stats                               # tracks all actions
    track_view_stats                              # tracks index, show
    track_change_stats                            # tracks create, update, destroy
    track_stats_for :new, :edit, :show, :destroy  # track any action mix

  If you want to track a custom session variable:

    track_session_key :username           # tracks session[:username] as a String
    track_session_key :user_id, Integer   # tracks session[:user_id] as an Integer

  Later, retrieve stats via (given UsersController is our controller):

    # by path, useful for getting per-id stats e.g., /users/1
    Mongolytics.stats_for_path user_path(@user)               # using the path helper (not url helper)
    
    # by controller and action keys, useful if you want all views of users/show page
    Mongolytics.stats_for_keys :users, :show                  # using the controller and action

    # by controller/action and session key/value hash
    Mongolytics.stats_for_keys :users, :show, :user_id => 1   # note: session keys, not request params

  You can always query the Statistics:

    Mongolytics::Statistic.count({:user_id => 1})

## Motivation

### Why use MongoDB?

  It's cool, I wanted to learn it, it's unbelievably fast, and they're working
  on a restful API which might do cool things (pooled analytics tracking)

### This is lame!

  I know I'm only taking hit counts, and not really doing much to track unique
  views, or user tracking, or determining user environments. The reason being:
  that's not what I wanted to do!

  If you want that stuff, and great reporting, and cool graphs: use Google Analytics.
  It's perfect for that stuff! I just wanted counts on certain pages that weren't
  trackable by GA because of their lack of unique url, or view (e.g., create/update/destroy).

## License

Copyright (c) 2009 Tony Pitale

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
