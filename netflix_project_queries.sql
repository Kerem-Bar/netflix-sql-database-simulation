USE `netflix_project`;

-- ====================================================================
-- Query 1: Cross-Sectional Alignment (Themes vs Watched Genres)
-- ====================================================================

SELECT 
    t.theme_name,
    g.Genre_Name,
    COUNT(wh.watchID) AS total_views,
    SUM(wh.watch_duration_min) AS total_watch_minutes,
    ROUND(AVG(wh.watch_duration_min), 1) AS avg_duration_per_view
    
	FROM themes t
	JOIN theme_users tu ON t.themeID = tu.themeID
	JOIN watch_history wh ON tu.userID = wh.userID
	JOIN content_genre cg ON wh.contentID = cg.contentID
	JOIN genres g ON cg.genreID = g.genreID
    
    GROUP BY t.theme_name, g.Genre_Name
	ORDER BY t.theme_name ASC, total_watch_minutes DESC;
    
-- ====================================================================
-- Query 2: Demographic Profiling and Engagement Across Content Themes
-- ====================================================================
SELECT 
    t.theme_name,
    COUNT(DISTINCT tu.userID) AS interested_users,
    ROUND(AVG(u.age), 1) AS avg_age,
    COUNT(wh.watchID) AS total_watches,
    ROUND(AVG(wh.rating), 2) AS avg_rating
FROM themes t
JOIN theme_users tu ON t.themeID = tu.themeID
JOIN users u ON tu.userID = u.userID
LEFT JOIN watch_history wh ON u.userID = wh.userID
GROUP BY t.theme_name
ORDER BY total_watches DESC;

-- ===========================================================================
-- Query 3: Normalized Performance of Netflix Originals by Production Country
-- ===========================================================================
SELECT 
    c.production_country,
    COUNT(DISTINCT c.contentID) AS total_originals,
    COUNT(wh.watchID) AS total_watch,
    ROUND(COUNT(wh.watchID) / COUNT(DISTINCT c.contentID), 1) AS views_per_title,
    ROUND(AVG(wh.rating), 2) AS avg_rating
FROM contents c
JOIN watch_history wh ON c.contentID = wh.contentID
WHERE c.is_netflix_OG = 1
GROUP BY c.production_country
HAVING avg_rating >= 4.0
ORDER BY views_per_title DESC;

-- ===================================================================================
-- Query 4: Viewer Engagement and Catalog Performance Across Series Genres
-- ===================================================================================

SELECT 
    g.Genre_Name,
    COUNT(DISTINCT c.contentID) AS total_series,
    COUNT(wh.watchID) AS total_watch,
    ROUND(AVG(wh.rating), 2) AS avg_rating
FROM genres g
JOIN content_genre cg ON g.genreID = cg.genreID
JOIN contents c ON cg.contentID = c.contentID
JOIN watch_history wh ON c.contentID = wh.contentID
WHERE c.`type` = 'series'
GROUP BY g.Genre_Name
HAVING total_watch >= 1
ORDER BY total_watch DESC, avg_rating DESC;

-- ===================================================================================
-- Query 5: Catalog Utilization Audit and Dormancy Identification
-- ===================================================================================
SELECT 
    c.title,
    g.Genre_Name,
    c.`type`,
    COUNT(wh.watchID) AS total_watch
FROM genres g
JOIN content_genre cg ON g.genreID = cg.genreID
JOIN contents c ON cg.contentID = c.contentID
LEFT JOIN watch_history wh ON c.contentID = wh.contentID
GROUP BY c.contentID, c.title, g.Genre_Name, c.`type`
ORDER BY total_watch ASC, c.title ASC;


    
    
	
    
    
    
    
    