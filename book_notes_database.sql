CREATE TABLE user_books (
    id integer NOT NULL PRIMARY KEY,
    title character varying(100) NOT NULL,
    cover_id bigint,
    date_read date,
    rating integer,
    review text
);

CREATE TABLE notes (
    id integer NOT NULL PRIMARY KEY,
    book_id integer REFERENCES user_books(id),
    date_created date,
    note text,
    page_num integer NOT NULL
);
