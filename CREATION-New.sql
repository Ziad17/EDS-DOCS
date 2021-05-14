CREATE TABLE PersonPermission
(
    [Name] VARCHAR(200) PRIMARY KEY NOT NULL,
    ArabicName NVARCHAR(200) NOT NULL
);

GO;

GO;
CREATE TABLE InstitutionPermission
(
 [Name] VARCHAR(200) PRIMARY KEY NOT NULL,
    ArabicName NVARCHAR(200) NOT NULL

);
GO;

CREATE TABLE City
(
    ID              INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Name]   NVARCHAR(200)           NOT NULL UNIQUE ,
    PostalCode INT                    NOT NULL UNIQUE
);
GO;


CREATE TABLE Employee
(
	ID              INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Name]      NVARCHAR(200)                     NOT NULL ,
    Gender          VARCHAR                         NOT NULL,
	Active                  BIT                             NOT NULL,
 
    AcadmicNumber VARCHAR(16) UNIQUE,
    CityID    INT                   NOT NULL,
    PrimaryRoleID INT,
    PhoneNumber    VARCHAR(11),
    PHD NVARCHAR(200) ,
    ImageURL       VARCHAR(max) ,
    Bio             NVARCHAR(max)
);
GO;
CREATE TABLE EmployeeCredentials
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,

Email VARCHAR(300) NOT NULL UNIQUE,
Password VARCHAR(max) NOT NULL,
EmployeeID INT NOT NULL UNIQUE
)
GO;
ALTER TABLE [dbo].[EmployeeCredentials]
ADD FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);


CREATE TABLE [Role]
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    ParentID            	INT          ,
    PriorityOrder  INT NOT NULL,
    ArabicName              NVARCHAR(200)   UNIQUE NOT NULL 

);
GO;
ALTER TABLE [Role]
    ADD FOREIGN KEY (ParentID) REFERENCES [Role] (ID);
    GO;

ALTER TABLE Employee
    ADD FOREIGN KEY (CityID) REFERENCES City (ID);
	
GO;


CREATE TABLE RolePersonPermission
(
RoleID INT NOT NULL,
PermissionName VARCHAR(200) NOT NULL,
  PRIMARY KEY(RoleID,PermissionName ));
GO;




CREATE TABLE RoleInstitutionPermission
(
RoleID INT NOT NULL,
PermissionName VARCHAR(200) NOT NULL,
 PRIMARY KEY(RoleID,PermissionName ));
GO;



ALTER TABLE RolePersonPermission
  ADD FOREIGN KEY (RoleID) REFERENCES Role (ID);

  ALTER TABLE RoleInstitutionPermission
  ADD FOREIGN KEY (RoleID) REFERENCES Role (ID);

GO;
CREATE TABLE EmployeeRole
(
	ID              INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
	EmployeeID INT NOT NULL,
	RoleID INT NOT NULL,
	InstitutionID INT NOT NULL,
    ArabicJobDesc       NVARCHAR(max)  ,
	HiringDate             DATETIME                        NOT NULL,
	 UNIQUE(EmployeeID,RoleID,InstitutionID )
);
GO;
ALTER TABLE Employee
ADD FOREIGN KEY (PrimaryRoleID) REFERENCES EmployeeRole (ID);

CREATE TABLE Institution
(
    ID                    INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    ArabicName      NVARCHAR(300)                   NOT NULL UNIQUE ,
    InstitutionTypeID   INT                   NOT NULL,
    Active    BIT                            NOT NULL,
    ParentID INT  ,
    Website   VARCHAR(max),
    ImageURL       VARCHAR(max),
    InsideCampus         BIT                            NOT NULL,
    PrimaryPhone         VARCHAR(300),
    SecondaryPhone       VARCHAR(300),
    Fax                   VARCHAR(300),
    Email                 VARCHAR(300)
);
GO;
ALTER TABLE EmployeeRole
    ADD FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);
	ALTER TABLE EmployeeRole
    ADD FOREIGN KEY (RoleID) REFERENCES Role (ID);
	ALTER TABLE EmployeeRole
    ADD FOREIGN KEY (InstitutionID) REFERENCES Institution (ID);
