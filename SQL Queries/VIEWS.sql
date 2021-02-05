CREATE VIEW Institutuion_view
AS
SELECT Institution.institution_name,
Institution.institution_contacts_website,
Institution.inside_campus,
InstitutionContacts.primary_phone,
InstitutionContacts.secondary_phone,
InstitutionContacts.email
FROM Institution
INNER JOIN InstitutionContacts
ON Institution.institution_contacts_website=InstitutionContacts.website_url;




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
       PersonContacts.bio
FROM Perosn
INNER JOIN PerosnContacts
ON Person.contact_email=PersonContacts.email;


CREATE VIEW PersonRolesAndPermissions_view
AS
SELECT PersonRoles.person_id,
       Person.email
       PersonRoles.employee_title,
       PersonRoles.institution_id,
       PersonRoles.hiring_date,
       PersonRoles.active,
       EmployeesHierarchy.priority_lvl,
       EmployeesHierarchy.permissions_sum,
       EmployeesHierarchy.job_description
FROM PersonRoles
INNER JOIN EmployeesHierarchy
ON PersonRoles.employee_title=EmployeesHierarchy.title
INNER JOIN Person_view
ON PersonRoles.person_id=Person_view.contact_email;


CREATE VIEW PersonsHierarchy_view
AS
SELECT Person_view.*,
       PersonRolesAndPermissions_view.employee_title,
       PersonRolesAndPermissions_view.priority_lvl,
       PersonRolesAndPermissions_view.job_description,
       PersonRolesAndPermissions_view.institution_id
FROM Person_view
INNER JOIN PersonRolesAndPermissions_view
ON Person_view.contact_email=PersonRolesAndPermissions_view.email;






