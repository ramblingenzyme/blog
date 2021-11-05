---
title: 'My First Twitter bot'
---

For my first experience with NodeJS, I decided on the fairly popular project of a Twitter bot.
All I had to do was figure out what this bot would tweet. I looked around for a while, and eventually I found out that my university offers a public API, which includes parking lot data.

So, I'd figured out my project: process the data from the API at intervals to tweet how many parking spots are open. I also thought  having the bot tweet some grumpy things when the parking got full could be a fun little twist.

In the end I had to split the parking data into the 3 types of parking spot at UOW, ticketed, permit and carpool. Luckily collating all the data ended up being less than the 140 character limit of Twitter.

## First Experience with NodeJS ##
Working with Node for a project really made me understand why it's such a popular language, and discover that the implementation of a module system made it a pleasure to work with.

With little/no understanding of asynchronous programming, first class functions and callbacks left me confused and in the dark, with no idea what I was doing. This of course meant I had to research and understand these concepts if I was going to get anywhere.

However, once I understood these basics, after some research and structuring the program out on paper (as I probably should've done before starting...), progress came quickly.

In the end, I decided to use events to structure the program as it helped me split the program over multiple files with small functions with events gluing them together.

## NPM and modules ##
A language with a package manager to make it easier to install specialised modules was a new experience for me.
It seems to be a system with many upsides, but I can also think of quite a few situations in which it could complicate things.

In the end I only needed these three external modules:

* [node-rest-client](https://github.com/aacerox/node-rest-client): To grab the parking data from my university's REST API.
* [json-query](https://github.com/mmckegg/json-query): To query and filter the data returned into arrays.
* [twit](https://github.com/ttezel/twit): To allow easy use of the Twitter API for "publishing" the data.

Many thanks for the effort and in-depth documentation from the creators of these modules, this wouldn't've been possible otherwise.

## Conclusions ##
* Node is a great language to work with
* Modules are awesome and so are their creators
* Good fun and experience
* 10/10 IGN would NodeJS again

The bot is deployed on an AWS instance in Sydney, and can be found [here](https://twitter.com/UOWParking).
