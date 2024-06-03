-- +goose Up
-- +goose StatementBegin
CREATE TABLE follows (
    followee_id integer NOT NULL REFERENCES users (id),
    follower_id integer NOT NULL REFERENCES users (id),
    created_at text not null default (strftime('%Y-%m-%dT%H:%M:%fZ')),
    updated_at text not null default (strftime('%Y-%m-%dT%H:%M:%fZ')),
    PRIMARY KEY (follower_id, followee_id),
    CHECK (follower_id != followee_id)
) strict;
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX follows_follower_id ON follows (follower_id);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX follows_followee_id ON follows (followee_id);
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE follows;
-- +goose StatementEnd