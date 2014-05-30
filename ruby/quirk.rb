# Generic JSON API library?

# I want to do this:
response = GET[:user][some_user][:repos]
#or
response = get :user, some_user, :repos
# And get back a hash containing the JSON reponse

# And what about this:
response = POST[:user][:repo] << some_hash
#or
response = post [:user, :repo] => some_hash
# Which should POST some_hash as JSON and get back a hash containing the JSON response

# Things to think about?

## Reponse codes
## Special HEADER Things
## url_encoded data (like some stuff in GET requests maybe)
## configuration, authentication, etc.