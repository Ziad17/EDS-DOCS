/*Person Table*/
ALTER TABLE Person
ADD FOREIGN KEY (contact_email) REFERENCES PersonContacts(email);

ALTER TABLE Person
ADD FOREIGN KEY (city_shortcut) REFERENCES City(shortcut);




/* PersonRoles Table*/
ALTER TABLE PersonRoles
ADD FOREIGN KEY (person_id) REFERENCES Person(ID);
ALTER TABLE PersonRoles
ADD FOREIGN KEY (employee_title) REFERENCES EmployeesHierarchy(title);
ALTER TABLE PersonRoles
ADD FOREIGN KEY (institution_id) REFERENCES Institution(ID);



/* PersonActionLogs Table*/
ALTER TABLE PersonActionLogs
ADD FOREIGN KEY (affecter_person_id) REFERENCES Person(ID);
ALTER TABLE PersonActionLogs
ADD FOREIGN KEY (affected_person_id) REFERENCES Person(ID);
ALTER TABLE PersonActionLogs
ADD FOREIGN KEY (permission_action_performed) REFERENCES PersonPermissions(bit_value);

/* PersonNotification Table*/
ALTER TABLE PersonNotification
ADD FOREIGN KEY (person_id) REFERENCES Person(ID);
ALTER TABLE PersonNotification
ADD FOREIGN KEY (notification_type) REFERENCES NotificationTypes(notification_name);
ALTER TABLE PersonNotification
ADD FOREIGN KEY (file_id) REFERENCES [File](ID);
ALTER TABLE PersonNotification
ADD FOREIGN KEY (notification_maker_id) REFERENCES Person(ID);


/* Attachments Table*/
ALTER TABLE Attachments
ADD FOREIGN KEY (sender_id) REFERENCES Person(ID);
ALTER TABLE Attachments
ADD FOREIGN KEY (receiver_id) REFERENCES Person(ID);
ALTER TABLE Attachments
ADD FOREIGN KEY (attachment_file_type) REFERENCES FileType(type_name);
ALTER TABLE Attachments
ADD FOREIGN KEY (attachment_content_id) REFERENCES FileContent(ID);




/*Institution Table*/
ALTER TABLE Institution
ADD FOREIGN KEY (institution_contacts_website) REFERENCES InstitutionContacts(website_url);




/*Folder Table*/
ALTER TABLE Folder
ADD FOREIGN KEY (parent_folder_id) REFERENCES Folder(ID);
ALTER TABLE Folder
ADD FOREIGN KEY (author_id) REFERENCES Person(ID);
ALTER TABLE Folder
ADD FOREIGN KEY (current_folder_version) REFERENCES FolderVersion(ID);


ALTER TABLE FolderActionLogs
    ADD FOREIGN KEY (person_id) REFERENCES Person(ID);
ALTER TABLE FolderActionLogs
    ADD FOREIGN KEY (folder_id) REFERENCES [Folder](ID);
ALTER TABLE FolderActionLogs
    ADD FOREIGN KEY (folder_permission_action_performed) REFERENCES FolderPermissions(bit_value);

/*FolderVersion Table*/
ALTER TABLE FolderVersion
ADD FOREIGN KEY (folder_id) REFERENCES Folder(ID);
ALTER TABLE FolderVersion
ADD FOREIGN KEY (author_id) REFERENCES Person(ID);


/*File Table*/
ALTER TABLE [File]
ADD FOREIGN KEY (parent_folder_id) REFERENCES Folder(ID);
ALTER TABLE [File]
ADD FOREIGN KEY (author_id) REFERENCES Person(ID);
ALTER TABLE [File] 
ADD FOREIGN KEY (current_file_version) REFERENCES FileVersion(ID);

ALTER TABLE FileActionLogs
    ADD FOREIGN KEY (person_id) REFERENCES Person(ID);
ALTER TABLE FileActionLogs
    ADD FOREIGN KEY (file_id) REFERENCES [File](ID);
ALTER TABLE FileActionLogs
    ADD FOREIGN KEY (file_permission_action_performed) REFERENCES FilePermissions(bit_value);


/*FileVersion Table*/
ALTER TABLE FileVersion
ADD FOREIGN KEY (file_id) REFERENCES [File](ID);
ALTER TABLE FileVersion
ADD FOREIGN KEY (author_id) REFERENCES Person(ID);
ALTER TABLE FileVersion
ADD FOREIGN KEY (file_type_extension) REFERENCES FileType(extension);
ALTER TABLE FileVersion
ADD FOREIGN KEY (file_content_id) REFERENCES FileContent(ID);


/*PersonFolderRoles Table*/
ALTER TABLE PersonFolderRoles
ADD FOREIGN KEY (folder_id) REFERENCES Folder(ID);
ALTER TABLE PersonFolderRoles
ADD FOREIGN KEY (person_id) REFERENCES Person(ID);


/*PersonFileRoles Table*/
ALTER TABLE PersonFileRoles
ADD FOREIGN KEY (file_id) REFERENCES File(ID);
ALTER TABLE PersonFileRoles
ADD FOREIGN KEY (person_id) REFERENCES Person(ID);




