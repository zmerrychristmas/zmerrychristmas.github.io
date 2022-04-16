---
title: Shortened URL By Ruby ON Rails
categories:
- Framework
- Rails
tags:
- rails
- api
- rspec
- shortenURL
---

# URL Shorten By Ruby ON Rails
Give a website shortenedUrl to convert longURL to short URL with alpha lexigraphy encoded/decoded response to User.
- Give two endpoint 
	 - encoded
	 - decoded
 - Extra default enpoint is index, and retore lasted encoded url
 - About algorithm used on website. I use Bijective algorithm to make a alpha lexigraphy short url. 
- Give rate limit process to request IP and prevent attack vector. I was use gem `rack-attack` for this case to handle limit request per IP is 5 request to 2 second. other wise, better to authentic user before they use api. To do this prevent, can implement a mechanism authentic by a system by api key for user indetify and in session.
- System was give an URL with a unique shortURL to decrease weight in database and open scale up if have mutilple dabase installed.
- To prepare for scale up:\\
		1. Give a better cache system support Rate limit.\\
		2. With URL was created before, we change to operation select instead create same URL.\\
		3. Given a load ballancing to suppot this load is even better than server serve every single request.\\
		4. Architecture from Monolith or micro service and under control of load balancing give us a good reputation. 
	
## Install System
- Ruby version ^2.5~3.0
- Rails 
- rack-attack gem
- Rspec
- factory_bot_rails
- faker

To install run command below:
```sh
bundle
```

## API in use
Three enpoint with two default enpoint(`/api/v1/nami/`):
- index `/api/v1/nami`: Get method\\
json response:
```json
{
    "message": "Hello Nami Test",
    "encoded": "q",
    "url": "http://google.com"
}
```
- encoded `/api/v1/nami/encoded`: Post method\\
Json request:
```json
{
	"url": "http://google.com"
}
```
Json Response
```json
{
    "url": "http://google.com",
    "decoded": "b"
}
```
- decoded request `/api/v1/nami/decoded`: Post method\\
Json Request
```json
{
	"encoded": "e"
}
```
Json Response
```json
{
    "url": "http://google.com",
    "status": 200
}
```

### Last URL saved
- Last user saved was restore in Database. I was use default by sqlite3. But for better performance and production case need to setup dabase with MYSQL or PostgresSQL.

### encoded
```ruby
  def generate_slug
    last_id = ShortenUrl.last ? ShortenUrl.last.id : 1
    self.slug = Bijective.bijective_encode(last_id)
  end
	```
### decoded
```ruby
url = ShortenUrl.find_by_slug params[:encoded]
url.url
```

### Algorithm to conver longURL to Short
```ruby
class Bijective
  ALPHABET =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
    # make your own alphabet using:
    # (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle.join

  def self.bijective_encode(i)
    # from http://refactormycode.com/codes/125-base-62-encoding
    # with only minor modification
    return ALPHABET[0] if i == 0
    s = ''
    base = ALPHABET.length
    while i > 0
      s << ALPHABET[i.modulo(base)]
      i /= base
    end
    s.reverse
  end

  def self.bijective_decode(s)
    # based on base2dec() in Tcl translation 
    # at http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
    i = 0
    base = ALPHABET.length
    s.each_char { |c| i = i * base + ALPHABET.index(c) }
    i
  end
end
```
## Test application with Spec
Test case was specified with controller and function endoint. To run test from root of project run command:
```sh
rspec
```
## Sumarize
Give a website for serve enpoint to convert long url to short url, you can find source code at my github repository.