GO;

CREATE TABLE InstitutionType
(
    ID                           INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    ArabicName             NVARCHAR(max) NOT NULL ,
    Description NVARCHAR(max)
);
GO;
ALTER TABLE Institution
    ADD FOREIGN KEY (InstitutionTypeID) REFERENCES InstitutionType (ID);
    ALTER TABLE Institution
    ADD FOREIGN KEY (ParentID) REFERENCES Institution (ID);
GO;




CREATE TABLE InstitutionActionLog
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,

    EmployeeID                        INT      NOT NULL,
    InstitutionID                          INT      NOT NULL,
    ActionDate                      DATETIME NOT NULL,
    PermissionName VARCHAR(200)      NOT NULL
);
GO;
CREATE TABLE PersonActionLog
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,

    ConductorEmployeeID         INT      NOT NULL,
    AffectedEmployeeID          INT      NOT NULL,
      ActionDate                      DATETIME NOT NULL,
    PermissionName VARCHAR(200)      NOT NULL
);

GO;
ALTER TABLE PersonActionLog
    ADD FOREIGN KEY (ConductorEmployeeID) REFERENCES EmployeeRole (ID);
ALTER TABLE PersonActionLog
    ADD FOREIGN KEY (AffectedEmployeeID) REFERENCES Employee (ID);
ALTER TABLE PersonActionLog
    ADD FOREIGN KEY (PermissionName) REFERENCES PersonPermission (Name);
GO;
ALTER TABLE InstitutionActionLog
    ADD FOREIGN KEY (EmployeeID) REFERENCES EmployeeRole (ID);
ALTER TABLE InstitutionActionLog
    ADD FOREIGN KEY (InstitutionID) REFERENCES Institution (ID);
ALTER TABLE InstitutionActionLog
    ADD FOREIGN KEY (PermissionName) REFERENCES InstitutionPermission (Name);
GO;






                



 CREATE TABLE FileLevel
(
    Level      VARCHAR(2) PRIMARY KEY NOT NULL,
    LevelDesc NVARCHAR(max)
);
GO;




  CREATE TABLE FilePermission
(
 [Name] VARCHAR(200) PRIMARY KEY NOT NULL,
    ArabicName NVARCHAR(200) NOT NULL

);
GO;


CREATE TABLE [File]
(
    ID                INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(400) NOT NULL,
    DateCreatedSys     DATETIME   NOT NULL,
    DateCreated    DATETIME   NOT NULL,
    AuthorID            INT        NOT NULL,
    CurrentVersion INT        ,
    Active               BIT        NOT NULL,
    Locked               BIT        NOT NULL,
    LockedUntil         DATETIME,
    Level           VARCHAR(2) NOT NULL
);

GO;

ALTER TABLE [File]
    ADD FOREIGN KEY (AuthorID) REFERENCES EmployeeRole (ID);
      ALTER TABLE [File]
ADD FOREIGN KEY (Level) REFERENCES FileLevel (Level);
GO;



CREATE TABLE FilesScope
(
    Level        VARCHAR(2)   NOT NULL,
    RoleID INT NOT NULL,
    Permission VARCHAR(200) NOT NULL,

)

GO;
ALTER TABLE FilesScope
    ADD FOREIGN KEY (Level) REFERENCES FileLevel (Level);
ALTER TABLE FilesScope
    ADD FOREIGN KEY (RoleID) REFERENCES Role (ID);
ALTER TABLE FilesScope
    ADD FOREIGN KEY (Permission) REFERENCES FilePermission (Name);

  GO;


CREATE TABLE FileType
(
    Name VARCHAR(50) NOT NULL PRIMARY KEY,
    Extension VARCHAR(10) NOT NULL UNIQUE
);


GO;


