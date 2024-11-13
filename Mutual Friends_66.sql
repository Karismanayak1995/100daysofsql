--You are working as a data analyst at Meta/Facebook. Given a friendship table, your task is to find the mutual friend for each pair of friends in friendship table.
--The table record one-way relationship: sender of friend request and recipient of friend request.
--Write an SQL to find list of mutual friend(comma separated) for each pair of input table and sort the result by friend1,friend2. 
--In case of no mutual friends query should return null.

-- Create the Friends table
CREATE TABLE Friends (
    friend1 VARCHAR(50),
    friend2 VARCHAR(50)
);

-- Insert data into the Friends table
INSERT INTO Friends (friend1, friend2) VALUES
('Jason', 'Mary'),
('Mike', 'Mary'),
('Mike', 'Jason'),
('Susan', 'Jason'),
('John', 'Mary'),
('Susan', 'Mary');

SELECT * FROM Friends
