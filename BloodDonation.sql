/*1-)Creating Database*/
CREATE DATABASE BloodDonation;
/*DROP DATABASE BloodDonation;*/
/*2-)Creating Table*/
CREATE TABLE IDENTITY_( 
           IDNo varchar(50) NOT NULL UNIQUE,
           Name varchar(50) NOT NULL,
           Surname varchar(50) NOT NULL,
           Sex varchar(50) NOT NULL,
           FatherName varchar(50) NOT NULL,
           MotherName varchar(50) NOT NULL,
           BirthPlace varchar(50) NOT NULL,
           BirthDate  datetime NOT NULL,
           MaritalStatus char(10) NOT NULL,
           Religion varchar(50) NOT NULL,
           Province varchar(50) NOT NULL,
           District varchar(50) NOT NULL,
           Street varchar(50) NOT NULL,
           MaidenName varchar(50) NULL,
);
CREATE TABLE ADDRESS_( 
           AddressID integer NOT NULL IDENTITY(1,1),
           AddressProvince varchar(50) NOT NULL,
           AddressDistrict varchar(50) NOT NULL,
           AddressStreet varchar(50) NOT NULL,
           BuildingNumber integer NOT NULL,
           ApartmentNumber integer NULL,
);
CREATE TABLE RELATIVE_( 
           RelativeID integer NOT NULL IDENTITY(1,1),
           RelativeName varchar(50) NOT NULL,
           RelativeSurname varchar(50) NOT NULL,
           RelativeSex varchar(50)    NULL,
           RelativeEmail varchar(50)  NULL,
		   BloodID integer NOT NULL,

);
CREATE TABLE BLOOD( 
           BloodID integer NOT NULL IDENTITY(1,1),
           BloodType varchar(50) NOT NULL,
     
);	
CREATE TABLE DISEASE( 
           DiseaseID integer NOT NULL IDENTITY(1,1),
           DiseaseName varchar(50) NOT NULL,
		   IncubationPeriod numeric(5,1) NULL,
		   DayofConvalescence numeric(5,1) NULL,

);	
CREATE TABLE DONOR_DISEASE(          
           Status_ varchar(1000) NULL,
		   AbilityOfBloodDonation BIT NOT NULL,
		   DiseaseID integer NOT NULL,
           DonorID integer NOT NULL,
);	
CREATE TABLE PHLEBOTOMIST(          
           PhlebotomistID integer NOT NULL IDENTITY(1,1),
           PhlebotomistName varchar(50) NOT NULL,
		   PhlebotomistSurname varchar(50) NOT NULL,
		   BloodCenterID integer NOT NULL,	
);
CREATE TABLE BLOODCENTER(          
           BloodCenterID integer NOT NULL IDENTITY(1,1),
           BloodCenterName varchar(50) NOT NULL,
		   AddressID integer NOT NULL,

);
CREATE TABLE PHONE(      
           PhoneID integer NOT NULL IDENTITY(1,1),
           MobileNumber varchar(11)  NULL,
		   HomePhoneNumber varchar(11)  NULL,
		   DonorID integer NULL,
		   RelativeID integer NULL,
		   BloodCenterID integer NULL,

);
CREATE TABLE BLOODCENTER_BLOOD(          
           BloodID integer NOT NULL,
           BloodCenterID integer NOT NULL,
		   UnitStock integer NOT NULL,

);
CREATE TABLE RELATIVE_DONOR(          
           RelativeID integer NOT NULL,
           DonorID integer NOT NULL,
		   
);
CREATE TABLE ADDRESS_DONOR(          
           AddressID integer NOT NULL,
           DonorID integer NOT NULL,

);
CREATE TABLE DONOR_BLOODCENTER(          
           PhlebotomistID integer NOT NULL,
		   BloodCenterID integer NOT NULL,
           DonorID integer NOT NULL,
		   DonationDate Datetime2 NOT NULL,		   
);
/*ALTER TABLE DONOR_BLOODCENTER ALTER COLUMN DonationDate Datetime2 NOT NULL;*/
CREATE TABLE DONOR( 
           DonorID integer NOT NULL IDENTITY(1,1),         
           Email varchar(50) NULL,
		   Job varchar(50) NULL,
           EducationalStatus varchar(50) NULL,
		   Height integer NULL,
		   Weightt integer NOT NULL,
		   BloodID integer NOT NULL,
		   IDNo varchar(50) NOT NULL UNIQUE,		   
);