CREATE TABLE FileContent
(
    ID        INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    Href      VARCHAR(3000)                  NOT NULL,
    FileSize INT                            NOT NULL
);

GO;
CREATE TABLE FileVersion
(
    ID                  INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    FileID             INT,
    Name        NVARCHAR(200)                   NOT NULL,
    Notes       NVARCHAR(1000),
    Number      FLOAT,
    DateCreatedSys    DATETIME                       NOT NULL,
    DateCreated   DATETIME                       NOT NULL,
    AuthorID           INT                            NOT NULL,
    FileTypeName VARCHAR(50)                    NOT NULL,
    FileContentID     INT                            NOT NULL UNIQUE
);
GO;

    ALTER TABLE [File]
ADD FOREIGN KEY (CurrentVersion) REFERENCES FileVersion (ID);
GO;
ALTER TABLE FileVersion
    ADD FOREIGN KEY (FileID) REFERENCES [File] (ID);
    ALTER TABLE FileVersion
    ADD FOREIGN KEY (AuthorID) REFERENCES EmployeeRole (ID);
    ALTER TABLE FileVersion
    ADD FOREIGN KEY (FileTypeName) REFERENCES FileType (Name);
      ALTER TABLE FileVersion
    ADD FOREIGN KEY (FileContentID) REFERENCES FileContent (ID);

        GO;


CREATE TABLE FileActionLog
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    EmployeeID                        INT      NOT NULL,
    FileID                          INT      NOT NULL,
    ActionDate                      DATETIME NOT NULL,
    PermissionName VARCHAR(200)      NOT NULL
);
GO;

ALTER TABLE FileActionLog
    ADD FOREIGN KEY (EmployeeID) REFERENCES EmployeeRole (ID);
ALTER TABLE FileActionLog
    ADD FOREIGN KEY (FileID) REFERENCES [File](ID);
ALTER TABLE FileActionLog
    ADD FOREIGN KEY (PermissionName) REFERENCES FilePermission (Name);
GO;



CREATE TABLE FileMention
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,

    FileID INT NOT NULL,
    EmployeeID INT NOT NULL,
    DateCreated INT NOT NULL
)


GO;
ALTER TABLE FileMention 
    ADD FOREIGN KEY (FileID) REFERENCES [File] (ID);
    ALTER TABLE FileMention 
    ADD FOREIGN KEY (EmployeeID) REFERENCES Employee (ID);



INSERT INTO City 
VALUES ('cairo',

        11865
       );



	   
	   INSERT INTO [dbo].[InstitutionType](ArabicName) VALUES(N'إدارة عامة');
INSERT INTO [dbo].[InstitutionType](ArabicName) VALUES(N'إدارة');
INSERT INTO [dbo].[InstitutionType](ArabicName) VALUES(N'قسم');
GO;


INSERT INTO InstitutionPermission
VALUES ( 'VIEW_PERSONS_IN_INSTITUTION',N'عرض أشخاص في مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'VIEW_INSTITUTION',N'عرض مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'CREATE_INSTITUTION',N'إنشاء مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'EDIT_INSTITUTION_INFO',N'تعديل معلومات مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'DELETE_INSTITUTION',N'مسح مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'CREATE_INSTITUTION_TYPE',N'إنشاء نوع مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'EDIT_INSTITUTION_TYPE',N'تعديل نوع مؤسسة');
INSERT INTO InstitutionPermission
VALUES ( 'CREATE_ROLE',N'إنشاء مسمى وظيفي');
INSERT INTO InstitutionPermission
VALUES ( 'EDIT_ROLE',N'تعديل مسمى وظيفي');
GO;


INSERT INTO FilePermission VALUES('EDIT_FILE_VERSION',N'')
INSERT INTO FilePermission VALUES('CREATE_FILE_VERSION',N'')
INSERT INTO FilePermission VALUES('VIEW_FILE_CURRENT_VERSION',N'')
INSERT INTO FilePermission VALUES('VIEW_FILE_ALL_VERSION',N'')
INSERT INTO FilePermission VALUES('DELETE_FILE_VERSION',N'')

