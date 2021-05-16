#! /usr/bin/ruby
require './bundle/bundler/setup'
require "notion"
require 'alfred-3_workflow'
require './config'

NOTION_CLIENT = Notion::Client.new(token: notion_token)

def add_todo(title)
  req = NOTION_CLIENT.create_page({
      "parent": {
        "database_id": database_id
      },
      "properties": {
        "Name": {
          "title": [
             {
               "text": {
                 "content": title
               }
             }
           ]
        }
      }
    })
  
  req.response.code == "200" ? true : false
end

add_todo(ARGV[0])

puts ARGV[0]