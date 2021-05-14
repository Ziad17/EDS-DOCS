CREATE TABLE Person
(
    ID              INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    first_name      NVARCHAR(30)                     NOT NULL ,
    middle_name     NVARCHAR(50)                      ,
    last_name       NVARCHAR(30)                     NOT NULL ,
    user_password   NVARCHAR(40)                     NOT NULL ,
    contact_email   VARCHAR(300) UNIQUE,
    academic_number VARCHAR(16) UNIQUE,
    gender          VARCHAR                         NOT NULL,
    city_shortcut   VARCHAR(5)                      NOT NULL,
    active                  BIT                             NOT NULL


);

CREATE TABLE City
(
    shortcut    VARCHAR(5) PRIMARY KEY NOT NULL,
    city_name   NVARCHAR(200)           NOT NULL UNIQUE ,
    postal_code INT                    NOT NULL UNIQUE
);


CREATE TABLE PersonContacts
(
    email           VARCHAR(300) PRIMARY KEY NOT NULL,
    phone_number    VARCHAR(11),
    base_faculty    NVARCHAR(300),
    phd_certificate NVARCHAR(200) ,
    image_ref       VARCHAR(max) ,
    bio             NVARCHAR(max)
);

CREATE TABLE Employees
(
    /**/
    person_id               INT                             NOT NULL,
    role_id                 INT                    NOT NULL,
    institution_id          INT                             NOT NULL,
    hiring_date             DATETIME                        NOT NULL,
    employee_job_desc       NVARCHAR(max)  ,
    active                  BIT                             NOT NULL,
    PRIMARY KEY(person_id,role_id,institution_id )

);
CREATE TABLE Roles
(

    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    role_priority_lvl            INT          NOT NULL,
    role_front_name              NVARCHAR(200)   UNIQUE NOT NULL ,
    persons_permissions_sum      INT          NOT NULL,
    files_permissions_sum        INT          NOT NULL,
    institutions_permissions_sum INT          NOT NULL,
    folders_permissions_sum      INT          NOT NULL,


);

CREATE TABLE Institution
(
    ID                    INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    institution_name      NVARCHAR(300)                   NOT NULL UNIQUE ,
    institution_type_id   INT                   NOT NULL,
    institution_active    BIT                            NOT NULL,
    institution_parent_id INT,
    institution_website   VARCHAR(max),
    institution_img       VARCHAR(max),
    institution_level     INT,
    inside_campus         BIT                            NOT NULL,
    primary_phone         VARCHAR(300),
    secondary_phone       VARCHAR(300),
    fax                   VARCHAR(300),
    email                 VARCHAR(300)
);

CREATE TABLE InstitutionType
(
    ID                           INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    institution_type             NVARCHAR(max) NOT NULL ,
    institution_type_description NVARCHAR(max)
);

CREATE TABLE PersonPermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE,
    permission_front_name NVARCHAR(200) NOT NULL

);


CREATE TABLE FilePermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE,
    permission_front_name NVARCHAR(200) NOT NULL

);
CREATE TABLE InstitutionPermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE,
    permission_front_name NVARCHAR(200) NOT NULL

);

CREATE TABLE FolderPermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE,
    permission_front_name NVARCHAR(200) NOT NULL

);

CREATE TABLE FileActionLogs
(
    person_id                        INT      NOT NULL,
    file_id                          INT      NOT NULL,
    action_date                      DATETIME NOT NULL,
    file_permission_action_performed INT      NOT NULL
);
CREATE TABLE FolderActionLogs
(
    person_id                          INT      NOT NULL,
    folder_id                          INT      NOT NULL,
    action_date                        DATETIME NOT NULL,
    folder_permission_action_performed INT      NOT NULL
);
CREATE TABLE InstitutionActionLogs
(
    person_id                               INT      NOT NULL,
    institution_id                          INT      NOT NULL,
    action_date                             DATETIME NOT NULL,
    institution_permission_action_performed INT      NOT NULL
);
CREATE TABLE PersonActionLogs
(
    conductor_person_id         INT      NOT NULL,
    affected_person_id          INT      NOT NULL,
    action_date                 DATETIME NOT NULL,
    permission_action_performed INT      NOT NULL
);

CREATE TABLE NotificationTypes
(
    notification_name VARCHAR(100) NOT NULL PRIMARY KEY
);