GO;

INSERT INTO PersonPermission
VALUES ( 'VIEW_PERSON_PROFILE',N'عرض حساب شخص');
INSERT INTO PersonPermission
VALUES ( 'ATTACH_ROLE_TO_PERSON',N'تعيين وظيفة لشخص');
INSERT INTO PersonPermission
VALUES ( 'VIEW_ALL_PERSONS_HIERARCHY',N'عرض الهرم الوظيفي');
INSERT INTO PersonPermission
VALUES ( 'DEACTIVATE_PERSON_WITHIN_INSTITUTION',N'تعطيل حساب شخص');
INSERT INTO PersonPermission
VALUES ( 'CREATE_PERSON_WITHIN_INSTITUTION',N'تفعيل حساب شخص');
Go;


INSERT INTO Employee VALUES(N'زياد','M',1,'',1,null,'','','','')
INSERT INTO Employee VALUES(N'حالد','M',1,'1',1,null,'','','','')
INSERT INTO Employee VALUES(N'ابراهيم','M',1,'2',1,null,'','','','')

GO;
INSERT INTO [EmployeeCredentials] VALUES('ziad@gmail.com','11111111',1)
 GO;
 INSERT INTO [Role] VALUES(null,1,N'مدير عام');                    
INSERT INTO [Role] VALUES(1,2,N'مدير');
INSERT INTO [Role] VALUES(2,3,N'رئيس قسم');
GO;
INSERT INTO [dbo].[RolePersonPermission] VALUES(1,'VIEW_PERSON_PROFILE')
INSERT INTO [dbo].[RolePersonPermission] VALUES(1,'ATTACH_ROLE_TO_PERSON')
INSERT INTO [dbo].[RolePersonPermission] VALUES(1,'VIEW_ALL_PERSONS_HIERARCHY')
INSERT INTO [dbo].[RolePersonPermission] VALUES(1,'DEACTIVATE_PERSON_WITHIN_INSTITUTION')
INSERT INTO [dbo].[RolePersonPermission] VALUES(1,'CREATE_PERSON_WITHIN_INSTITUTION')
  GO;

INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'VIEW_PERSONS_IN_INSTITUTION')
INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'CREATE_INSTITUTION')
INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'EDIT_INSTITUTION_INFO')
INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'DELETE_INSTITUTION')
INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'CREATE_INSTITUTION_TYPE')
INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'EDIT_INSTITUTION_TYPE')
INSERT INTO [dbo].[RoleInstitutionPermission] VALUES(1,'CREATE_ROLE')

GO;
Insert INTO [dbo].[Institution] VALUES(N'إدارة الجامعة',1,1,null,'','',1,'','','','')

















       CREATE TABLE FolderLevel
(
    Level      VARCHAR(2) PRIMARY KEY NOT NULL,
    LevelDesc NVARCHAR(max)
);
   GO;
CREATE TABLE Folder
(
    ID                INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    ParentID  INT,
    DateCreatedSys  DATETIME                       NOT NULL,
    AuthorID         INT                            NOT NULL,
    Notes      NVARCHAR(1000),
    DateCreated DATETIME                       NOT NULL,
    Name              NVARCHAR(200)                   NOT NULL,
    Active            BIT                            NOT NULL,
    InstitutionID   INT NOT NULL,
    Level VARCHAR(2) NOT NULL

);
GO;
ALTER TABLE Folder
    ADD FOREIGN KEY (ParentID) REFERENCES Folder (ID);
ALTER TABLE Folder
    ADD FOREIGN KEY (AuthorID) REFERENCES EmployeeRole (ID);
ALTER TABLE Folder
    ADD FOREIGN KEY (InstitutionID) REFERENCES Institution (ID);
    ALTER TABLE Folder
    ADD FOREIGN KEY (Level) REFERENCES FolderLevel (Level);

   GO;


   CREATE TABLE FolderPermission
