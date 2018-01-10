require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
#while urls_films = character_hash["results"].find {|hash| hash["name"].downcase == character}
  #if urls_films
    #return urls_films["films"].collect do |film|
      #JSON.parse(RestClient.get(film))
    #end
  #end
  #character_hash = character_hash["next"] ? JSON.parse(RestClient.get(character_hash["next"])) : nil
  #end
#end
  film_list=character_hash["results"].find {|hash| hash["name"].downcase==character}
  character_hash=character_hash["next"] ? JSON.parse(RestClient.get(character_hash["next"])) : nil
  return film_list["films"].collect {|film| JSON.parse(RestClient.get(film))}
  end
end
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

def parse_character_movies(films_hash)
  aesthetic=[]
  films_hash.each do |bridge|
    bridge.collect do |k,v|
      if k=="title"
        aesthetic<<v
      end
    end
  end
  puts aesthetic
end
   #some iteration magic and puts out the movies in a nice list


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
