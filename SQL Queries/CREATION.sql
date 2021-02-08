CREATE TABLE Person
(
    ID              INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    first_name      varchar(30) NOT NULL,
    middle_name     varchar(50),
    last_name       varchar(30) NOT NULL,
    user_password   VARCHAR(40) NOT NULL,
    contact_email   VARCHAR(300) UNIQUE,
    acadmeic_number VARCHAR(16) UNIQUE,
    gender          VARCHAR     NOT NULL,
    city_shortcut   VARCHAR(5)  NOT NULL UNIQUE
);

CREATE TABLE City
(
    shortcut    VARCHAR(5) PRIMARY KEY NOT NULL,
    city_name   VARCHAR(200)           NOT NULL UNIQUE,
    postal_code INT                    NOT NULL UNIQUE
);

CREATE TABLE PersonContacts
(
    email           VARCHAR(300) PRIMARY KEY NOT NULL,
    phone_number    VARCHAR(11) UNIQUE,
    phd_certificate VARCHAR(200),
    image_ref       VARCHAR(1000) UNIQUE,
    bio             TEXT
);


CREATE TABLE PersonRoles
(
    /**/
    person_id      INT          NOT NULL,
    employee_title VARCHAR(200) NOT NULL,
    institution_id INT          NOT NULL,
    hiring_date    DATETIME     NOT NULL,
    active         BIT          NOT NULL
);

CREATE TABLE PersonPermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE
);


CREATE TABLE EmployeesHierarchy
(
    title           VARCHAR(200) NOT NULL PRIMARY KEY,
    priority_lvl    INT          NOT NULL,
    permissions_sum INT          NOT NULL,
    job_description TEXT
);

CREATE TABLE PersonActionLogs
(
    affecter_person_id          INT      NOT NULL,
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
    ID                    INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    person_id             INT          NOT NULL,
    notification_type     VARCHAR(100) NOT NULL,
    seen                  BIT          NOT NULL,
    file_id               INT          NOT NULL,
    notification_maker_id INT          NOT NULL,
    date_created          DATETIME     NOT NULL
);

CREATE TABLE Attachments
(
    ID                    INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    sender_id             INT         NOT NULL,
    receiver_id           INT         NOT NULL,
    attachment_file_type  VARCHAR(50) NOT NULL,
    date_sent             DATETIME    NOT NULL,
    notes                 TEXT,
    attachment_content_id INT         NOT NULL,
    seen                  BIT         NOT NULL
);

CREATE TABLE Institution
(
    ID                           INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    institution_name             VARCHAR(300)  NOT NULL UNIQUE,
    institution_contacts_website VARCHAR(1000) NOT NULL UNIQUE,
    inside_campus                BIT           NOT NULL,
    institution_active           BIT           NOT NULL
);

CREATE TABLE InstitutionContacts
(
    website_url     VARCHAR(1000) NOT NULL PRIMARY KEY,
    primary_phone   VARCHAR(300),
    secondary_phone VARCHAR(300),
    fax             VARCHAR(300),
    email           VARCHAR(300)
);



CREATE TABLE Folder
(
    ID                     INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    parent_folder_id       INT      NOT NULL,
    date_created           DATETIME NOT NULL,
    author_id              INT      NOT NULL,
    current_folder_version INT      NOT NULL UNIQUE

);

CREATE TABLE FolderActionLogs
(
    person_id                          INT      NOT NULL,
    folder_id                            INT      NOT NULL,
    action_date                        DATETIME NOT NULL,
    folder_permission_action_performed INT      NOT NULL
);


CREATE TABLE FolderVersion
(
    ID             INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    version_name   VARCHAR(200) NOT NULL,
    version_notes  VARCHAR(1000),
    version_number FLOAT,
    folder_id      INT          NOT NULL,
    date_created   DATETIME     NOT NULL,
    author_id      INT          NOT NULL
);

CREATE TABLE [File]
(
    ID
    INT
    IDENTITY
(
    1,
    1
) PRIMARY KEY NOT NULL,
    parent_folder_id INT NOT NULL,
    date_created DATETIME NOT NULL ,
    author_id INT NOT NULL,
    current_file_version INT NOT NULL UNIQUE
    );


CREATE TABLE FileActionLogs
(
    person_id                          INT      NOT NULL,
    file_id                            INT      NOT NULL,
    action_date                        DATETIME NOT NULL,
    file_permission_action_performed INT      NOT NULL
);

CREATE TABLE FileType
(
    type_name VARCHAR(50) NOT NULL PRIMARY KEY,
    extension VARCHAR(10) NOT NULL UNIQUE
);


CREATE TABLE FileVersion
(
    ID                  INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    file_id             INT          NOT NULL,
    version_name        VARCHAR(200) NOT NULL,
    version_notes       VARCHAR(1000),
    version_number      FLOAT,
    date_created        DATETIME     NOT NULL,
    author_id           INT          NOT NULL,
    file_type_extension VARCHAR(10)  NOT NULL,
    file_content_id     INT          NOT NULL UNIQUE
);


CREATE TABLE FileContent
(
    ID        INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    href      VARCHAR(3000) NOT NULL,
    file_size INT           NOT NULL
);

CREATE TABLE PersonFolderRoles
(
    person_id              INT      NOT NULL,
    folder_id              INT      NOT NULL,
    folder_permissions_sum INT      NOT NULL,
    exp_date               DATETIME NOT NULL
);

CREATE TABLE PersonFileRoles
(
    person_id            INT      NOT NULL,
    file_id              INT      NOT NULL,
    file_permissions_sum INT      NOT NULL,
    exp_date             DATETIME NOT NULL
);

CREATE TABLE FilePermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE FolderPermissions
(
    bit_value       INT          NOT NULL PRIMARY KEY,
    permission_name VARCHAR(200) NOT NULL UNIQUE
);

