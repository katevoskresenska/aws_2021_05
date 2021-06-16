CREATE DATABASE test_postgres;

CREATE TABLE a_table (
    id_column bigserial primary key,
    text_column varchar(20) NOT NULL,
    date_column timestamp default NULL
);

INSERT INTO a_table VALUES (1, 'text1', current_timestamp);
INSERT INTO a_table VALUES (2, 'text2', current_timestamp);
INSERT INTO a_table VALUES (3, 'text3', current_timestamp);

SELECT * FROM a_table;
