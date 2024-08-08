-- name: GetRoom :one
SELECT 
  "id", "theme"
FROM rooms 
WHERE id = $1;

-- name: GetRooms :many    Not Committed Yet
SELECT
  "id", "theme"
FROM rooms;

-- name: InsertRoom :one
INSERT INTO rooms
  ( "theme" ) VALUES
  ( $1 )
RETURNING "ID";

-- name: GetMessage :one 
SELECT
  "id", "room_id", "message", "reaction_count", "answered"
 FROM messages
WHERE
    id = $1;

-- name GetRoomMessages :many  Not Committed Yet
SELECT
  "id", "room_id", "message", "reaction_count", "answered"
FROM messages
WHERE
  room_id = $1;

-- name: InsertMessage :one    Not Committed Yet
INSERT INTO messages
    ("room_id", "message") VALUES
    ( $1, $2 )
    RETURNING "id"
    
-- name: ReacToMessage :one  Not Committed Yet
UPDATE messages
SET
    reaction_count = reaction_count + 1
WHERE
  ID = $1
RETURNING reaction_count  

-- name: RemoveReactionFromMessage :one
UPDATE messages
SET
    reaction_count = reaction_count - 1
WHERE
    id = $1
RETURNING reaction_count;

-- name: MarkMessageAsAnswered :exec
UPDATE messages
SET
    answered = true
WHERE
    id = $1;