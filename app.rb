require 'sinatra'
require 'haml'

articles = {
  lorem_ipsum: {
    heading: "Lorem Ipsum",
    content: "%p Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    date: "111",
    tags: ["lol", "kek", "nevermind"]
  },
  lorem_ipsumer: {
    heading: "Lorem Ipsum",
    content: "%p Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    date: "222",
    tags: ["lol", "kek"]
  }
}

get '/' do
  haml :index, :locals => {:arts => articles}
end

get '/p/:name' do |name|
  haml :article, :locals => {:art => articles[name.to_sym], :name => name}
end

get '/t/:tag_name' do |tag|
  articles_with_tag = {}
  articles.each do |name, art|
    articles_with_tag.store(name, art) if art[:tags].include? tag
  end
  if articles_with_tag == {} then haml :no_such_tag
  else haml :index , :locals => {:arts => articles_with_tag}
  end
end

get '/l/:list' do |list|
  haml :list, :locals => {:arts => articles}
end

get '/admin' do
  haml :admin
end
