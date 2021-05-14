
INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)
VALUES ('cairo',
        'CA',
        11865
       );


INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('alexandria',
        'ALEX',
        21500
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('giza',
        'GIZA',
        12511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES (N'شبرا الخيمة',
        'SHUB',
        13752
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES (N'بورسعيد',
        'PS',
        42511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('suez',
        'SUEZ',
        43511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('luxor',
        'LUX',
        85951
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('mansoura',
        'MANS',
        35511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('Elmahalla el kubra',
        'MK',
        31951

       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('tanta',
        'TAN',
        31511
       );



INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('assiut',
        'ASUT',
        71515
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)
VALUES ('ismailia',
        'ISMA',
        41523
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)
VALUES ('fayyum',
        'FAY',
        63514

       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('zagazig',
        'ZAG',
        44523
       );


INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('aswan',
        'ASW',
        81528
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('damietta',
        'DAMT',
        34511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('damanhour',
        'DMNHR',
        22511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('minya',
        'MIN',
        61111
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('beni suef',
        'BS',
        62511
       );


INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('qena',
        'QENA',
        83522
       );
INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('suhag',
        'SUH',
        82749
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('hurghada',
        'HR',
        84517
       );



INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('6 october',
        'SO',
        12573
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('shebin elkom',
        'SK',
        13829
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('banha',
        'BANHA',
        13511
       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('kafr elshiekh',
        'KFS',
        33511

       );

INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('arish',
        'ARISH',
        45511
       );


INSERT INTO City (
    City.city_name,
    City.shortcut,
    City.postal_code
)

VALUES ('marsa matrouh',
        'MM',
        51717
       );
GO;


INSERT INTO PersonContacts VALUES('admin@kfsdocs.com','01285620713','إدارة الجامعة',null,null,null);
GO;
INSERT INTO Person(first_name,middle_name,last_name,user_password,contact_email,academic_number,
                   gender,city_shortcut,active) VALUES('ziad','mohamed','fathy','7Z7rwgjbjn0=','admin@kfsdocs.com','1234567891234567','M','ALEX',1);
/*the encrypted password is 11111111*/
GO;
INSERT INTO [dbo].[InstitutionType](institution_type) VALUES(N'إدارة عامة');
INSERT INTO [dbo].[InstitutionType](institution_type) VALUES(N'إدارة');
INSERT INTO [dbo].[InstitutionType](institution_type) VALUES(N'قسم');
GO;
INSERT INTO [dbo].[Institution](institution_name,institution_type_id,institution_active,institution_parent_id,institution_website,institution_img,institution_level,inside_campus,primary_phone,secondary_phone
                               ,fax,email) VALUES(N'إدارة الجامعة',1,1,null,'http://www.kfs.edu.eg/',null,1,1,'null','null','null','null')
GO;
UPDATE [dbo].[Institution] SET institution_parent_id=1;
GO;
INSERT INTO PersonPermissions
VALUES (1, 'VIEW_PERSON_PROFILE',N'عرض حساب شخص');
INSERT INTO PersonPermissions
VALUES (2, 'VIEW_ALL_PERSONS_HIERARCHY',N'عرض الهرم الوظيفي');
INSERT INTO PersonPermissions
VALUES (4, 'DEACTIVATE_PERSON_WITHIN_INSTITUTION',N'تعطيل حساب شخص');
INSERT INTO PersonPermissions
VALUES (8, 'CREATE_PERSON_WITHIN_INSTITUTION',N'تفعيل حساب شخص');
Go;
INSERT INTO InstitutionPermissions
VALUES (1, 'VIEW_PERSONS_IN_INSTITUTION',N'عرض أشخاص في مؤسسة');
INSERT INTO InstitutionPermissions
VALUES (2, 'CREATE_INSTITUTION',N'إنشاء مؤسسة');
INSERT INTO InstitutionPermissions
VALUES (4, 'EDIT_INSTITUTION',N'تعديل مؤسسة');
INSERT INTO InstitutionPermissions
VALUES (8, 'DELETE_INSTITUTION',N'مسح مؤسسة');
INSERT INTO InstitutionPermissions
VALUES (16, 'CREATE_INSTITUTION_TYPE',N'إنشاء نوع مؤسسة');
INSERT INTO InstitutionPermissions
VALUES (32, 'EDIT_INSTITUTION_TYPE',N'تعديل نوع مؤسسة');
INSERT INTO InstitutionPermissions
VALUES (64, 'CREATE_ROLE',N'إنشاء مسمى وظيفي');
INSERT INTO InstitutionPermissions
VALUES (128, 'EDIT_ROLE',N'تعديل مسمى وظيفي');
GO;
INSERT INTO [dbo].[Roles](role_priority_lvl,role_front_name,persons_permissions_sum,
                          files_permissions_sum,institutions_permissions_sum,folders_permissions_sum)
                          VALUES(1,N'مدير عام',15,0,255,0);
						  INSERT INTO Roles VALUES(2,N'مدير',15,0,255,0);
						  INSERT INTO Roles VALUES(3,N'رئيس قسم',15,0,255,0);
INSERT INTO Roles VALUES(3,N'مشرف',15,0,255,0);
						  INSERT INTO Roles VALUES(2,N'مشرف عام',15,0,255,0);
						  INSERT INTO Roles VALUES(3,N'محرر',15,0,255,0);
						  INSERT INTO Roles VALUES(3,N'موظف',15,0,255,0);




Go;
INSERT INTO [dbo].[Employees] VALUES(1,1,1,GETDATE(),'رئيس الجامعة',1);