CREATE TABLE PersonNotification
(
    ID                    INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    person_id             INT                             NOT NULL,
    notification_type     VARCHAR(100)                    NOT NULL,
    seen                  BIT                             NOT NULL,
    file_id               INT                             NOT NULL,
    notification_maker_id INT                             NOT NULL,
    date_created          DATETIME                        NOT NULL
);

CREATE TABLE Attachments
(
    ID                    INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    sender_id             INT                             NOT NULL,
    receiver_id           INT                             NOT NULL,
    attachment_file_type  VARCHAR(50)                     NOT NULL,
    date_sent             DATETIME                        NOT NULL,
    notes                 VARCHAR(max),
    attachment_content_id INT                             NOT NULL,
    seen                  BIT                             NOT NULL
);

CREATE TABLE Folder
(
    ID                INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    parent_folder_id  INT,
    sys_date_created  DATETIME                       NOT NULL,
    author_id         INT                            NOT NULL,
    folder_notes      VARCHAR(1000),
    arch_date_created DATETIME                       NOT NULL,

    name              VARCHAR(200)                   NOT NULL,

    active            BIT                            NOT NULL


);

CREATE TABLE [File]
(
    ID
                         INT
        IDENTITY
            (
            1,
            1
            ) PRIMARY KEY           NOT NULL,
    parent_folder_id     INT,
    sys_date_created     DATETIME   NOT NULL,
    arch_date_created    DATETIME   NOT NULL,
    author_id            INT        NOT NULL,
    current_file_version INT        NOT NULL,
    active               BIT        NOT NULL,
    locked               BIT        NOT NULL,
    locked_until         DATETIME,
    file_level           VARCHAR(2) NOT NULL,
    institution_file_id  INT        NOT NULL
);

CREATE TABLE FileLevel
(
    level      VARCHAR(2) PRIMARY KEY NOT NULL,
    level_desc VARCHAR(max)
);

CREATE TABLE FilesScope
(
    file_level        VARCHAR(2)   NOT NULL,
    available_to_role VARCHAR(200) NOT NULL,

)