(
 [Name] VARCHAR(200) PRIMARY KEY NOT NULL,
    ArabicName NVARCHAR(200) NOT NULL

);
GO;
    CREATE TABLE FoldersScope
(
    Level        VARCHAR(2)   NOT NULL,
    RoleID INT NOT NULL,
    Permission VARCHAR(200) NOT NULL,

)

GO;
ALTER TABLE FoldersScope
    ADD FOREIGN KEY (Level) REFERENCES FolderLevel (ID);
    ALTER TABLE FoldersScope
    ADD FOREIGN KEY (RoleID) REFERENCES Role (ID);
    ALTER TABLE FoldersScope
    ADD FOREIGN KEY (Permission) REFERENCES FolderPermission (ID);
GO;

CREATE TABLE FolderActionLog
(
    ID                      INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,

     EmployeeID                        INT      NOT NULL,
    FolderID                          INT      NOT NULL,
    ActionDate                      DATETIME NOT NULL,
    PermissionName INT      NOT NULL
);
GO;

 ALTER TABLE FolderActionLog
    ADD FOREIGN KEY (EmployeeID) REFERENCES EmployeeRole (ID);
ALTER TABLE FolderActionLog
    ADD FOREIGN KEY (FolderID) REFERENCES Folder(ID);
ALTER TABLE FolderActionLog
    ADD FOREIGN KEY (PermissionName) REFERENCES FolderPermission (Name);
GO;



/*ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss*/






GO;
/*ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss*/





--CREATE TABLE NotificationType
--(
--    Name VARCHAR(100) NOT NULL PRIMARY KEY,
--    ArabicName NVARCHAR(300)

--);

--CREATE TABLE PersonNotification
--(
--    ID                    INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
--    EmployeeID             INT                             NOT NULL,
--    NotificationType     VARCHAR(100)                    NOT NULL,
--    Seen                  BIT                             NOT NULL,
--    FileID               INT                             NOT NULL,
--    MakerEmployeeID INT                             NOT NULL,
--    DateCreated          DATETIME                        NOT NULL
--);

--CREATE TABLE Attachments
--(
--    ID                    INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
--    SenderID             INT                             NOT NULL,
--    RecieverID           INT                             NOT NULL,
--    attachment_file_type  VARCHAR(50)                     NOT NULL,
--    date_sent             DATETIME                        NOT NULL,
--    notes                 VARCHAR(max),
--    attachment_content_id INT                             NOT NULL,
--    seen                  BIT                             NOT NULL
--);





















--                      /*To Delete All Constraints in sql azure*/
--                      SELECT 'ALTER TABLE ' + Table_Name  +' DROP CONSTRAINT ' + Constraint_Name
--FROM Information_Schema.CONSTRAINT_TABLE_USAGE


--/* the views needs to be edited to add role_front_name instead employee_job_desc*/
--CREATE VIEW Person_view
--AS
--SELECT Person.first_name,
--       Person.middle_name,
--       Person.last_name,
--       Person.contact_email,
--       Person.gender,
--       Person.academic_number,
--       City.city_name,
--       PersonContacts.phone_number,
--       PersonContacts.phd_certificate,
--       PersonContacts.bio,
--       PersonContacts.image_ref,
--       PersonContacts.base_faculty,
--       Person.ID
--FROM Person
--         INNER JOIN PersonContacts
--                    ON Person.contact_email = PersonContacts.email
--         INNER JOIN City
--                    ON Person.city_shortcut = City.shortcut;
--GO;
--CREATE VIEW PersonRolesAndPermissions_view AS
--SELECT Employees.person_id,
--       Person_view.contact_email,
--       Employees.role_id,
--       Employees.employee_job_desc,
--       Employees.hiring_date,
--       Employees.active,
--       Employees.institution_id,
--       Roles.role_priority_lvl,
--       Roles.role_front_name,
--       Roles.files_permissions_sum,
--       Roles.folders_permissions_sum,
--       Roles.institutions_permissions_sum,
--       Roles.persons_permissions_sum,
--       Institution.institution_level,
--       Institution.institution_name
--FROM Employees
--         INNER JOIN Roles
--                    ON Employees.role_id = Roles.ID
--         INNER JOIN Person_view
--                    ON Employees.person_id = Person_view.ID
--         INNER JOIN Institution
--                    ON Institution.ID = Employees.institution_id;

