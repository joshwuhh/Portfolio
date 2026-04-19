-- Creating the intial tables for the DB within SQLlite -- 
-- A single table will not be enough to hold all data, will create a table for each entity -- 
CREATE TABLE people (
  id INTEGER,
  tag TEXT,
  name TEXT,
  age INTEGER,
  balance REAL,
  is_admin BOOLEAN
);

-- To track transactions between users -- 
CREATE TABLE transactions (
  id INTEGER,
  recipient_id INTEGER,
  sender_id INTEGER,
  note TEXT,
  amount REAL
); 

-- Making edits to the table, saving people as users all with a username and password -- 
ALTER TABLE people
RENAME TO users;

ALTER TABLE users
RENAME COLUMN tag TO username;

ALTER TABLE users
ADD COLUMN password TEXT; 


-- UP MIGRATION, Add columns to track transaction types and if the transaction was succesful or not  -- 
ALTER TABLE transactions
ADD COLUMN was_successful BOOLEAN;

ALTER TABLE transactions
ADD COLUMN transaction_type TEXT; 


/* 
DOWN MIGRATION pairing 
  ALTER TABLE transactions 
  DROP COLUMN was_successful;

  ALTER TABLE transactions
  DROP COLUMN transaction_type; 
*/

-- For the social media aspect of CashPal which will allow users to post pictures and text --
CREATE TABLE posts (
  id INTEGER,
  image_url TEXT,
  description TEXT,
  author_id INTEGER,
  is_sponsored BOOLEAN
)

/* As use grows, we see a need to change the posts are stored. People who post are now simply 'posters', we feel a need to make apparent 
  if a post has been edited by the poster, and since so many posters are normal people we no longer need to know if they are sponsored */ 
ALTER TABLE posts
RENAME COLUMN author_id TO poster_id;

ALTER TABLE posts 
ADD COLUMN is_edited BOOLEAN;

ALTER TABLE posts 
DROP COLUMN is_sponsored;


/*  TEST
CREATE TABLE transactions (
  id INTEGER,
  recipient_id INTEGER,
  sender_id INTEGER,
  note TEXT,
  amount REAL
);

INSERT INTO transactions (id, recipient_id, sender_id, note, amount)
VALUES (1, 14, 26, 'Testing transaction!', 10.50);

INSERT INTO transactions (id, sender_id)
VALUES (2, 4);

INSERT INTO transactions (recipient_id, note, amount)
VALUES (5, 'Oil change, full synthetic', 140.22);

ALTER TABLE transactions
ADD COLUMN transaction_type TEXT;

ALTER TABLE transactions
ADD COLUMN was_successful BOOLEAN;
*/


-- The test above reveals an issue with NULL values being allowed into the database -- 
-- I will add a constraint , a rule to enforce a behaviour on the database, so NULL values are not allowed -- 
-- SQLlite does not support adding constraints with ALTER TABLE statements, we will need to redo our table -- 
CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  age INTEGER NOT NULL,
  country_code TEXT NOT NULL,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  is_admin BOOLEAN
);

/* 
An important decision might be that we store a users balance and keeping track of accurate data is critical. 
 We should  
- Keep track of their current balance
- Log Historical data for their balance at any time
- See a log of transactions that took place on their account
*/

-- Decided to keep a  single transactions table but would need to recreate it with some new fields and NOT NULL values -- 
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY,
  sender_id INTEGER,
  recipient_id INTEGER,
  memo TEXT NOT NULL,
  amount REAL NOT NULL,
  balance REAL NOT NULL
);

