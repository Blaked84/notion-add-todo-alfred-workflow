#! /usr/bin/ruby
require './bundle/bundler/setup'
require "notion"
require 'alfred-3_workflow'
require './config'

NOTION_CLIENT = Notion::Client.new(token: notion_token)

def list_databases
  req = NOTION_CLIENT.get_databases
  a = req.response.body
  b = to_recursive_ostruct(JSON.parse(a))
  b.results.map{|r| {id: r['id'], name: r.dig('title').first.dig('text', 'content')}}
end

def to_recursive_ostruct(hash)
  OpenStruct.new(hash.each_with_object({}) do |(key, val), memo|
    memo[key] = val.is_a?(Hash) ? to_recursive_ostruct(val) : val
  end)
end

workflow = Alfred3::Workflow.new

list_databases.each do |database|
  workflow.result
          .uid(database[:id])
          .title(database[:name])
          .subtitle(database[:id])
          .type('default')
          .arg(database[:id])
          .valid(true)
          .icon('icon.png')
          .autocomplete(database[:name])
end

print workflow.output
