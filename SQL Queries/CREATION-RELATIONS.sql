
CREATE TABLE PersonFolderPermissions(
  person_id INT NOT NULL,
  folder_id INT NOT NULL,
  write_permission BIT NOT NULL,
  permission_exp_date DATETIME NOT NULL);

CREATE TABLE PersonFilePermissions(
  person_id INT NOT NULL,
  file_id INT NOT NULL,
  write_permission BIT NOT NULL,
  permission_exp_date DATETIME NOT NULL);


  
CREATE TABLE AdminPersonRequests(
  person_id INT NOT NULL,
  date_created DATETIME NOT NULL ,
  request_status BIT,
  request_exp_date DATETIME); 