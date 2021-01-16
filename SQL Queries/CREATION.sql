CREATE TABLE Person (
  ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
  first_name varchar(17) NOT NULL,
  middle_name varchar(30),
  last_name varchar(17) NOT NULL,
  contact_email varchar(100) UNIQUE,
  birth_date DATE NOT NULL,
  institution_id INT NOT NULL UNIQUE,
  city_shortcut VARCHAR(5) NOT NULL UNIQUE);

CREATE TABLE City(
  shortcut VARCHAR(5) PRIMARY KEY NOT NULL,
  city_name VARCHAR(30) NOT NULL UNIQUE,
  postal_code INT NOT NULL UNIQUE);

CREATE TABLE PersonContacts(
email VARCHAR(100) PRIMARY KEY NOT NULL,
phone_number VARCHAR(11) NOT NULL UNIQUE);

CREATE TABLE Professor(
  person_id INT NOT NULL UNIQUE,
  acadmic_number VARCHAR(16) NOT NULL UNIQUE,
  phd_certificate VARCHAR(100));

CREATE TABLE [Admin](
 person_id INT NOT NULL UNIQUE);

CREATE TABLE Institution(
  ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  institution_name VARCHAR(50) NOT NULL UNIQUE,
  institution_contacts_website VARCHAR NOT NULL UNIQUE,
  inside_campus BOOLEAN NOT NULL,
  active BOOLEAN NOT NULL  );

CREATE TABLE InstitutionContacts(
  website_url VARCHAR NOT NULL PRIMARY KEY,
  primary_phone VARCHAR,
  secondary_phone VARCHAR,
  fax VARCHAR,
  email VARCHAR);

CREATE TABLE Faculty(institution_id INT NOT NULL UNIQUE);
CREATE TABLE DataCenter(institution_id INT NOT NULL UNIQUE);


CREATE TABLE Folder(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
parent_folder_id INT NOT NULL,
date_created DATETIME NOT NULL DEFAULT GETDATE,
author_id INT NOT NULL,
current_folder_version INT NOT NULL UNIQUE

);

CREATE TABLE FolderVersion(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
version_name VARCHAR(200) NOT NULL,
version_notes VARCHAR(1000),
version_number FLOAT,
folder_id INT NOT NULL,
date_created DATETIME NOT NULL DEFAULT GETDATE,
author_id INT NOT NULL
);

CREATE TABLE [File](
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
parent_folder_id INT NOT NULL,
date_created DATETIME NOT NULL DEFAULT GETDATE,
author_id INT NOT NULL,
current_file_version INT NOT NULL UNIQUE
);

CREATE TABLE FileType(
type_name VARCHAR NOT NULL UNIQUE,
extension VARCHAR NOT NULL UNIQUE
);


CREATE TABLE FileVersion(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
file_id INT NOT NULL,
version_name VARCHAR(200) NOT NULL,
version_notes VARCHAR(1000),
version_number FLOAT,
date_created DATETIME NOT NULL DEFAULT GETDATE,
author_id INT NOT NULL,
file_type_extension VARCHAR NOT NULL,
file_content_id INT NOT NULL UNIQUE
);


CREATE TABLE FileContent(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
href VARCHAR NOT NULL
);







