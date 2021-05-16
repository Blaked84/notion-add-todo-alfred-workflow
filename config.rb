NOTION_TOKEN_FILE = ENV['HOME']+'/.notion_add_todo_alfred/notion_token.txt'
CONFIG_DATABASE_FILE = ENV['HOME']+'/.notion_add_todo_alfred/database_id.txt'

def notion_token
  File.read(NOTION_TOKEN_FILE)
end

def database_id
  File.read(CONFIG_DATABASE_FILE)
end