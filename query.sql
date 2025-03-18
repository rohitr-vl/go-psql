-- name: CreateDriver :one
INSERT INTO drivers (
    full_name, phone_number, email, permanent_address, license_number, license_valid_until, is_available, is_active
    ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8
    ) RETURNING *;

-- name: GetDriver :one
SELECT * FROM drivers 
WHERE email = $1;

-- name: DriverList :many
SELECT * FROM drivers 
ORDER BY full_name;

-- name: UpdateDriver :exec
UPDATE drivers SET 
    full_name = $1, phone_number = $2, permanent_address = $4, license_number = $5, license_valid_until = $6, is_available = $7, is_active = $8 
    WHERE email = $3;

-- name: DeleteDriver :exec
DELETE FROM drivers 
WHERE email = $1;