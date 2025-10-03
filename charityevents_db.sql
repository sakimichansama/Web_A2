-- create database
CREATE DATABASE IF NOT EXISTS charityevents_db;
USE charityevents_db;

-- Charitable Organization Registration Form
CREATE TABLE IF NOT EXISTS organizations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    mission TEXT,
    contact_info VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Activity Classification Table
CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Charity Event Schedule
CREATE TABLE IF NOT EXISTS events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    organization_id INT,
    category_id INT,
    date DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    purpose TEXT,
    description TEXT,
    ticket_price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    target_amount DECIMAL(15, 2) NOT NULL,
    current_amount DECIMAL(15, 2) DEFAULT 0.00,
    image_url VARCHAR(255),
    status ENUM('upcoming', 'past', 'suspended') DEFAULT 'upcoming',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organization_id) REFERENCES organizations(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- insert info
INSERT INTO organizations (name, mission, contact_info) VALUES
('Love Foundation', 'Dedicated to helping children in poor areas access educational opportunities', 'contact@lovefoundation.org'),
('Environmental Alliance', 'Protecting the natural environment and promoting sustainable development', 'info@environmentalalliance.org');


INSERT INTO categories (name, description) VALUES
('Charity Gala', 'Fundraising events through formal dinners'),
('Fun Run', 'Charity fundraising activities in the form of running'),
('Silent Auction', 'Events where participants donate through silent bidding'),
('Charity Concert', 'Fundraising events through musical performances'),
('Community Service', 'Volunteer activities for community improvement'),
('Environmental Protection', 'Activities focused on environmental conservation'),
('Education Support', 'Events supporting educational initiatives'),
('Sports Events', 'Fundraising through sports activities');


INSERT INTO events (name, organization_id, category_id, date, location, purpose, description, ticket_price, target_amount, current_amount, image_url, status) VALUES
('Annual Charity Gala', 1, 1, '2025-12-15 19:00:00', 'International Convention Center', 'Raising construction funds for schools in poor areas', 'We will host a grand charity gala inviting celebrities from all sectors. All proceeds will be used for school construction in impoverished areas.', 500.00, 100000.00, 35000.00, 'https://picsum.photos/id/1060/800/400', 'upcoming'),
('City Fun Run', 2, 2, '2025-11-10 08:00:00', 'City Sports Park', 'Raising funds for environmental projects', 'This is a fun 5km running event suitable for participants of all ages. All proceeds will be used for local environmental projects.', 100.00, 50000.00, 25000.00, 'https://picsum.photos/id/1058/800/400', 'upcoming'),
('Art Charity Auction', 1, 3, '2025-10-05 14:00:00', 'Modern Art Center', 'Raising funds for children''s medical assistance programs', 'This auction will feature works donated by numerous artists. All auction proceeds will be used for medical assistance for children from poor families.', 0.00, 80000.00, 60000.00, 'https://picsum.photos/id/1074/800/400', 'upcoming'),
('Summer Charity Concert', 2, 4, '2025-09-20 19:30:00', 'City Concert Hall', 'Raising funds for ocean protection projects', 'Several renowned musicians will perform voluntarily. All ticket revenue will be used for marine plastic pollution control projects.', 200.00, 60000.00, 45000.00, 'https://picsum.photos/id/1082/800/400', 'past'),
('Community Food Drive', 1, 5, '2025-12-05 10:00:00', 'Community Center Plaza', 'Collecting food donations for families in need', 'Volunteers will collect non-perishable food items to distribute to low-income families during the holiday season. Everyone is welcome to donate.', 0.00, 20000.00, 12000.00, 'https://picsum.photos/id/1080/800/400', 'upcoming'),
('Beach Cleanup Initiative', 2, 6, '2025-11-20 09:00:00', 'City Beachfront', 'Cleaning up coastal areas and raising environmental awareness', 'Join us for a day of beach cleanup. We''ll provide gloves and bags. Help us protect marine life by removing plastic waste from our shores.', 0.00, 15000.00, 8500.00, 'https://picsum.photos/id/1043/800/400', 'upcoming'),
('Children''s Book Donation', 1, 7, '2025-10-15 13:00:00', 'Downtown Library', 'Collecting books for rural school libraries', 'Donate new or gently used children''s books. These will be distributed to schools in remote areas with limited resources.', 0.00, 30000.00, 18000.00, 'https://picsum.photos/id/24/800/400', 'upcoming'),
('Charity Bike Ride', 2, 8, '2025-09-25 07:00:00', 'City Park', 'Raising funds for green energy projects', 'A 20km scenic bike ride through the city. Participants can get sponsorships from friends and family. All funds go to renewable energy initiatives.', 50.00, 40000.00, 32000.00, 'https://picsum.photos/id/1059/800/400', 'past');