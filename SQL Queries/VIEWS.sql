CREATE VIEW Institution_view
AS
SELECT Institution.institution_name,
       Institution.institution_contacts_website,
       Institution.inside_campus,
       InstitutionContacts.primary_phone,
       InstitutionContacts.secondary_phone,
       InstitutionContacts.email,
        [Institution].ID
        FROM Institution
        INNER JOIN InstitutionContacts
        ON Institution.institution_contacts_website = InstitutionContacts.website_url;


CREATE VIEW Person_view
AS
SELECT Person.first_name,
       Person.middle_name,
       Person.last_name,
       Person.contact_email,
       Person.gender,
       Person.city_shortcut,
       PersonContacts.phone_number,
       PersonContacts.phd_certificate,
       PersonContacts.bio,
       PersonContacts.image_ref,
       PersonContacts.base_faculty,
       Person.ID
FROM Person
         INNER JOIN PersonContacts
                    ON Person.contact_email = PersonContacts.email;


CREATE VIEW PersonRolesAndPermissions_view AS
SELECT Employees.person_id,
       Person_view.contact_email,
       Employees.role_name,
       Employees.desc_name,
       Employees.hiring_date,
       Employees.active,
       Employees.institution_id,
       Roles.role_priority_lvl,
       Roles.file_permissions_sum,
       Roles.folder_permissions_sum,
       Roles.institution_permissions_sum,
       Roles.person_permissions_sum,
       Institution.institution_level,
       Institution.institution_name
FROM Employees
         INNER JOIN Roles
                    ON PersonRoles.employee_title = EmployeesHierarchy.title
         INNER JOIN Person_view
                    ON PersonRoles.person_id = Person_view.ID
INNER JOIN Institution
ON Institution.ID=Employees.institution_id;

CREATE VIEW PersonsHierarchy_view
AS
SELECT Person_view.*,
       PersonRolesAndPermissions_view.employee_title,
       PersonRolesAndPermissions_view.priority_lvl,
       PersonRolesAndPermissions_view.job_description,
       PersonRolesAndPermissions_view.institution_id
FROM Person_view
         INNER JOIN PersonRolesAndPermissions_view
                    ON Person_view.contact_email = PersonRolesAndPermissions_view.email;


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


CREATE VIEW FolderWithCurrentVersion_view
AS
SELECT Folder.ID,
       Folder.parent_folder_id,
       Folder.date_created        AS folder_date_created,
       Folder.author_id           AS folder_author_id,
       Folder.current_folder_version,
       FolderVersion.version_name,
       FolderVersion.version_notes,
       FolderVersion.version_number,
       FolderVersion.date_created AS version_date_created,
       FolderVersion.author_id    AS version_author_id
FROM Folder
         INNER JOIN FolderVersion
                    ON Folder.current_folder_version = FolderVersion.ID;



CREATE VIEW FileWithCurrentVersion_view
AS
SELECT
        [File].ID,
        [File].parent_folder_id,
        [File].date_created AS file_date_created,
        [File].author_id AS file_author_id,
        [File].current_file_version,
        [File].locked,
        [File].locked_until,
        [File].active,
        FileVersion.version_name,
        FileVersion.version_notes,
        FileVersion.version_number,
        FileVersion.date_created AS version_date_created,
        FileVersion.author_id AS version_author_id,
        FileVersion.file_type_extension,
        FileVersion.file_content_id,
        FileContent.file_size AS file_version_size
        FROM [File]
        INNER JOIN FileVersion
        ON [File].current_file_version=FileVersion.ID
        INNER JOIN FileContent
        On FileVersion.file_content_id=FileContent.ID;


CREATE VIEW FileVersions_Type_Content_view
AS
SELECT FileVersion.ID,
       FileVersion.file_id,
       FileVersion.version_name,
       FileVersion.version_notes,
       FileVersion.version_number,
       FileVersion.date_created,
       FileVersion.author_id,
       FileVersion.file_type_extension,
       FileVersion.file_content_id,
       FileContent.file_size
FROM FileVersion
         INNER JOIN FileContent
                    ON FileVersion.file_content_id = FileContent.ID;

CREATE VIEW FilesAttachedToRoles_view
AS
SELECT
        [File].ID,
        [File].parent_folder_id,
        [File].date_created,
        [File].author_id,
        [File].current_file_version,
        [File].active,
        [File].locked,
        [File].locked_until,
        person_id,
        file_permissions_sum,
        exp_date,
        version_name,
        file_version_size,
        file_type_extension
        FROM [File]
        INNER JOIN PersonFileRoles
        ON PersonFileRoles.file_id=[File].ID
        INNER JOIN FileWithCurrentVersion_view
        ON [File].ID=FileWithCurrentVersion_view.ID;











