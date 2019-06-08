# ticket-Challenge
CLI program to get tickets through an API and display info through a menu.
It takes the data from the config json file to make a request to the zendesk API to get tickets and will display the tickets to the user according to the user's input.  
  
## Development Environment
- Windows 10 Home 64-bit
- (from `ruby -v` command) -> ruby 2.6.3p62 (2019-04-16 revision 67580) [x64-mingw32]
- Visual Studios Code Verison 1.35.0
## Installation
This program uses the `rest-client` library to make requests to the Zendesk API so you will need to run  
`gem install rest-client`  
  
Since development was done on a windows environment, if you are using a different OS, you might have to replace the backslash `\` in the `require_relative` statements located in:  
```
main.rb line 3
```
## Appendix
This section will contain any additional information I would like to share regarding the coding challenge  
### Challenges
- Timeframe - this challenge was issued during the same period when us Muslims would be preparing for and celebrating Eid, which marks the end of the fasting month Ramadan, so I was not able to give it my full attention
- Docker - I have heard that this was a popular program for developers to use in the industry and I would have liked to take this challenge as an opportunity to learn it, however it does not work with Windows 10 Home version so I had to give it up
- Ruby - This was my first time using Ruby. I had heard that Zendesk uses it a fair bit so I thought this was a good chance to learn it.

