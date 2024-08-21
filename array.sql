-- table storing named arrays
CREATE TABLE array (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

-- table that stores the elements of each array
CREATE TABLE array_element (
    array_id INTEGER NOT NULL,
    idx INTEGER,
    value TEXT NOT NULL,
    
    PRIMARY KEY (array_id, idx),
    FOREIGN KEY (array_id) REFERENCES array(id)
);

-- array_view is data analyst friendly view on an array (max size 5)
CREATE VIEW array_view AS
SELECT a.name,
  MAX(CASE WHEN idx = 0 THEN value END) AS '0',
  MAX(CASE WHEN idx = 1 THEN value END) AS '1',
  MAX(CASE WHEN idx = 2 THEN value END) AS '2',
  MAX(CASE WHEN idx = 3 THEN value END) AS '3',
  MAX(CASE WHEN idx = 4 THEN value END) AS '4'
FROM array a
LEFT JOIN array_element ae ON a.id = ae.array_id
GROUP BY a.name;

-- create a few cases of arrays
INSERT INTO array (id, name) VALUES (0, 'exact');
INSERT INTO array_element (array_id, idx, value) VALUES (0, 0, 'a');
INSERT INTO array_element (array_id, idx, value) VALUES (0, 1, 'b');
INSERT INTO array_element (array_id, idx, value) VALUES (0, 2, 'c');
INSERT INTO array_element (array_id, idx, value) VALUES (0, 3, 'd');
INSERT INTO array_element (array_id, idx, value) VALUES (0, 4, 'e');

INSERT INTO array (id, name) VALUES (1, 'smaller');
INSERT INTO array_element (array_id, idx, value) VALUES (1, 0, 'h');
INSERT INTO array_element (array_id, idx, value) VALUES (1, 1, 'i');

INSERT INTO array (id, name) VALUES (2, 'larger');
INSERT INTO array_element (array_id, idx, value) VALUES (2, 0, '1');
INSERT INTO array_element (array_id, idx, value) VALUES (2, 1, '2');
INSERT INTO array_element (array_id, idx, value) VALUES (2, 2, '3');
INSERT INTO array_element (array_id, idx, value) VALUES (2, 3, '4');
INSERT INTO array_element (array_id, idx, value) VALUES (2, 4, '5');
INSERT INTO array_element (array_id, idx, value) VALUES (2, 5, '6');

INSERT INTO array (id, name) VALUES (3, 'nonseq');
INSERT INTO array_element (array_id, idx, value) VALUES (3, 1, 'x');

INSERT INTO array (id, name) VALUES (4, 'empty');

-- array_view
-- |  name  |    0 |    1 |    2 |    3 |    4 |
-- | ------ | ---- | ---- | ---- | ---- | ---- |
-- |  exact |    a |    b |    c |    d |    e |
-- |  small |    h |    i | NULL | NULL | NULL |
-- |  large |    1 |    2 |    3 |    4 |    5 |
-- | nonseq | NULL |    y | NULL | NULL | NULL |
-- |  empty | NULL | NULL | NULL | NULL | NULL |
