-- +goose Up
-- +goose statementbegin
CREATE TABLE users (
    id integer primary key,
    email TEXT NOT NULL UNIQUE,
    username TEXT NOT NULL,
    password Text NOT NULL,
    bio TEXT,
    image TEXT,
    created_at text not null default (strftime('%Y-%m-%dT%H:%M:%fZ')),
    updated_at text not null default (strftime('%Y-%m-%dT%H:%M:%fZ'))
) strict;
-- +goose statementend

--Update the created_at and updated_at columns when the row is updated
-- +goose statementbegin
create trigger users_updated_timestamp
after
update on users begin
update users
set updated_at = strftime('%Y-%m-%dT%H:%M:%fZ')
where id = old.id;
end;
-- +goose statementend

-- +goose Down
DROP TABLE users;