# MarvelTest
Mavel App Technical Test

Things to know before installation:

-- From the get characters API I chose to store only properties that I needed (id, name, description, modified, thumbnail, detailURL). It was both an efficiency choice (there was useless data for my task) and a choice based on the fact that I needed a key to acces further url requests. However, the Character model can be easily extended with the other properties.

-- I made use of Core Data to store locally the characters after requesting them for the first time from the API. Moreover, the thumbnail images are also cached locally.

--  The structure of the project is in MVC