/*3-)Creating constraint between of tables.*/
ALTER TABLE IDENTITY_ ADD
		    CONSTRAINT IDNoPK PRIMARY KEY(IDNo),
            CONSTRAINT SexCheck CHECK(Sex IN('Male','Female')),
		    CONSTRAINT MaritalStatusCheck CHECK(MaritalStatus IN('Married','Single'));
ALTER TABLE ADDRESS_ ADD
		   CONSTRAINT AddressIDPK PRIMARY KEY(AddressID),
		   CONSTRAINT AddressIDAK1 UNIQUE(AddressID);
ALTER TABLE BLOOD ADD
		   CONSTRAINT BloodIDPK PRIMARY KEY(BloodID),
		   CONSTRAINT BloodIDAK1 UNIQUE(BloodID),
		   /*CONSTRAINT BloodTypeAK2 UNIQUE(BloodType), Belki olabilir */
           CONSTRAINT BloodTypeCheck CHECK(BloodType IN('0Rh(-)','0Rh(+)','ARh(+)','ARh(-)','BRh(+)','BRh(-)','ABRh(+)','ABRh(-)'));
ALTER TABLE RELATIVE_ ADD 
		   CONSTRAINT RelativeIDPK PRIMARY KEY(RelativeID),
		   CONSTRAINT RelativeIDAK1 UNIQUE(RelativeID),
           CONSTRAINT RelativeSexCheck CHECK(RelativeSex IN('Male','Female')),	
		   CONSTRAINT BloodIDFK	FOREIGN KEY(BloodID) REFERENCES BLOOD(BloodID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE DISEASE ADD
		   CONSTRAINT DiseaseIDPK PRIMARY KEY(DiseaseID),
		   CONSTRAINT DiseaseIDAK1 UNIQUE(DiseaseID),
		   CONSTRAINT DiseaseNameAK2 UNIQUE(DiseaseName);
ALTER TABLE DONOR ADD
           CONSTRAINT DonorID PRIMARY KEY(DonorID),
		   CONSTRAINT DonorIDAK1 UNIQUE(DonorID),
		   CONSTRAINT EmailAK2 UNIQUE(Email),
		   CONSTRAINT BloodIDFK2 FOREIGN KEY(BloodID) REFERENCES BLOOD(BloodID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT IDNoFK	FOREIGN KEY(IDNo) REFERENCES IDENTITY_(IDNo)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;		
ALTER TABLE DONOR_DISEASE ADD
		   CONSTRAINT DiseaseIDFK	FOREIGN KEY(DiseaseID) REFERENCES DISEASE(DiseaseID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT DonorIDFK	FOREIGN KEY(DonorID) REFERENCES DONOR(DonorID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE BLOODCENTER ADD
		   CONSTRAINT BloodCenterIDPK PRIMARY KEY(BloodCenterID),
		   CONSTRAINT BloodCenterIDAK1 UNIQUE(BloodCenterID),
		   CONSTRAINT AddressIDFK	FOREIGN KEY(AddressID) REFERENCES ADDRESS_(AddressID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE PHLEBOTOMIST ADD
		   CONSTRAINT PhlebotomistIDPK PRIMARY KEY(PhlebotomistID),
		   CONSTRAINT PhlebotomistIDAK1 UNIQUE(PhlebotomistID),
		   CONSTRAINT BloodCenterIDFK	FOREIGN KEY(BloodCenterID) REFERENCES BLOODCENTER(BloodCenterID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE PHONE ADD 
		   CONSTRAINT PhoneIDPK PRIMARY KEY(PhoneID),
		   CONSTRAINT PhoneIDAK1 UNIQUE(PhoneID),		  
		   CONSTRAINT DonorIDFK2 FOREIGN KEY(DonorID) REFERENCES DONOR(DonorID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT RelativeIDFK	FOREIGN KEY(RelativeID) REFERENCES RELATIVE_(RelativeID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,	
		   CONSTRAINT BloodCenterIDFK2 FOREIGN KEY(BloodCenterID) REFERENCES BLOODCENTER(BloodCenterID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE BLOODCENTER_BLOOD ADD 
		   CONSTRAINT BloodIDFK3 FOREIGN KEY(BloodID) REFERENCES BLOOD(BloodID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT BloodCenterIDFK3 FOREIGN KEY(BloodCenterID) REFERENCES BLOODCENTER(BloodCenterID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE RELATIVE_DONOR ADD 
		   CONSTRAINT RelativeIDFK2	FOREIGN KEY(RelativeID) REFERENCES RELATIVE_(RelativeID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT DonorIDFK3 FOREIGN KEY(DonorID) REFERENCES DONOR(DonorID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE ADDRESS_DONOR ADD 
		   CONSTRAINT AddressIDFK2	FOREIGN KEY(AddressID) REFERENCES ADDRESS_(AddressID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT DonorIDFK4	FOREIGN KEY(DonorID) REFERENCES DONOR(DonorID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;
ALTER TABLE DONOR_BLOODCENTER ADD 
		   CONSTRAINT PhlebotomistIDFK	FOREIGN KEY(PhlebotomistID) REFERENCES PHLEBOTOMIST(PhlebotomistID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT BloodCenterIDFK4	FOREIGN KEY(BloodCenterID) REFERENCES BLOODCENTER(BloodCenterID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION,
		   CONSTRAINT DonorIDFK5	FOREIGN KEY(DonorID) REFERENCES DONOR(DonorID)
		   ON DELETE NO ACTION
		   ON UPDATE NO ACTION;

/*4-)Creating Procedure and Adding process with procedures.*/
/*1*/
/*
CREATE PROCEDURE InsertValueBLOOD  	
(
@GetBloodType varchar(50) 
)
AS
BEGIN
INSERT INTO BLOOD(BloodType)
VALUES(@GetBloodType)
END	
InsertValueBLOOD '0Rh(+)'
InsertValueBLOOD '0Rh(-)'
InsertValueBLOOD 'ARh(+)'
InsertValueBLOOD 'ARh(-)'
InsertValueBLOOD 'BRh(+)'
InsertValueBLOOD 'BRh(-)'
InsertValueBLOOD 'ABRh(+)'
InsertValueBLOOD 'ABRh(-)'
/*2*/
CREATE PROCEDURE InsertValueBLOODCENTER  	
(
@GetBloodCenterName varchar(50),
@GetAddressProvince varchar(50),
@GetAddressDistrict varchar(50),
@GetAddressStreet varchar(50),
@GetBuildingNumber integer,
@GetApartmentNumber integer
)
AS
BEGIN
Declare @AddressID AS INT
SELECT @AddressID = AddressID FROM ADDRESS_ WHERE AddressProvince = @GetAddressProvince AND
                                                  AddressDistrict = @GetAddressDistrict AND
												  AddressStreet = @GetAddressStreet AND
												  BuildingNumber = @GetBuildingNumber AND
												  ApartmentNumber = @GetApartmentNumber;

If(@AddressID is null)               
Begin
INSERT INTO ADDRESS_(AddressProvince,AddressDistrict,AddressStreet,BuildingNumber,ApartmentNumber)
VALUES(@GetAddressProvince,@GetAddressDistrict,@GetAddressStreet,@GetBuildingNumber,@GetApartmentNumber)
Select @AddressID = SCOPE_IDENTITY()
End
INSERT INTO BLOODCENTER(BloodCenterName,AddressID) VALUES (@GetBloodCenterName,@AddressID);
END
InsertValueBLOODCENTER 'Kızılay Gaziemir Subesi','Izmir','Gaziemir','Hasan Güven Caddesi',95,NULL
InsertValueBLOODCENTER 'Kızılay Karabaglar Subesi','Izmir','Karabaglar','Gunaltay Caddesi',10,NULL
InsertValueBLOODCENTER 'Kızılay Bornova Subesi','Izmir','Bornova','Hasim Iscan Caddesi',12,2
InsertValueBLOODCENTER 'Kızılay Menderes Subesi','Izmir','Menderes','Cumaovası Caddesi',58,NULL
/*3*/
CREATE PROCEDURE InsertValuePHLEBOTOMIST 	
(
@GetPhlebotomistName varchar(50),
@GetPhlebotomistSurname varchar(50),
@GetBloodCenterName varchar(50)
)
AS
BEGIN
Declare @BloodCenterID AS INT
SELECT @BloodCenterID = BLOODCENTER.BloodCenterID FROM BLOODCENTER WHERE BLOODCENTER.BloodCenterName = @GetBloodCenterName
INSERT INTO PHLEBOTOMIST(PhlebotomistName,PhlebotomistSurname,BloodCenterID)
VALUES(@GetPhlebotomistName,@GetPhlebotomistSurname,@BloodCenterID)
END	
InsertValuePHLEBOTOMIST 'Gazi','Yaşargil','Kızılay Gaziemir Subesi'
InsertValuePHLEBOTOMIST 'Omer','Ozkan','Kızılay Karabaglar Subesi'
InsertValuePHLEBOTOMIST 'Mehmet','Oz','Kızılay Bornova Subesi'
InsertValuePHLEBOTOMIST 'Tayfun','Aybek','Kızılay Menderes Subesi'
/*4*/
CREATE PROCEDURE InsertValueBLOODCENTER_BLOOD 	
(
@GetBloodType varchar(50),
@GetBloodCenterName varchar(50),
@UnitStock integer
)
AS
BEGIN
Declare @BloodCenterID AS INT
Declare @BloodID AS INT
SELECT @BloodID=BloodID FROM BLOOD WHERE BloodType=@GetBloodType
SELECT @BloodCenterID = BLOODCENTER.BloodCenterID FROM BLOODCENTER WHERE BLOODCENTER.BloodCenterName = @GetBloodCenterName
INSERT INTO BLOODCENTER_BLOOD(BloodID,BloodCenterID,UnitStock)
VALUES(@BloodID,@BloodCenterID,@UnitStock)
END	
InsertValueBLOODCENTER_BLOOD '0Rh(+)','Kızılay Gaziemir Subesi',100
InsertValueBLOODCENTER_BLOOD '0Rh(-)','Kızılay Gaziemir Subesi',34
InsertValueBLOODCENTER_BLOOD 'ARh(+)','Kızılay Gaziemir Subesi',40
InsertValueBLOODCENTER_BLOOD 'ARh(-)','Kızılay Gaziemir Subesi',88
InsertValueBLOODCENTER_BLOOD 'BRh(+)','Kızılay Gaziemir Subesi',45
InsertValueBLOODCENTER_BLOOD 'BRh(-)','Kızılay Gaziemir Subesi',74
InsertValueBLOODCENTER_BLOOD 'ABRh(+)','Kızılay Gaziemir Subesi',12
InsertValueBLOODCENTER_BLOOD 'ABRh(-)','Kızılay Gaziemir Subesi',54

InsertValueBLOODCENTER_BLOOD '0Rh(+)','Kızılay Karabaglar Subesi',32
InsertValueBLOODCENTER_BLOOD '0Rh(-)','Kızılay Karabaglar Subesi',56
InsertValueBLOODCENTER_BLOOD 'ARh(+)','Kızılay Karabaglar Subesi',87
InsertValueBLOODCENTER_BLOOD 'ARh(-)','Kızılay Karabaglar Subesi',14
InsertValueBLOODCENTER_BLOOD 'BRh(+)','Kızılay Karabaglar Subesi',40
InsertValueBLOODCENTER_BLOOD 'BRh(-)','Kızılay Karabaglar Subesi',71
InsertValueBLOODCENTER_BLOOD 'ABRh(+)','Kızılay Karabaglar Subesi',57
InsertValueBLOODCENTER_BLOOD 'ABRh(-)','Kızılay Karabaglar Subesi',98

InsertValueBLOODCENTER_BLOOD '0Rh(+)','Kızılay Bornova Subesi',140
InsertValueBLOODCENTER_BLOOD '0Rh(-)','Kızılay Bornova Subesi',11
InsertValueBLOODCENTER_BLOOD 'ARh(+)','Kızılay Bornova Subesi',44
InsertValueBLOODCENTER_BLOOD 'ARh(-)','Kızılay Bornova Subesi',87
InsertValueBLOODCENTER_BLOOD 'BRh(+)','Kızılay Bornova Subesi',76
InsertValueBLOODCENTER_BLOOD 'BRh(-)','Kızılay Bornova Subesi',73
InsertValueBLOODCENTER_BLOOD 'ABRh(+)','Kızılay Bornova Subesi',34
InsertValueBLOODCENTER_BLOOD 'ABRh(-)','Kızılay Bornova Subesi',65

InsertValueBLOODCENTER_BLOOD '0Rh(+)','Kızılay Menderes Subesi',14
InsertValueBLOODCENTER_BLOOD '0Rh(-)','Kızılay Menderes Subesi',85
InsertValueBLOODCENTER_BLOOD 'ARh(+)','Kızılay Menderes Subesi',46
InsertValueBLOODCENTER_BLOOD 'ARh(-)','Kızılay Menderes Subesi',75
InsertValueBLOODCENTER_BLOOD 'BRh(+)','Kızılay Menderes Subesi',69
InsertValueBLOODCENTER_BLOOD 'BRh(-)','Kızılay Menderes Subesi',12
InsertValueBLOODCENTER_BLOOD 'ABRh(+)','Kızılay Menderes Subesi',43
InsertValueBLOODCENTER_BLOOD 'ABRh(-)','Kızılay Menderes Subesi',66 */
/*5*/
/*
CREATE PROCEDURE InsertValueDONORAndIDENTITY   	
(
@Email varchar(50),
@Job varchar(50),
@EducationalStatus varchar(50),
@Height integer,
@Weightt integer,
@GetBloodType varchar(50),
@GetID varchar(50),
@GetName varchar(50),
@GetSurname varchar(50),
@GetSex varchar(50),
@GetFatherName varchar(50),
@GetMotherName varchar(50),
@GetBirthPlace varchar(50),
@GetBirthDate  datetime,
@GetMaritalStatus char(10),
@GetReligion varchar(50),
@GetProvince varchar(50),
@GetDistrict varchar(50),
@GetStreet varchar(50),
@GetMaidenName varchar(50)
)
AS
BEGIN
Declare @BloodID AS INT
SELECT @BloodID=BloodID FROM BLOOD WHERE BloodType=@GetBloodType
INSERT INTO IDENTITY_(IDNo,Name,Surname,Sex,FatherName,MotherName,BirthPlace,BirthDate,MaritalStatus,Religion,Province,District,Street,MaidenName)
VALUES(@GetID,@GetName,@GetSurname,@GetSex,@GetFatherName,@GetMotherName,@GetBirthPlace,@GetBirthDate,@GetMaritalStatus,@GetReligion,@GetProvince,@GetDistrict,@GetStreet,@GetMaidenName)
INSERT INTO DONOR(Email,Job,EducationalStatus,Height,Weightt,BloodID,IDNo)
VALUES(@Email,@Job,@EducationalStatus,@Height,@Weightt,@BloodID,@GetID)
END	
InsertValueDONORAndIDENTITY 'mert.pehlivancik@gmail.com','Student','College',183,72,'0Rh(+)','52541257413','Mert','Pehlivancık','Male','Ahmet','Kubra','Konak','1995-11-09','Single','Muslim','Izmir','Gaziemir','SAKARYA',NULL;
InsertValueDONORAndIDENTITY 'furkan.izmirli@gmail.com','Student','College',175,59,'ARh(+)','52541257414','Furkan','Izmirli','Male','Gurcan','Berrin','Konak','1996-02-17','Single','Muslim','Izmir','Urla','Bahceli',NULL;
InsertValueDONORAndIDENTITY 'berk.antepli@gmail.com','Student','College',185,75,'ABRh(-)','52541257415','Berk','Antepli','Male','Ali','Ayse','Konak','1996-05-17','Single','Muslim','Izmir','Guzelbahce','Deniz',NULL;
InsertValueDONORAndIDENTITY 'mehmet.ok@gmail.com','Student','College',183,72,'0Rh(+)','52541257416','Mehmet','Ok','Male','Mustafa','Hatice','Konak','1995-11-09','Single','Muslim','Izmir','Buca','Yaylacık',NULL;
*/
/*6*/
/*
CREATE PROCEDURE InsertValueRELATIVE_DONOR 	
(
@GetIDNo varchar(50),
@GetRelativeName varchar(50),
@GetRelativeSurname varchar(50),
@GetRelativeSex varchar(50),
@GetRelativeEmail varchar(50),
@GetBloodName varchar(50)
)
AS
BEGIN
Declare @BloodID AS INT
Declare @DonorID AS INT
Declare @RelativeID AS INT
SELECT @DonorID=d.DonorID FROM IDENTITY_ AS ı,DONOR AS d WHERE @GetIDNo = ı.IDNo AND @GetIDNo = d.IDNo
SELECT @BloodID = BLOOD.BloodID FROM BLOOD WHERE BLOOD.BloodType = @GetBloodName
INSERT INTO RELATIVE_(RelativeName,RelativeSurname,RelativeSex,RelativeEmail,BloodID)
VALUES(@GetRelativeName,@GetRelativeSurname,@GetRelativeSex,@GetRelativeEmail,@BloodID)
Select @RelativeID = SCOPE_IDENTITY()
INSERT INTO RELATIVE_DONOR(DonorID,RelativeID) VALUES(@DonorID,@RelativeID)
END	
InsertValueRELATIVE_DONOR '52541257413','İbrahim','Aksoy','Male',NULL,'0Rh(-)'
InsertValueRELATIVE_DONOR '52541257414','Ali','Kara','Male','ali.kara@gmail.com','BRh(+)'
InsertValueRELATIVE_DONOR '52541257415','Beran','Dagdeviren','Male',NULL,'ARh(-)'
InsertValueRELATIVE_DONOR '52541257416','Enes','Kaya','Male',NULL,'ABRh(+)'
*/
/*7*/
/*
CREATE PROCEDURE InsertValueADDRESS_DONOR 	
(
@GetIDNo varchar(50),
@GetAddressProvince varchar(50),
@GetAddressDistrict varchar(50),
@GetAddressStreet varchar(50),
@GetBuildingNumber integer,
@GetApartmentNumber integer
)
AS
BEGIN
Declare @DonorID AS INT
Declare @AddressID AS INT
SELECT @DonorID=d.DonorID FROM IDENTITY_ AS ı,DONOR AS d WHERE @GetIDNo = ı.IDNo AND @GetIDNo = d.IDNo
INSERT INTO ADDRESS_(AddressProvince,AddressDistrict,AddressStreet,BuildingNumber,ApartmentNumber)
VALUES(@GetAddressProvince,@GetAddressDistrict,@GetAddressStreet,@GetBuildingNumber,@GetApartmentNumber)
Select @AddressID = SCOPE_IDENTITY()
INSERT INTO ADDRESS_DONOR(DonorID,AddressID) VALUES(@DonorID,@AddressID)
END	
InsertValueADDRESS_DONOR '52541257413','Izmir','Karşıyaka','Semikler',13,2
InsertValueADDRESS_DONOR '52541257414','Izmir','Bornova','Ozkanlar',11,NULL
InsertValueADDRESS_DONOR '52541257416','Izmir','Buca','Adatepe',44,2
*/
/*8*/
/*
CREATE PROCEDURE InsertValueDONOR_BLOODCENTER 	
(
@GetPhlebotomistName varchar(50),
@GetPhlebotomistSurname varchar(50),
@GetBloodCenterName varchar(50),
@GetIDNo varchar(50)
)
AS
BEGIN
Declare @DonorID AS INT
Declare @CountOfSameNS AS INT
Declare @CountOfSameBloodCenter AS INT
Declare @PhlebotomistID AS INT
Declare @BloodCenterID AS INT
Declare @DonationDate AS Datetime = GetDate()
SELECT @DonorID=d.DonorID FROM IDENTITY_ AS ı,DONOR AS d WHERE @GetIDNo = ı.IDNo AND @GetIDNo = d.IDNo
/*Aim is that detect phlebotomists,who have same name and surname"if there is exist"*/
SELECT @CountOfSameNS=COUNT(PhlebotomistID) FROM PHLEBOTOMIST WHERE PhlebotomistName=@GetPhlebotomistName AND @GetPhlebotomistSurname = PhlebotomistSurname
IF @CountOfSameNS = 1
BEGIN
SELECT @PhlebotomistID=PhlebotomistID FROM PHLEBOTOMIST WHERE PhlebotomistName=@GetPhlebotomistName AND @GetPhlebotomistSurname = PhlebotomistSurname
END
SELECT @CountOfSameBloodCenter=COUNT(BloodCenterID) FROM BLOODCENTER WHERE @GetBloodCenterName = BloodCenterName
IF @CountOfSameBloodCenter = 1
BEGIN
SELECT @BloodCenterID=BloodCenterID FROM BLOODCENTER WHERE @GetBloodCenterName = BloodCenterName
END
INSERT INTO DONOR_BLOODCENTER(PhlebotomistID,BloodCenterID,DonorID,DonationDate) VALUES(@PhlebotomistID,@BloodCenterID,@DonorID,@DonationDate)
END	
InsertValueDONOR_BLOODCENTER 'Gazi','Yaşargil','Kızılay Gaziemir Subesi','52541257413'
InsertValueDONOR_BLOODCENTER 'Omer','Ozkan','Kızılay Karabaglar Subesi','52541257414'
InsertValueDONOR_BLOODCENTER 'Mehmet','Oz','Kızılay Bornova Subesi','52541257415'
InsertValueDONOR_BLOODCENTER 'Tayfun','Aybek','Kızılay Menderes Subesi','52541257416'
*/
/*9*/
/*
CREATE PROCEDURE InsertValueDISEASE 	
(
@DiseaseName varchar(50),
@IncubationPeriod numeric(5,1),
@DayofConvalescence numeric(5,1)
)
AS
BEGIN
INSERT INTO DISEASE(DiseaseName,IncubationPeriod,DayofConvalescence)
VALUES(@DiseaseName,@IncubationPeriod,@DayofConvalescence)
END
InsertValueDISEASE 'AIDS',NULL,NULL
InsertValueDISEASE 'Anaflaksi',100,200
InsertValueDISEASE 'Creutzfeldt',NULL,NULL
InsertValueDISEASE 'Asbestosis',NULL,NULL
*/
/*10*/
/*
CREATE PROCEDURE InsertValueDONOR_DISEASE 	
(
@GetIDNo varchar(50),
@DiseaseName varchar(50),
@Status_ varchar(1000),
@AbilityOfBloodDonation BIT
)
AS
BEGIN
Declare @DonorID AS INT
Declare @DiseaseID AS INT
SELECT @DonorID=d.DonorID FROM IDENTITY_ AS ı,DONOR AS d WHERE @GetIDNo = ı.IDNo AND @GetIDNo = d.IDNo
SELECT @DiseaseID=DiseaseID FROM DISEASE WHERE @DiseaseName = DiseaseName
INSERT INTO DONOR_DISEASE(DonorID,DiseaseID,Status_,AbilityOfBloodDonation) VALUES(@DonorID,@DiseaseID,@Status_,@AbilityOfBloodDonation)
END	
InsertValueDONOR_DISEASE '52541257416','AIDS','he can not give blood anytime',0
*/
/*11*/
/*
CREATE PROCEDURE InsertValueDONOR_PHONE 	
(
@GetMobileNumber varchar(11),
@GetHomePhoneNumber varchar(11),
@GetIDNo varchar(50)
)
AS
BEGIN
Declare @DonorID AS INT
SELECT @DonorID=d.DonorID FROM IDENTITY_ AS ı,DONOR AS d WHERE @GetIDNo = ı.IDNo AND @GetIDNo = d.IDNo
INSERT INTO PHONE(MobileNumber,HomePhoneNumber,DonorID) VALUES(@GetMobileNumber,@GetHomePhoneNumber,@DonorID)
END	
InsertValueDONOR_PHONE '05444334899',NULL,'52541257413'
InsertValueDONOR_PHONE '05444334898',NULL,'52541257414'
*/
/*12*/
/*
CREATE PROCEDURE InsertValueRELATIVE_PHONE 	
(
@GetMobileNumber varchar(11),
@GetHomePhoneNumber varchar(11),
@RelativeID integer
)
AS
BEGIN
INSERT INTO PHONE(MobileNumber,HomePhoneNumber,RelativeID) VALUES(@GetMobileNumber,@GetHomePhoneNumber,@RelativeID)
END	
InsertValueRELATIVE_PHONE '05448763400',NULL,4
InsertValueRELATIVE_PHONE '05338733351',NULL,3
*/
/*13*//*
CREATE PROCEDURE InsertValueBLOODCENTER_PHONE 	
(
@GetMobileNumber varchar(11),
@GetHomePhoneNumber varchar(11),
@GetBloodCenterName varchar(50)
)
AS
Declare @CountOfSameBloodCenter AS INT
Declare @BloodCenterID AS INT
SELECT @CountOfSameBloodCenter=COUNT(BloodCenterID) FROM BLOODCENTER WHERE @GetBloodCenterName = BloodCenterName
IF @CountOfSameBloodCenter = 1
BEGIN
SELECT @BloodCenterID=BloodCenterID FROM BLOODCENTER WHERE @GetBloodCenterName = BloodCenterName
END
BEGIN
INSERT INTO PHONE(MobileNumber,HomePhoneNumber,BloodCenterID) VALUES(@GetMobileNumber,@GetHomePhoneNumber,@BloodCenterID)
END	
InsertValueBLOODCENTER_PHONE NULL,'02322512121','Kizilay Gaziemir Subesi'
InsertValueBLOODCENTER_PHONE NULL,'02324335454','Kizilay Bornova Subesi'
InsertValueBLOODCENTER_PHONE NULL,'02322268885','Kizilay Karabaglar Subesi'*/
/*14*/
/*
CREATE TRIGGER Trig
ON DONOR_BLOODCENTER 
FOR INSERT
AS
Declare
        @DonorID  integer,
		@BloodCenterID integer,
		@BloodID integer;
BEGIN
SELECT @DonorID=DonorID,@BloodCenterID=BloodCenterID FROM DONOR_BLOODCENTER
WHERE DonationDate IN (SELECT max(DonationDate) FROM DONOR_BLOODCENTER);
SELECT @BloodID=d.BloodID FROM DONOR AS d,BLOOD AS b WHERE d.DonorID = @DonorID AND d.BloodID = b.BloodID
UPDATE BLOODCENTER_BLOOD
SET UnitStock=UnitStock+1 
WHERE BloodID = @BloodID AND BloodCenterID = @BloodCenterID
END
*/