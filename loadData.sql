INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT DISTINCT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT current_city, current_state, current_country
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT hometown_city, hometown_state, hometown_country
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT event_city, event_state, event_country
FROM project1.Public_Event_Information;

INSERT INTO User_Current_Cities (user_id, current_city_id)
SELECT DISTINCT user_id, city_id
FROM project1.Public_User_Information
JOIN Cities ON current_city = city_name AND current_state = state_name AND current_country = country_name;

INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
SELECT DISTINCT user_id, city_id
FROM project1.Public_User_Information
JOIN Cities ON hometown_city = city_name AND hometown_state = state_name AND hometown_country = country_name;

INSERT INTO Programs (institution, concentration, degree)
SELECT DISTINCT institution_name, program_concentration, program_degree
FROM project1.Public_User_Information
WHERE institution_name IS NOT NULL AND program_concentration IS NOT NULL AND program_degree IS NOT NULL;

INSERT INTO Education (user_id, program_id, program_year)
SELECT DISTINCT user_id, program_id, program_year
FROM project1.Public_User_Information
JOIN Programs ON institution_name = institution AND program_concentration = concentration AND program_degree = degree
WHERE program_year IS NOT NULL;

INSERT INTO Friends (user1_id, user2_id)
SELECT DISTINCT user1_id, user2_id
FROM project1.Public_Are_Friends
WHERE user1_id != user2_id;

SET AUTOCOMMIT OFF;
INSERT INTO Albums (album_id, album_owner_id, cover_photo_id, album_name, album_created_time, album_modified_time, album_link, album_visibility)
SELECT DISTINCT album_id, owner_id, cover_photo_id, album_name, album_created_time, album_modified_time, album_link, album_visibility
FROM project1.Public_Photo_Information;

INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link)
SELECT DISTINCT photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link
FROM project1.Public_Photo_Information;
SET AUTOCOMMIT ON;

INSERT INTO Tags (tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y)
SELECT DISTINCT photo_id, tag_subject_id, tag_created_time, tag_x_coordinate, tag_y_coordinate
FROM project1.Public_Tag_Information;

INSERT INTO User_Events (event_id, event_creator_id, event_city_id, event_name, event_tagline, event_description, event_host, event_type, event_subtype, event_address, event_start_time, event_end_time)
SELECT DISTINCT pe.event_id, pe.event_creator_id, c.city_id, pe.event_name, pe.event_tagline, pe.event_description, pe.event_host, pe.event_type, pe.event_subtype, pe.event_address, pe.event_start_time, pe.event_end_time
FROM project1.Public_Event_Information pe
JOIN Cities c ON pe.event_city = c.city_name;