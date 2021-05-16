#! /usr/bin/ruby
require './bundle/bundler/setup'
require "notion"
require './config'

NOTION_CLIENT = Notion::Client.new(token: NOTION_TOKEN)

def add_todo(title)
  req = NOTION_CLIENT.create_page({
      "parent": {
        "database_id": DATABASE_ID
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
