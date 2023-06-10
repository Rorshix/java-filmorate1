drop table  IF EXISTS genre CASCADE;
drop table  IF EXISTS genres_line CASCADE;
drop table  IF EXISTS rating CASCADE;
drop table  IF EXISTS status CASCADE;
drop table  IF EXISTS status_line CASCADE;
drop table  IF EXISTS frends_line CASCADE;
drop table  IF EXISTS users CASCADE;
drop table  IF EXISTS film CASCADE;
drop table  IF EXISTS likes_line CASCADE;


create TABLE film (
        film_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        title varchar(40) NOT NULL,
        description varchar(40) NOT NULL,
        realise_date date NOT NULL,
        duration integer NOT NULL,
        rating_id integer,
        CONSTRAINT constr_date CHECK (realise_date > '1895-12-28'),
        CONSTRAINT bad_name CHECK (Title <> '')
);

create TABLE genres_line (
        genres_line_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        film_id integer NOT NULL REFERENCES film (film_id),
        genre_id integer
);

create TABLE genre (
        genre_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        genre_name varchar(40) NOT NULL
);

alter table genres_line add CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genre;

create TABLE rating (
        rating_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        rating_name varchar(40) NOT NULL
);

alter table film add CONSTRAINT fk_rating FOREIGN KEY (rating_id) REFERENCES rating;

create TABLE users(
        user_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        user_name varchar(40) NOT NULL,
        login varchar(40) NOT NULL,
        email varchar(40) NOT NULL,
        birthday date NOT NULL,
        CONSTRAINT bad_email  CHECK (email LIKE '%___@___%.__%')
);


create TABLE frends_line (
        frends_line_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        user_id integer NOT NULL REFERENCES users (user_id),
        user_friend_id integer NOT NULL,
        status_id integer NOT NULL
);


create TABLE status (
        status_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        status_name varchar(40) NOT NULL
);

alter table frends_line add CONSTRAINT fl_status FOREIGN KEY (status_id) REFERENCES status;

alter table frends_line
alter status_id SET DEFAULT 2;


create TABLE likes_line (
        status_line_id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
        film_id integer NOT NULL REFERENCES film (film_id),
        user_id integer NOT NULL REFERENCES users (user_id)
);