# ticket-Challenge
CLI program to get tickets through an API and display info through a menu.
It takes the data from the config json file to make a request to the zendesk API to get tickets and will display the tickets to the user according to the user's input.  
  
It is run from the main file located in the root of this working directory  
`main.rb`
  
## Development Environment
- Windows 10 Home 64-bit
- (from `ruby -v` command) -> ruby 2.6.3p62 (2019-04-16 revision 67580) [x64-mingw32]
- Visual Studios Code Version 1.35.0
## Installation
This program uses the `rest-client` library to make requests to the Zendesk API so you will need to run  
`gem install rest-client`  
  
## Set-Up
This program refers to `config.json` in the root of this working directory for certain information  
- **Request Authentication details** are stored in the config, encoded in Base64
- **URL subdomain** is also encoded in Base64
- **tickets per page** number is also stored here, but not encoded at all  

If you would like to change these parameters, feel free to edit them in `config.json` before running the program.  

## Running the program
simply open `cmd` on windows, `terminal` on Mac or `bash` in linux and run  
`ruby main.rb`  
from the root of this directory

## Appendix
This section will contain any additional information I would like to share regarding the coding challenge  
### Challenges
- Timeframe - this challenge was issued during the same period when us Muslims would be preparing for and celebrating Eid, which marks the end of the fasting month Ramadan, so I was not able to give it my full attention
- Docker - I have heard that this was a popular program for developers to use in the industry and I would have liked to take this challenge as an opportunity to learn it, however it does not work with Windows 10 Home version so I had to give it up
- Ruby - This was my first time using Ruby. I had heard that Zendesk uses it a fair bit so I thought this was a good chance to learn it. Lots of Googling done.
### Extensibility and reusability
I noticed an interesting line in Adel's blog post that was shared with us, it said "*Design your solution to be robust, extensible and simple*"  
So with that in mind, I have written the request and json handling code to be able to accept parameters to allow for dependency injection. This will make the code more reusable and flexible.  
I have also implemented a Command Pattern in the Menu with a Menu Invoker and the menu option classes being the "command" classes.
This was done to allow for extendability in the options the menu can take, in case more options are added in the future.
### Linting
I have used a linter in Python in a previous project and found it to be a very good tool to clean up my code and make it more readable.  
This time, since it is my first time coding in ruby I thought it would be a good idea to use a linter to help me.  
I had a look at `ruby -wc` but I saw that it hadn't been updated at all recently so I looked elsewhere.  
I came across `rubocop`, which seemed to be more actively updated, and installed it. It gave me a lot of flags, which was daunting at first but I did find them helpful. Although, in some areas I think they did more to confuse me than help.
### Menu style
The menu options were text-based instead of index-based as I feel that, using the command pattern, it shouldn't be static. The options can be changed around, added or removed as needed, so they shouldn't reference a specific index number as it could change. I had also thought of using 'back' to return from the inner menus and 'quit' to exit from the main menu just so users would not be confused as to where they were in the program, but opted for uniformity in using 'quit' in all places.