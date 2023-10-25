CREATE TABLE Person (
  PersonID VARCHAR(11) PRIMARY KEY,
  Firstname VARCHAR(100) NOT NULL,
  Lastname VARCHAR(100) NOT NULL,
  Nickname VARCHAR(50),
  Title VARCHAR(30),
  Age INTEGER(3) NOT NULL,
  Bio TEXT(30,000),
  ProfilePic BLOB(65,535),
  Linkedin VARCHAR(100),
  Twitter VARCHAR(100),
  Facebook VARCHAR(100),
  Wiki VARCHAR(100),
  Youtube VARCHAR(100),
  Instagram VARCHAR(100));
CREATE TABLE Podcaster (
  PersonID VARCHAR(11) REFERENCES Person (PersonID),
  ExpertiseLevel VARCHAR(30),
  NativeLanguage VARCHAR(30));
CREATE TABLE Guest (
  PersonID VARCHAR(11) REFERENCES Person (PersonID),
  Profession VARCHAR(30));
CREATE TABLE Podcast (
  PodID VARCHAR(11) PRIMARY KEY,
  PodcastFormat VARCHAR(30),
  Genre VARCHAR(40),
  Title VARCHAR(40),
  NumberOfEpisodes INTEGER(5) NOT NULL,
  NumberOfSubscribers INTEGER(15),
  AgeRating VARCHAR(5),
  Description TEXT(30,000));
CREATE TABLE Episode (
  EpID VARCHAR(11) PRIMARY KEY,
  EpDate DATETIME,
  EpLength TIME NOT NULL,
  EpisodeNumber INTEGER(5),
  ViewerCount INTEGER(8),
  DownloadSize INTEGER(7) NOT NULL,
  Blurb TEXT(30,000));
CREATE TABLE CuratedCollection (
  CurCollectionID VARCHAR(11) PRIMARY KEY,
  Name VARCHAR(50),
  TrackSize INTEGER(5),
  DateStarted DATE,
  DateFinished DATE,
  MaturityRating VARCHAR(30),
  Description TEXT(30,000));
CREATE TABLE Artwork (
  ArtworkID VARCHAR(11) PRIMARY KEY,
  Artist VARCHAR(100),
  Theme VARCHAR(50),
  Title VARCHAR(100),
  DateCreated DATE,
  SubjectMatter VARCHAR(100),
  MeaningDescriptionTEXT(30,000));
CREATE TABLE Platform (
  PlatformID VARCHAR(11) PRIMARY KEY,
  Name VARCHAR(50),
  WebsiteURL VARCHAR(100),
  Device VARCHAR(50),
  DownloadLink VARCHAR(100),
  Cost FLOAT(3,2));
CREATE TABLE Rating (
  EpID VARCHAR(11),
  Review Comment VARCHAR(200),
  NumberOfStars VARCHAR(1),
  TimeAndDate DATETIME,
  Username VARCHAR(50),
  NumberOfLikes INTEGER(11),
  CONSTRAINT Rating_TimeAndDate_Username_EpID_pk PRIMARY KEY
  (TimeAndDate, Username, EpID),
  CONSTRAINT Rating_EpID_fk FOREIGN KEY (EpID) REFERENCES Episode
  (EpID) ON DELETE CASCADE);
CREATE TABLE RaterProfile (
  Username VARCHAR(50) PRIMARY KEY,
  RaterPic BLOB(65535));
  CONSTRAINT RaterProfile_Username_pk PRIMARY KEY (Username),
  CONSTRAINT RaterProfile_Username_fk FOREIGN KEY (Username)
  REFERENCES Rating (Username) ON DELETE CASCADE);
CREATE TABLE Hosts (
  PersonID VARCHAR(11),
  PodID VARCHAR(11),
  CONSTRAINT Hosts_PersonID_PodID_ PRIMARY KEY (PersonID, PodID),
  CONSTRAINT Hosts_PersonID_fk FOREIGN KEY (PersonID) REFERENCES
  Podcaster (PersonID) ON DELETE CASCADE,
  CONSTRAINT Hosts_PodID_fk FOREIGN KEY (PodID) REFERENCES
  Podcast
  (PodID) ON DELETE CASCADE);
CREATE TABLE AppearsIn (
  PersonID VARCHAR(11),
  EpID VARCHAR(11),
  CONSTRAINT AppearsIn_PersonID_EpID_pk PRIMARY KEY (PersonID,
  EpID),
  CONSTRAINT AppearsIn_fk FOREIGN KEY (PersonID) REFERENCES Guest
  (PersonID) ON DELETE CASCADE,
  CONSTRAINT AppearsIn_fk FOREIGN KEY (EpID) REFERENCES Episode
  (EpID) ON DELETE CASCADE);
CREATE TABLE RunOn (
  PlatformID VARCHAR(11),
  PodID VARCHAR(11),
  CONSTRAINT RunOn_PlatformID_PodID_pk PRIMARY KEY
  (PlatformID, PodID),
  CONSTRAINT RunOn_PlatformID_fk FOREIGN KEY (PlatformID)
  REFERENCES Platform (PlatformID),
  CONSTRAINT RunOn_PodID_fk FOREIGN KEY (PodID) REFERENCES
  Podcast (PodID));
CREATE TABLE Offers (
  PodID VARCHAR(11),
  CurCollectionID VARCHAR(11),
  CONSTRAINT Offers_PodID_CurCollectionID_pk PRIMARY KEY(PodID,
  CurCollectionID),
  CONSTRAINT Offers_PodID_fk FOREIGN KEY (PodID) REFERENCES
  Podcast (PodID) ON DELETE CASCADE,
  CONSTRAINT Offers_CurCollectionID_fk FOREIGN KEY (CurCollectionID)
  REFERENCES Curated Collection (CurCollectionID) ON DELETE CASCADE);
CREATE TABLE Debuts (
  PodID VARCHAR(11),
  EpID VARCHAR(11),
  CONSTRAINT Debuts_EpID_pk PRIMARY KEY (EpID),
  CONSTRAINT Debuts_PodID_fk FOREIGN KEY (PodID) REFERENCES
  Podcast (PodID) ON DELETE CASCADE,
  CONSTRAINT Debuts_EpID_fk FOREIGN KEY (EpID) REFERENCES
  Episode (EpID) ON DELETE CASCADE);
CREATE TABLE IsListedUnder (
  CurCollectionID VARCHAR(11),
  EpID VARCHAR(11),
  CONSTRAINT IsListedUnder_CurCollectionID_EpID_pk PRIMARY KEY
  (CurCollectionID, EpID),
  CONSTRAINT IsListedUnder_CurCollectionID_fk FOREIGN
  KEY(CurCollectionID) REFERENCES Curated Collection (CurCollectionID) ON
  DELETE CASCADE,
  CONSTRAINT IsListedUnder_EpID_fk FOREIGN KEY(EpID) REFERENCES
  Episode (EpID) ON DELETE CASCADE);
CREATE TABLE Presents (
  EpID VARCHAR(11),
  ArtworkID VARCHAR(11),
  CONSTRAINT Presents_ArtworkID_pk PRIMARY KEY (ArtworkID),
  CONSTRAINT Presents_ArtworkID_fk FOREIGN KEY (ArtworkID)
  REFERENCES Artwork (ArtworkID) ON DELETE CASCADE,
  CONSTRAINT Presents_EpID_fk FOREIGN KEY (EpID) REFERENCES
  Episode (EpID) ON DELETE CASCADE);