CREATE TABLE FileType
(
    type_name VARCHAR(50) NOT NULL PRIMARY KEY,
    extension VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE FileVersion
(
    ID                  INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    file_id             INT,
    version_name        VARCHAR(200)                   NOT NULL,
    version_notes       VARCHAR(1000),
    version_number      FLOAT,
    sys_date_created    DATETIME                       NOT NULL,
    arch_date_created   DATETIME                       NOT NULL,

    author_id           INT                            NOT NULL,
    file_type_extension VARCHAR(10)                    NOT NULL,
    file_content_id     INT                            NOT NULL UNIQUE
);

CREATE TABLE FileContent
(
    ID        INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    href      VARCHAR(3000)                  NOT NULL,
    file_size INT                            NOT NULL
);


/*ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss*/
ALTER TABLE Person
    ADD FOREIGN KEY (contact_email) REFERENCES PersonContacts (email);

ALTER TABLE Person
    ADD FOREIGN KEY (city_shortcut) REFERENCES City (shortcut);


/*PersonContacts*/
ALTER TABLE PersonContacts
    ADD FOREIGN KEY (base_faculty) REFERENCES Institution (institution_name);


/* Employees Table*/
ALTER TABLE Employees
    ADD FOREIGN KEY (person_id) REFERENCES Person (ID);
ALTER TABLE Employees
    ADD FOREIGN KEY (role_id) REFERENCES Roles (ID);
ALTER TABLE Employees
    ADD FOREIGN KEY (institution_id) REFERENCES Institution (ID);


/* PersonActionLogs Table*/
ALTER TABLE PersonActionLogs
    ADD FOREIGN KEY (conductor_person_id) REFERENCES Person (ID);
ALTER TABLE PersonActionLogs
    ADD FOREIGN KEY (affected_person_id) REFERENCES Person (ID);
ALTER TABLE PersonActionLogs
    ADD FOREIGN KEY (permission_action_performed) REFERENCES PersonPermissions (bit_value);

/* FileActionLogs Table*/
ALTER TABLE FileActionLogs
    ADD FOREIGN KEY (person_id) REFERENCES Person (ID);
ALTER TABLE FileActionLogs
    ADD FOREIGN KEY (file_id) REFERENCES [File] (ID);
ALTER TABLE FileActionLogs
    ADD FOREIGN KEY (file_permission_action_performed) REFERENCES FilePermissions (bit_value);


/* FolderActionLogs Table*/
ALTER TABLE FolderActionLogs
    ADD FOREIGN KEY (person_id) REFERENCES Person (ID);
ALTER TABLE FolderActionLogs
    ADD FOREIGN KEY (folder_id) REFERENCES Folder (ID);
ALTER TABLE FolderActionLogs
    ADD FOREIGN KEY (folder_permission_action_performed) REFERENCES FolderPermissions (bit_value);

/* InstitutionActionLogs Table*/
ALTER TABLE InstitutionActionLogs
    ADD FOREIGN KEY (person_id) REFERENCES Person (ID);
ALTER TABLE InstitutionActionLogs
    ADD FOREIGN KEY (institution_id) REFERENCES Institution (ID);
ALTER TABLE InstitutionActionLogs
    ADD FOREIGN KEY (institution_permission_action_performed) REFERENCES InstitutionPermissions (bit_value);


/* PersonNotification Table*/
ALTER TABLE PersonNotification
    ADD FOREIGN KEY (person_id) REFERENCES Person (ID);
ALTER TABLE PersonNotification
    ADD FOREIGN KEY (notification_type) REFERENCES NotificationTypes (notification_name);
ALTER TABLE PersonNotification
    ADD FOREIGN KEY (file_id) REFERENCES [File] (ID);
ALTER TABLE PersonNotification
    ADD FOREIGN KEY (notification_maker_id) REFERENCES Person (ID);


/* Attachments Table*/
ALTER TABLE Attachments
    ADD FOREIGN KEY (sender_id) REFERENCES Person (ID);
ALTER TABLE Attachments
    ADD FOREIGN KEY (receiver_id) REFERENCES Person (ID);
ALTER TABLE Attachments
    ADD FOREIGN KEY (attachment_file_type) REFERENCES FileType (type_name);
ALTER TABLE Attachments
    ADD FOREIGN KEY (attachment_content_id) REFERENCES FileContent (ID);


/*Institution Table*/
ALTER TABLE Institution
    ADD FOREIGN KEY (institution_type_id) REFERENCES InstitutionType (ID);
ALTER TABLE Institution
    ADD FOREIGN KEY (institution_parent_id) REFERENCES Institution (ID);


/*Folder Table*/
ALTER TABLE Folder
    ADD FOREIGN KEY (parent_folder_id) REFERENCES Folder (ID);
ALTER TABLE Folder
    ADD FOREIGN KEY (author_id) REFERENCES Person (ID);


/* Files Scope*/
ALTER TABLE FilesScope
    ADD FOREIGN KEY (file_level) REFERENCES FileLevel (level);
ALTER TABLE FilesScope
    ADD FOREIGN KEY (available_to_role) REFERENCES Roles (role_name);


/*File Table*/
ALTER TABLE [File]
    ADD FOREIGN KEY (parent_folder_id) REFERENCES Folder (ID);
ALTER TABLE [File]
    ADD FOREIGN KEY (author_id) REFERENCES Person (ID);
ALTER TABLE [File]
    ADD FOREIGN KEY (current_file_version) REFERENCES FileVersion (ID);
ALTER TABLE [File]
    ADD FOREIGN KEY (file_level) REFERENCES FileLevel (level);
ALTER TABLE [File]
    ADD FOREIGN KEY (institution_file_id) REFERENCES Institution (ID);


/*FileVersion Table*/
ALTER TABLE FileVersion
    ADD FOREIGN KEY (file_id) REFERENCES [File] (ID);
ALTER TABLE FileVersion
    ADD FOREIGN KEY (author_id) REFERENCES Person (ID);
ALTER TABLE FileVersion
    ADD FOREIGN KEY (file_type_extension) REFERENCES FileType (extension);
ALTER TABLE FileVersion
    ADD FOREIGN KEY (file_content_id) REFERENCES FileContent (ID);

GO;
/*ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss*/

/* the views needs to be edited to add role_front_name instead employee_job_desc*/
CREATE VIEW Person_view
AS
SELECT Person.first_name,
       Person.middle_name,
       Person.last_name,
       Person.contact_email,
       Person.gender,
       Person.academic_number,
       City.city_name,
       PersonContacts.phone_number,
       PersonContacts.phd_certificate,
       PersonContacts.bio,
       PersonContacts.image_ref,
       PersonContacts.base_faculty,
       Person.ID
FROM Person
         INNER JOIN PersonContacts
                    ON Person.contact_email = PersonContacts.email
         INNER JOIN City
                    ON Person.city_shortcut = City.shortcut;
GO;
CREATE VIEW PersonRolesAndPermissions_view AS
SELECT Employees.person_id,
       Person_view.contact_email,
       Employees.role_id,
       Employees.employee_job_desc,
       Employees.hiring_date,
       Employees.active,
       Employees.institution_id,
       Roles.role_priority_lvl,
       Roles.role_front_name,
       Roles.files_permissions_sum,
       Roles.folders_permissions_sum,
       Roles.institutions_permissions_sum,
       Roles.persons_permissions_sum,
       Institution.institution_level,
       Institution.institution_name
FROM Employees
         INNER JOIN Roles
                    ON Employees.role_id = Roles.ID
         INNER JOIN Person_view
                    ON Employees.person_id = Person_view.ID
         INNER JOIN Institution
                    ON Institution.ID = Employees.institution_id;

GO;
CREATE VIEW PersonsHierarchy_view
AS SELECT Person_view.first_name,
          Person_view.middle_name,
          Person_view.last_name,
          Person_view.contact_email,
          Person_view.gender,
          Person_view.city_name,
          Person_view.phone_number,
          Person_view.phd_certificate,
          Person_view.bio,
          Person_view.image_ref,
          Person_view.base_faculty,
          Person_view.ID,
          Person_view.academic_number,
    PersonRolesAndPermissions_view.role_id,
          PersonRolesAndPermissions_view.role_front_name,

          PersonRolesAndPermissions_view.role_priority_lvl,
    PersonRolesAndPermissions_view.employee_job_desc,
    PersonRolesAndPermissions_view.institution_id,
          PersonRolesAndPermissions_view.institution_name

   FROM Person_view
    INNER JOIN PersonRolesAndPermissions_view
    ON Person_view.ID = PersonRolesAndPermissions_view.person_id;

GO;
CREATE VIEW Notifications_view
AS
SELECT PersonNotification.ID,
       PersonNotification.person_id,
       PersonNotification.notification_type,
       PersonNotification.seen,
       PersonNotification.file_id,
       PersonNotification.notification_maker_id,
       PersonNotification.date_created,
       Person_view.contact_email,
       Person_view.first_name,
       Person_view.middle_name,
       Person_view.last_name
FROM PersonNotification
         INNER JOIN Person_view
                    ON PersonNotification.notification_maker_id = Person_view.id;

GO;
CREATE VIEW FileWithCurrentVersion_view
AS
SELECT [File].ID,
       [File].parent_folder_id,
       [File].arch_date_created      AS file_date_created,
       [File].author_id              AS file_author_id,
       [File].current_file_version,
       [File].locked,
       [File].locked_until,
       [File].active,
       FileVersion.version_name,
       FileVersion.version_notes,
       FileVersion.version_number,
       FileVersion.arch_date_created AS version_date_created,
       FileVersion.author_id         AS version_author_id,
       FileVersion.file_type_extension,
       FileVersion.file_content_id,
       FileContent.file_size         AS file_version_size
FROM [File]
         INNER JOIN FileVersion
                    ON [File].current_file_version = FileVersion.ID
         INNER JOIN FileContent
                    On FileVersion.file_content_id = FileContent.ID;

GO;
CREATE VIEW FileVersions_Type_Content_view
AS
SELECT FileVersion.ID,
       FileVersion.file_id,
       FileVersion.version_name,
       FileVersion.version_notes,
       FileVersion.version_number,
       FileVersion.arch_date_created,
       FileVersion.author_id,
       FileVersion.file_type_extension,
       FileVersion.file_content_id,
       FileContent.file_size
FROM FileVersion
         INNER JOIN FileContent
                    ON FileVersion.file_content_id = FileContent.ID;
Go;






DROP VIEW FileVersions_Type_Content_view;
GO;
DROP VIEW FileWithCurrentVersion_view;
GO;
DROP VIEW Notifications_view;
GO;
DROP VIEW PersonsHierarchy_view;
GO;
DROP VIEW PersonRolesAndPermissions_view;
GO;
DROP VIEW Person_view;
















