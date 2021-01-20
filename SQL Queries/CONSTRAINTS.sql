/*Person Table*/
ALTER TABLE Person
ADD FOREIGN KEY (contact_email) REFERENCES PersonContacts(email);
ALTER TABLE Person
ADD FOREIGN KEY (institution_id) REFERENCES Institution(ID);
ALTER TABLE Person
ADD FOREIGN KEY (city_shortcut) REFERENCES City(shortcut);


/*Professor Table*/
ALTER TABLE Professor
ADD FOREIGN KEY (person_id) REFERENCES Person(ID);

/*Admin Table*/
ALTER TABLE [Admin]
ADD FOREIGN KEY (person_id) REFERENCES Person(ID);


/*Institution Table*/
ALTER TABLE Institution
ADD FOREIGN KEY (institution_contacts_website) REFERENCES InstitutionContacts(website_url);

/*Faculty Table*/
ALTER TABLE Faculty
ADD FOREIGN KEY (institution_id) REFERENCES Institution(ID);


/*Folder Table*/
ALTER TABLE Folder
ADD FOREIGN KEY (parent_folder_id) REFERENCES Folder(ID);
ALTER TABLE Folder
ADD FOREIGN KEY (author_id) REFERENCES Person(ID);
ALTER TABLE Folder
ADD FOREIGN KEY (current_folder_version) REFERENCES FolderVersion(ID);

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

ALTER TABLE [dbo].[File] ADD FOREIGN KEY (current_file_version) REFERENCES FileVersion(ID);


/*FileVersion Table*/
ALTER TABLE FileVersion
ADD FOREIGN KEY (file_id) REFERENCES [File](ID);
ALTER TABLE FileVersion
ADD FOREIGN KEY (author_id) REFERENCES Person(ID);
ALTER TABLE FileVersion
ADD FOREIGN KEY (file_type_extension) REFERENCES FileType(extension);
ALTER TABLE FileVersion
ADD FOREIGN KEY (file_content_id) REFERENCES FileContent(ID);


