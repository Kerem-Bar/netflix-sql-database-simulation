DROP DATABASE IF EXISTS `netflix_project`;
CREATE DATABASE `netflix_project`;
USE `netflix_project`;

-- 1. Users table
CREATE TABLE IF NOT EXISTS `users` (
  `userID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `age` TINYINT UNSIGNED NOT NULL,
  `country` VARCHAR(100) NOT NULL,
  `gender` ENUM('male', 'female', 'other', 'refused') NOT NULL,
  `subscribe_type` ENUM('personal', 'family') NOT NULL,
  PRIMARY KEY (`userID`)
);

-- 2. Genres table
CREATE TABLE IF NOT EXISTS `genres` (
  `genreID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Genre_Name` ENUM('Sci-Fi', 'Drama', 'Comedy', 'Action', 'Horror', 'Documentary', 'Thriller') NOT NULL,
  PRIMARY KEY (`genreID`)
);

-- 3. Contents table
CREATE TABLE IF NOT EXISTS `contents` (
  `contentID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `production_country` VARCHAR(100) NOT NULL,
  `is_netflix_OG` BOOLEAN NOT NULL DEFAULT 0, -- 0 = Not Original, 1 = Netflix Original
  `type` ENUM('movie', 'series') NOT NULL,
  `release_date` DATE NOT NULL,
  `end_date` DATE DEFAULT NULL,
  PRIMARY KEY (`contentID`)
);

-- 4. Content genres junction table
CREATE TABLE IF NOT EXISTS `content_genre` (
  `genreID` INT UNSIGNED NOT NULL,
  `contentID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`genreID`, `contentID`),
  CONSTRAINT `fk_genre` FOREIGN KEY (`genreID`) REFERENCES `genres` (`genreID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_content` FOREIGN KEY (`contentID`) REFERENCES `contents` (`contentID`) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5. Watch history table
CREATE TABLE IF NOT EXISTS `watch_history` (
  `watchID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userID` INT UNSIGNED NOT NULL,
  `contentID` INT UNSIGNED NOT NULL,
  `watch_date` DATE NOT NULL,
  `rating` DECIMAL(2,1) DEFAULT NULL,
  `watch_duration_min` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`watchID`),
  CONSTRAINT `fk_watch_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_watch_content` FOREIGN KEY (`contentID`) REFERENCES `contents` (`contentID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_rating_range` CHECK (`rating` BETWEEN 1.0 AND 5.0)
);

-- 6. Themes table
CREATE TABLE IF NOT EXISTS `themes` (
  `themeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `theme_name` ENUM('Cooking', 'Fashion', 'Religion', 'Science', 'Sports', 'History', 'Music') NOT NULL,
  PRIMARY KEY (`themeID`)
);

-- 7. Theme users junction table
CREATE TABLE IF NOT EXISTS `theme_users` (
  `themeID` INT UNSIGNED NOT NULL,
  `userID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`themeID`, `userID`),
  CONSTRAINT `fk_theme_users_theme` FOREIGN KEY (`themeID`) REFERENCES `themes` (`themeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_theme_users_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE RESTRICT ON UPDATE CASCADE
);