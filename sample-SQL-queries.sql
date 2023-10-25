/* 1) This query shows a total number of viewers of podcast episodes per each
artwork theme (taking into account only those episodes that contain some artwork), with
a condition that episodes under consideration are below 200 MB in terms of download
size. Episode artwork in our database comes from movies, so the theme is designated by
movie genre. */

SELECT Theme, SUM(ViewerCount)
FROM Presents, Episode, Artwork
WHERE Episode.EpID = Presents.EpID AND Presents.ArtworkID =
Artwork.ArtworkID AND Episode.EpID IN (SELECT EpID FROM Episode WHERE
DownloadSize < 200)
GROUP BY Theme

/* Similar example that did not work as intended: */
SELECT Theme, SUM(ViewerCount)
FROM Presents, Episode, Artwork
WHERE Episode.EpID = Presents.EpID
GROUP BY Theme
  
/* Explanation: The above query was wrong in that it did not join all three tables properly
(it did not join Artwork with Presents through foreign key, since it was missing the
following part after WHERE: Presents.ArtworkID = Artwork.ArtworkID). */

/* 2) This query displays those guest professions that appeared in podcasts in our
database more than twice, considering only guests who are over 21 years old. As the
query result below shows, only nurses and project managers appeared more than two
times. */  
  
SELECT Profession
FROM Guest, Person
WHERE Age >= 21 AND Guest.PersonID = Person.PersonID
GROUP BY Profession
HAVING COUNT(*) > 2

/* 3) This query looks for the names of Curated Collections and seeks the
number of episodes that each specific Collection possesses. Grouping the query with the
Name of the Collection enables the results to be illustrated distinctively by the Name with
each episode count; throwing out any duplicates in the process. */
  
SELECT C.Name, COUNT(E.EpisodeNumber)
FROM Episode E, CuratedCollection C, IsListedUnder L
WHERE E.EpID = L.EpID AND C.CurCollectionID = L.CurCollectionID
GROUP BY C.Name

/* 4) The query in this example looks for the Episode ID, Username, the
Usernames profile picture, User comment, and the TimeAndDate of the user comment.
By joining the three relations Episode, RaterProfile, and Rating we are then able to gather
the information that is being sought. In addition, a subquery is in the works that looks
through all Episode IDs that are less than ALL the selected EpisodeIDs whose
ViewerCount is less than “100000”. This query accurately illustrates the real world
application that this podcast database offers, as the query seeks to understand User input
from Podcast Episodes that may not be having much exposure. */
  
SELECT E.EpID, R.Username,RP.RaterPic, R.ReviewComment, R.TimeAndDate
FROM RaterProfile RP, Rating R, Episode E
WHERE RP.Username = R.Username AND E.EpID = R.EpID AND E.EpID <
ALL(SELECT E.EpID FROM Episode E WHERE E.ViewerCount < "100000")

/* 5) This query calculates the average number of episodes in podcasts that can
be listened to on smartphones. The query first selects the PlatformIDs of platforms that
are specifically on smartphone devices. It then uses the PlatformIDs to link to the
Podcasts table where the query selects podcasts that were just collected from the
platforms. The NumberOfEpisodes values are selected from these and are then averaged. 
The result was that podcasts available on smartphones tend to have around 67 episodes. */
  
SELECT AVG(NumberOfEpisodes)
FROM RunOn, Podcast, Platform
WHERE Podcast.PodID = RunOn.PodID AND RunOn.PlatformID =
Platform.PlatformID AND Platform.PlatformID
IN (SELECT PlatformID
FROM Platform
WHERE Device = 'Smartphone')