--GO;
--CREATE VIEW PersonsHierarchy_view
--AS SELECT Person_view.first_name,
--          Person_view.middle_name,
--          Person_view.last_name,
--          Person_view.contact_email,
--          Person_view.gender,
--          Person_view.city_name,
--          Person_view.phone_number,
--          Person_view.phd_certificate,
--          Person_view.bio,
--          Person_view.image_ref,
--          Person_view.base_faculty,
--          Person_view.ID,
--          Person_view.academic_number,
--    PersonRolesAndPermissions_view.role_id,
--          PersonRolesAndPermissions_view.role_front_name,

--          PersonRolesAndPermissions_view.role_priority_lvl,
--    PersonRolesAndPermissions_view.employee_job_desc,
--    PersonRolesAndPermissions_view.institution_id,
--          PersonRolesAndPermissions_view.institution_name

--   FROM Person_view
--    INNER JOIN PersonRolesAndPermissions_view
--    ON Person_view.ID = PersonRolesAndPermissions_view.person_id;

--GO;
--CREATE VIEW Notifications_view
--AS
--SELECT PersonNotification.ID,
--       PersonNotification.person_id,
--       PersonNotification.notification_type,
--       PersonNotification.seen,
--       PersonNotification.file_id,
--       PersonNotification.notification_maker_id,
--       PersonNotification.date_created,
--       Person_view.contact_email,
--       Person_view.first_name,
--       Person_view.middle_name,
--       Person_view.last_name
--FROM PersonNotification
--         INNER JOIN Person_view
--                    ON PersonNotification.notification_maker_id = Person_view.id;

--GO;
--CREATE VIEW FileWithCurrentVersion_view
--AS
--SELECT [File].ID,
--       [File].parent_folder_id,
--       [File].arch_date_created      AS file_date_created,
--       [File].author_id              AS file_author_id,
--       [File].current_file_version,
--       [File].locked,
--       [File].locked_until,
--       [File].active,
--       FileVersion.version_name,
--       FileVersion.version_notes,
--       FileVersion.version_number,
--       FileVersion.arch_date_created AS version_date_created,
--       FileVersion.author_id         AS version_author_id,
--       FileVersion.file_type_extension,
--       FileVersion.file_content_id,
--       FileContent.file_size         AS file_version_size
--FROM [File]
--         INNER JOIN FileVersion
--                    ON [File].current_file_version = FileVersion.ID
--         INNER JOIN FileContent
--                    On FileVersion.file_content_id = FileContent.ID;

--GO;
--CREATE VIEW FileVersions_Type_Content_view
--AS
--SELECT FileVersion.ID,
--       FileVersion.file_id,
--       FileVersion.version_name,
--       FileVersion.version_notes,
--       FileVersion.version_number,
--       FileVersion.arch_date_created,
--       FileVersion.author_id,
--       FileVersion.file_type_extension,
--       FileVersion.file_content_id,
--       FileContent.file_size
--FROM FileVersion
--         INNER JOIN FileContent
--                    ON FileVersion.file_content_id = FileContent.ID;
--Go;






--DROP VIEW FileVersions_Type_Content_view;
--GO;
--DROP VIEW FileWithCurrentVersion_view;
--GO;
--DROP VIEW Notifications_view;
--GO;
--DROP VIEW PersonsHierarchy_view;
--GO;
--DROP VIEW PersonRolesAndPermissions_view;
--GO;
--DROP VIEW Person_view;
















