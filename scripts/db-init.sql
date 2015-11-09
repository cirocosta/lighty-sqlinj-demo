/* 
 * Creates the 'domains' table which contains our 
 * virtual hosting data;
 */
CREATE TABLE domains(
  domain varchar(64) not null primary key,
  docroot varchar(128) not null
);

/* 
 * Insert virtual hosting info! 
 */
INSERT INTO domains VALUES ('redes.io', '/usr/lighttpd/redes/');
INSERT INTO domains VALUES ('mac5910.io', '/usr/lighttpd/mac5910/');
INSERT INTO domains VALUES ('mac0448.io', '/usr/lighttpd/mac0448/');

