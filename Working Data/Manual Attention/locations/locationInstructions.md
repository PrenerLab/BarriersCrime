## Instructions for Location Data

In our crime data, a number of crimes do not have any spatial information except for location names or comments about the location. We'd like to use that location information to derive an address that we can use for finding where each crime occurred. 

### Instructions:

1. Open your location file and side scroll until you see the "locationname" and "locationcomment" variables.

2. If the location name and/or comment contain enough information to find the address through an internet search, put a 1 in the "useable" column and enter the full address in the "newAddress" field. 

3. If the location name and comment do not have enough information to find an address, put a 0 in the "useable" column and move on to the next observation. 

Lastly, if you have any questions, just ask in the barriers-crime channel on Slack!