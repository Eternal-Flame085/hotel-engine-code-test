# Hotel Engine Code Test

# Description

This was my attempt to make a quick client that consumes an external API within 4 hours (really took around four and a half not counting the time making the readme) for the Hotel Engine code test. I

I was surprised with the amount of freedom given and that made me a bit nervous. What is in this repository is not the final idea I had in mind, if given more time I would have made another table called characters with a one-to-many relationship with the anime table and consume more of the anilist api that what I have now.

What really threw me off for this quick test was the requirement of a searches table. I spent some time thinking how to integrate it better maybe even having a relationship with the anime table in some form but as it stands right now its more of a statistics table used to check the different uniq searches for anime and how many times they are used.

# Configuration
1. Clone `git@github.com:Eternal-Flame085/hotel-engine-code-test.git`
2. Run `Bundle install` to install gems and dependencies
3. Run `Bundle exec rails db:{create,migrate}` to set up the database and run migrations
4. Run `Rails s` to start server on local host

# Endpoints

`GET /api/v1/anime` returns all the anime currently in the database

The anime by default are ordered by name but can be ordered by asc or desc order by most of its attributes with the `sort` parameter. with sort specify the attribute to sort by followed by `asc` or `desc` example: `score asc` or `score desc`.
Accepted `sort` attributes: `name_engl`, `name_native`, `episodes`, `season`, `season_year`, `score`, `status`

The anime can also be filtered by the season and year it was released or plans to be released.
To filter by year the parameter is `year_filter` and accepts an integer
To filter by season the parameter is `season_filter` and accepts: `SUMMER`, `WINTER`, `FALL`, `SPRING` either capitalized or not.

Example Response:
```
{
    "data": [
        {
            "id": "2",
            "type": "anime",
            "attributes": {
                "name_engl": "My Hero Academia",
                "name_native": "僕のヒーローアカデミア",
                "description": "What would the world be like if 80 percent of the population manifested extraordinary superpowers called “Quirks” at age four? Heroes and villains would be battling it out everywhere! Becoming a hero would mean learning to use your power, but where would you go to study? U.A. High's Hero Program of course! But what would you do if you were one of the 20 percent who were born Quirkless?<br><br>\n\nMiddle school student Izuku Midoriya wants to be a hero more than anything, but he hasn't got an ounce of power in him. With no chance of ever getting into the prestigious U.A. High School for budding heroes, his life is looking more and more like a dead end. Then an encounter with All Might, the greatest hero of them all gives him a chance to change his destiny…<br><br>\n\n(Source: Viz Media)",
                "episodes": 13,
                "season": "SPRING",
                "season_year": 2016,
                "status": "FINISHED",
                "score": 79
            }
        },
        {
            "id": "1",
            "type": "anime",
            "attributes": {
                "name_engl": "The Rising of the Shield Hero",
                "name_native": "盾の勇者の成り上がり",
                "description": "Naofumi Iwatani, an uncharismatic Otaku who spends his days on games and manga, suddenly finds himself summoned to a parallel universe! He discovers he is one of four heroes equipped with legendary weapons and tasked with saving the world from its prophesied destruction. As the Shield Hero, the weakest of the heroes, all is not as it seems. Naofumi is soon alone, penniless, and betrayed. With no one to turn to, and nowhere to run, he is left with only his shield. Now, Naofumi must rise to become the legendary Shield Hero and save the world!<br><br>\n\n\n<i>The first episode was pre-aired on December 27th, 2018. Regular broadcast began on January 9th, 2019.</i>\n<br><br>\n<i>Note: The first episode aired with a runtime of ~47 minutes as opposed to the standard 24 minute long episode.</i>",
                "episodes": 25,
                "season": "WINTER",
                "season_year": 2019,
                "status": "FINISHED",
                "score": 78
            }
        }
    ]
}
```

`GET /api/v1/anime/search` is the endpoint that calls the anilist api if the anime is not in the database.
Accepted parameters: `anime_title` with the name of the anime to search up 

Successful example Response:
```
{
    "data": {
        "id": "1",
        "type": "anime",
        "attributes": {
            "name_engl": "The Rising of the Shield Hero",
            "name_native": "盾の勇者の成り上がり",
            "description": "Naofumi Iwatani, an uncharismatic Otaku who spends his days on games and manga, suddenly finds himself summoned to a parallel universe! He discovers he is one of four heroes equipped with legendary weapons and tasked with saving the world from its prophesied destruction. As the Shield Hero, the weakest of the heroes, all is not as it seems. Naofumi is soon alone, penniless, and betrayed. With no one to turn to, and nowhere to run, he is left with only his shield. Now, Naofumi must rise to become the legendary Shield Hero and save the world!<br><br>\n\n\n<i>The first episode was pre-aired on December 27th, 2018. Regular broadcast began on January 9th, 2019.</i>\n<br><br>\n<i>Note: The first episode aired with a runtime of ~47 minutes as opposed to the standard 24 minute long episode.</i>",
            "episodes": 25,
            "season": "WINTER",
            "season_year": 2019,
            "status": "FINISHED",
            "score": 78
        }
    }
}
```

Failed search example response:
```
{
    "error": "Not Found.",
    "status": 404
}
```

`GET /api/v1/anime/<anime_id>` Returns an anime with that id from the database
Successful example response: same as above

`DELETE /api/v1/anime/<anime_id>` Deletes the anime with that id from the databse
Successful example response:
```
{
    "message": "Successfully deleted",
    "status": 200
}
```

Failed example response: 

```
{
    "message": "Id not Found",
    "status": 404
}
```

`GET /api/v1/searches` will return all the all the anime titles and title variants anyone has searched with a count of how many times that specific search has been made.

By default the searches are ordered by the anime titles but can be ordered using the `sort` parameter. with sort specify the attribute to sort by followed by `asc` or `desc` example: `searched_title asc` or `searched_title desc`.
Accepted `sort` attributes: `searched_title`, `searched_counter`

Successful example response:
```
{
    "data": [
        {
            "id": "2",
            "type": "searched",
            "attributes": {
                "searched_title": "My Hero Academia",
                "searched_counter": 1
            }
        },
        {
            "id": "1",
            "type": "searched",
            "attributes": {
                "searched_title": "The Rising of the Shield Hero",
                "searched_counter": 1
            }
        }
    ]
}
```

`GET /api/v1/searches/:id` Returns the anime searched with that id from the database if it exists.
Successful example response:

```
{
    "data": {
        "id": "1",
        "type": "searched",
        "attributes": {
            "searched_title": "The Rising of the Shield Hero",
            "searched_counter": 1
        }
    }
}
```

`DELETE /api/v1/searches/:id` Deletes the anime searched with that id from the database if it exists.
Successful example response:

```
{
    "message": "Successfully deleted",
    "status": 200
}
```

Failed example response: 

```
{
    "message": "Id not Found",
    "status": 404
}
```
