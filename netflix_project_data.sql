USE `netflix_project`;

-- 1. Insert data into 'users' table
INSERT INTO `users` (`age`, `country`, `gender`, `subscribe_type`) VALUES
(25, 'Israel', 'female', 'personal'),       
(34, 'United States', 'male', 'family'),  
(19, 'Japan', 'other', 'personal'),         
(45, 'United Kingdom', 'refused', 'family'), 
(28, 'Canada', 'female', 'personal'),       
(31, 'Germany', 'male', 'family'),        
(22, 'France', 'female', 'personal');       

-- 2. Insert data into 'genres' table
INSERT INTO `genres` (`Genre_Name`) VALUES
('Sci-Fi'),
('Drama'),
('Comedy'),
('Action'),
('Horror'),
('Documentary'),
('Thriller');

-- 3. Insert data into 'contents' table
-- is_netflix_OG: 0 = not original, 1 = original production
-- type: 'series' or 'movie'
INSERT INTO `contents` (`title`, `production_country`, `is_netflix_OG`, `type`, `release_date`, `end_date`) VALUES
('Stranger Things', 'United States', 1, 'series', '2016-07-15', NULL),
('Inception', 'United States', 0, 'movie', '2010-07-16', NULL),
('The Crown', 'United Kingdom', 1, 'series', '2016-11-04', '2023-12-14'),
('Parasite', 'South Korea', 0, 'movie', '2019-05-30', NULL),
('Black Mirror', 'United Kingdom', 1, 'series', '2011-12-04', NULL),
('Our Planet', 'United Kingdom', 1, 'series', '2019-04-05', '2019-04-05'),
('Pulp Fiction', 'United States', 0, 'movie', '1994-10-14', NULL),
('The Silent Valley', 'United States', 0, 'movie', '2023-05-10', NULL);


-- 4. Insert data into 'content_genre' table
INSERT INTO `content_genre` (`genreID`, `contentID`) VALUES
(1, 1), -- Stranger Things is Sci-Fi
(2, 2), -- Inception is Drama
(2, 3), -- The Crown is Drama
(4, 4), -- Parasite is Action
(1, 5), -- Black Mirror is Sci-Fi
(6, 6), -- Our Planet is Documentary
(7, 7), -- Pulp Fiction is Thriller
(1, 8); -- The Silent Valley is Sci-Fis

-- 5. Insert data into 'watch_history' table
INSERT INTO `watch_history` (`userID`, `contentID`, `watch_date`, `rating`, `watch_duration_min`) VALUES
(1, 1, '2026-01-10', 4.5, 55),
(2, 2, '2026-02-15', 5.0, 148),
(3, 4, '2026-03-20', 3.8, 132),
(4, 3, '2026-04-05', 4.2, 58),
(5, 5, '2026-05-12', NULL, 45), -- User watched but did not rate
(6, 6, '2026-06-01', 4.9, 50),
(7, 7, '2026-06-15', 4.0, 154);

-- 6. Insert data into 'themes' table
INSERT INTO `themes` (`theme_name`) VALUES
('Cooking'),
('Fashion'),
('Religion'),
('Science'),
('Sports'),
('History'),
('Music');

-- 7. Insert data into 'theme_users' table
INSERT INTO `theme_users` (`themeID`, `userID`) VALUES
(1, 1), (2, 1), -- User 1: Cooking, Fashion
(5, 2), (6, 2), -- User 2: Sports, History
(4, 3), (7, 3), -- User 3: Science, Music
(3, 4), (6, 4), -- User 4: Religion, History
(1, 5), (7, 5), -- User 5: Cooking, Music
(4, 6), (5, 6), -- User 6: Science, Sports
(2, 7), (7, 7); -- User 7: Fashion, Music