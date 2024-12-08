--Sajeda Website


--User (User ID, name, Birthdate, Email, Image, Address name, Address number , phone number, LinkedIn link, GitHub link, Register Date)
--Services (ID, Services name, Details,User ID)
--projects (ID, name, Details, image, Start Date, End Date, First GitHub link, second GitHub link, LinkedIn link,User ID)
--Experience (ID, position name , Details, Start Date, End Date, User ID ) 
--Technical skills ( ID, Skills name , Details, Rate, User ID)
--soft skills ( ID, Skills name , Details, Rate, User ID)
--Testimonial (ID, Name, Email, Message, Date, User ID)
--Website Information (ID, Header, Text1, Text2, Text3, Image1, Image2, Image3)
--About us (ID, Header, Text1, Text2, Text3, Image1, Image2, Image3)
--Contact us (ID, Name, Email, Message, Date)


-- User Table
CREATE TABLE Users (
    UserID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    Name VARCHAR2(100),
    Birthdate DATE,
    Email VARCHAR2(100) UNIQUE,
    Image VARCHAR2(255),
    AddressName VARCHAR2(4000),
    AddressNumber VARCHAR2(4000),
    PhoneNumber VARCHAR2(20),
    LinkedInLink VARCHAR2(4000),
    GitHubLink VARCHAR2(4000),
    RegisterDate DATE DEFAULT SYSDATE
);


-- Services Table
CREATE TABLE Services (
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    ServicesName VARCHAR2(100),
    Details CLOB,
    UserID NUMBER,
    CONSTRAINT FK_Services_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE Set null
);

-- Projects Table
CREATE TABLE Projects (
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    Name VARCHAR2(100),
    Details CLOB,
    Image VARCHAR2(255),
    StartDate DATE,
    EndDate DATE,
    FirstGitHubLink VARCHAR2(255),
    SecondGitHubLink VARCHAR2(255),
    LinkedInLink VARCHAR2(255),
    UserID NUMBER,
    CONSTRAINT FK_Projects_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE Set null
);

-- Experience Table
CREATE TABLE Experience (
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    PositionName VARCHAR2(100),
    Details CLOB,
    StartDate DATE,
    EndDate DATE,
    UserID NUMBER,
    CONSTRAINT FK_Experience_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE Set null
);

-- Technical Skills Table
CREATE TABLE TechnicalSkills (
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    SkillsName VARCHAR2(100),
    Details CLOB,
    Rate NUMBER, 
    UserID NUMBER,
    CONSTRAINT FK_TechnicalSkills_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE Set null
);

-- Soft Skills Table
CREATE TABLE SoftSkills (
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    SkillsName VARCHAR2(100),
    Details CLOB,
    Rate NUMBER,
    UserID NUMBER,
    CONSTRAINT FK_SoftSkills_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE Set null
);

-- Testimonial Table
CREATE TABLE Testimonial (
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    Name VARCHAR2(100),
    Email VARCHAR2(100),
    Message VARCHAR2(4000),
    MessageDate DATE DEFAULT SYSDATE,
    UserID NUMBER,
    CONSTRAINT FK_Testimonial_User FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE Set null
);


--Website Information
Create Table WebsiteInformation
(
    ID number GENERATED AS IDENTITY PRIMARY KEY,
    Header varchar2(4000),
    Text1 varchar2(4000),
    Text2 varchar2(4000),
    Text3 varchar2(4000),
    Image1 varchar2(4000), 
    Image2 varchar2(4000), 
    Image3 varchar2(4000)
);

--About us
Create Table AboutUs
(
    ID number GENERATED AS IDENTITY PRIMARY KEY,
    Header varchar2(4000),
    Text1 varchar2(4000),
    Text2 varchar2(4000),
    Text3 varchar2(4000),
    Image1 varchar2(4000), 
    Image2 varchar2(4000), 
    Image3 varchar2(4000)
);

--Contact us
Create Table ContactUs
(
    ID number GENERATED AS IDENTITY PRIMARY KEY,
    Name varchar2(4000),
    Email varchar2(4000),
    Message varchar2(4000),
    MessageDate Date DEFAULT SYSDATE
    
);



--******************************************************************************


--packages

--User Package
CREATE OR REPLACE PACKAGE Users_Packegs AS
   PROCEDURE GetAllUsers; 
   PROCEDURE GetUsersById(id IN NUMBER); 
   PROCEDURE CreateUsers(UserID IN NUMBER, Name IN Varchar2, Birthdate IN Date,Email in varchar2, Image in varchar2, AddressName in varchar2, AddressNumber in number,PhoneNumber in number , LinkedInLink in varchar2,GitHubLink in varchar2,RegisterDate in Date);                        
   PROCEDURE UpdateUsers(UUserID IN NUMBER, UName IN Varchar2, UBirthdate IN Date,UEmail in varchar2, UImage in varchar2, UAddressName in varchar2, UAddressNumber in number,UPhoneNumber in number , ULinkedInLink in varchar2,UGitHubLink in varchar2,URegisterDate in Date);                         
   PROCEDURE DeleteUsers(id IN NUMBER); 
END Users_Packegs;

CREATE OR REPLACE PACKAGE BODY Users_Packegs AS

   PROCEDURE GetAllUsers AS 
      cur_all SYS_REFCURSOR; 
   BEGIN  
      OPEN cur_all FOR 
      SELECT * FROM Users; 
      DBMS_SQL.return_result(cur_all); 
   END GetAllUsers;

   PROCEDURE GetUsersById(id IN NUMBER) AS 
      cur_item SYS_REFCURSOR; 
   BEGIN 
      OPEN cur_item FOR 
      SELECT * FROM Users 
      WHERE UserID = id; 
      DBMS_SQL.return_result(cur_item); 
   END GetUsersById;

   PROCEDURE CreateUsers(UserID IN NUMBER, Name IN Varchar2, Birthdate IN Date,Email in varchar2, Image in varchar2, AddressName in varchar2, AddressNumber in number,PhoneNumber in number , LinkedInLink in varchar2,GitHubLink in varchar2,RegisterDate in Date) AS 
   BEGIN  
      INSERT INTO Users (UserID,Name,Birthdate,Email,Image,AddressName,AddressNumber,PhoneNumber, LinkedInLink ,GitHubLink ,RegisterDate) 
      VALUES (Default,Name,Birthdate,Email,Image,AddressName,AddressNumber,PhoneNumber,LinkedInLink,GitHubLink,RegisterDate); 
      COMMIT; 
   END CreateUsers;

   PROCEDURE UpdateUsers(UUserID IN NUMBER, UName IN Varchar2, UBirthdate IN Date,UEmail in varchar2, UImage in varchar2, UAddressName in varchar2, UAddressNumber in number,UPhoneNumber in number , ULinkedInLink in varchar2,UGitHubLink in varchar2,URegisterDate in Date)               
   AS 
   BEGIN 
      UPDATE Users 
      SET Name = UName, Birthdate = UBirthdate, Email=UEmail, Image=UImage, AddressName=UAddressName, AddressNumber=UAddressNumber, PhoneNumber=UPhoneNumber, LinkedInLink=ULinkedInLink, GitHubLink=UGitHubLink, RegisterDate=URegisterDate
      WHERE UserID = UUserID; 
      COMMIT; 
   END UpdateUsers;

   PROCEDURE DeleteUsers(id IN NUMBER) AS 
   BEGIN 
      DELETE FROM Users 
      WHERE UserID = id; 
      COMMIT; 
   END DeleteUsers;

END Users_Packegs;



--Services Package
CREATE OR REPLACE PACKAGE Services_Packegs AS
   PROCEDURE GetAllServices; 
   PROCEDURE GetServicesById(id IN NUMBER); 
   PROCEDURE CreateServices(ID IN NUMBER, ServicesName IN Varchar2, Details IN Varchar2,UserID in number);                        
   PROCEDURE UpdateServices(SID IN NUMBER, SServicesName IN Varchar2, SDetails IN Varchar2,SUserID in number);                         
   PROCEDURE DeleteServices(id IN NUMBER); 
END Services_Packegs;

CREATE OR REPLACE PACKAGE BODY Services_Packegs AS

   PROCEDURE GetAllServices AS 
      cur_all SYS_REFCURSOR; 
   BEGIN  
      OPEN cur_all FOR 
      SELECT * FROM Services; 
      DBMS_SQL.return_result(cur_all); 
   END GetAllServices;

   PROCEDURE GetServicesById(id IN NUMBER) AS 
      cur_item SYS_REFCURSOR; 
   BEGIN 
      OPEN cur_item FOR 
      SELECT * FROM Services 
      WHERE ID = id; 
      DBMS_SQL.return_result(cur_item); 
   END GetServicesById;

   PROCEDURE CreateServices(ID IN NUMBER, ServicesName IN Varchar2, Details IN Varchar2,UserID in number) AS 
   BEGIN  
      INSERT INTO Services (ID, ServicesName , Details,UserID)
      VALUES (ID, ServicesName , Details,UserID); 
      COMMIT; 
   END CreateServices;

   PROCEDURE UpdateServices(SID IN NUMBER, SServicesName IN Varchar2, SDetails IN Varchar2,SUserID in number)            
   AS 
   BEGIN 
      UPDATE Services 
      SET ServicesName = SServicesName, Details = SDetails, UserID=SUserID
      WHERE ID = SID; 
      COMMIT; 
   END UpdateServices;

   PROCEDURE DeleteServices(id IN NUMBER) AS 
   BEGIN 
      DELETE FROM Services 
      WHERE ID = id; 
      COMMIT; 
   END DeleteServices;

END Services_Packegs;





--projects Package
CREATE OR REPLACE PACKAGE Projects_Packegs AS
   PROCEDURE GetAllProjects;
   PROCEDURE GetProjectById(id IN NUMBER);
   PROCEDURE CreateProject(
       ID IN NUMBER, 
       Name IN VARCHAR2, 
       Details IN CLOB, 
       Image IN VARCHAR2, 
       StartDate IN DATE, 
       EndDate IN DATE, 
       FirstGitHubLink IN VARCHAR2, 
       SecondGitHubLink IN VARCHAR2, 
       LinkedInLink IN VARCHAR2, 
       UserID IN NUMBER
   );
   PROCEDURE UpdateProject(
       PID IN NUMBER, 
       PName IN VARCHAR2, 
       PDetails IN CLOB, 
       PImage IN VARCHAR2, 
       PStartDate IN DATE, 
       PEndDate IN DATE, 
       PFirstGitHubLink IN VARCHAR2, 
       PSecondGitHubLink IN VARCHAR2, 
       PLinkedInLink IN VARCHAR2, 
       PUserID IN NUMBER
   );
   PROCEDURE DeleteProject(id IN NUMBER);
END Projects_Packegs;


CREATE OR REPLACE PACKAGE BODY Projects_Packegs AS

   PROCEDURE GetAllProjects AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM Projects;
      DBMS_SQL.return_result(cur_all);
   END GetAllProjects;

   PROCEDURE GetProjectById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM Projects WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetProjectById;

   PROCEDURE CreateProject(
       ID IN NUMBER, 
       Name IN VARCHAR2, 
       Details IN CLOB, 
       Image IN VARCHAR2, 
       StartDate IN DATE, 
       EndDate IN DATE, 
       FirstGitHubLink IN VARCHAR2, 
       SecondGitHubLink IN VARCHAR2, 
       LinkedInLink IN VARCHAR2, 
       UserID IN NUMBER
   ) AS
   BEGIN
      INSERT INTO Projects (
         ID, Name, Details, Image, StartDate, EndDate, 
         FirstGitHubLink, SecondGitHubLink, LinkedInLink, UserID
      )
      VALUES (
         ID, Name, Details, Image, StartDate, EndDate, 
         FirstGitHubLink, SecondGitHubLink, LinkedInLink, UserID
      );
      COMMIT;
   END CreateProject;

   PROCEDURE UpdateProject(
       PID IN NUMBER, 
       PName IN VARCHAR2, 
       PDetails IN CLOB, 
       PImage IN VARCHAR2, 
       PStartDate IN DATE, 
       PEndDate IN DATE, 
       PFirstGitHubLink IN VARCHAR2, 
       PSecondGitHubLink IN VARCHAR2, 
       PLinkedInLink IN VARCHAR2, 
       PUserID IN NUMBER
   ) AS
   BEGIN
      UPDATE Projects
      SET 
          Name = PName, 
          Details = PDetails, 
          Image = PImage, 
          StartDate = PStartDate, 
          EndDate = PEndDate, 
          FirstGitHubLink = PFirstGitHubLink, 
          SecondGitHubLink = PSecondGitHubLink, 
          LinkedInLink = PLinkedInLink, 
          UserID = PUserID
      WHERE ID = PID;
      COMMIT;
   END UpdateProject;

   PROCEDURE DeleteProject(id IN NUMBER) AS
   BEGIN
      DELETE FROM Projects WHERE ID = id;
      COMMIT;
   END DeleteProject;

END Projects_Packegs;





--Experience Package
CREATE OR REPLACE PACKAGE Experience_Packegs AS
   PROCEDURE GetAllExperience;
   PROCEDURE GetExperienceById(id IN NUMBER);
   PROCEDURE CreateExperience(
       ID IN NUMBER, 
       PositionName IN VARCHAR2, 
       Details IN CLOB, 
       StartDate IN DATE, 
       EndDate IN DATE, 
       UserID IN NUMBER
   );
   PROCEDURE UpdateExperience(
       EID IN NUMBER, 
       EPositionName IN VARCHAR2, 
       EDetails IN CLOB, 
       EStartDate IN DATE, 
       EEndDate IN DATE, 
       EUserID IN NUMBER
   );
   PROCEDURE DeleteExperience(id IN NUMBER);
END Experience_Packegs;


CREATE OR REPLACE PACKAGE BODY Experience_Packegs AS

   PROCEDURE GetAllExperience AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM Experience;
      DBMS_SQL.return_result(cur_all);
   END GetAllExperience;

   PROCEDURE GetExperienceById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM Experience WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetExperienceById;

   PROCEDURE CreateExperience(
       ID IN NUMBER, 
       PositionName IN VARCHAR2, 
       Details IN CLOB, 
       StartDate IN DATE, 
       EndDate IN DATE, 
       UserID IN NUMBER
   ) AS
   BEGIN
      INSERT INTO Experience (
         ID, PositionName, Details, StartDate, EndDate, UserID
      )
      VALUES (
         ID, PositionName, Details, StartDate, EndDate, UserID
      );
      COMMIT;
   END CreateExperience;

   PROCEDURE UpdateExperience(
       EID IN NUMBER, 
       EPositionName IN VARCHAR2, 
       EDetails IN CLOB, 
       EStartDate IN DATE, 
       EEndDate IN DATE, 
       EUserID IN NUMBER
   ) AS
   BEGIN
      UPDATE Experience
      SET 
          PositionName = EPositionName, 
          Details = EDetails, 
          StartDate = EStartDate, 
          EndDate = EEndDate, 
          UserID = EUserID
      WHERE ID = EID;
      COMMIT;
   END UpdateExperience;

   PROCEDURE DeleteExperience(id IN NUMBER) AS
   BEGIN
      DELETE FROM Experience WHERE ID = id;
      COMMIT;
   END DeleteExperience;

END Experience_Packegs;



--Technical skills Package
CREATE OR REPLACE PACKAGE TechnicalSkills_Packegs AS
   PROCEDURE GetAllTechnicalSkills;
   PROCEDURE GetTechnicalSkillsById(id IN NUMBER);
   PROCEDURE CreateTechnicalSkills(
       ID IN NUMBER, 
       SkillsName IN VARCHAR2, 
       Details IN CLOB, 
       Rate IN NUMBER, 
       UserID IN NUMBER
   );
   PROCEDURE UpdateTechnicalSkills(
       TSID IN NUMBER, 
       TSSkillsName IN VARCHAR2, 
       TSDetails IN CLOB, 
       TSRate IN NUMBER, 
       TSUserID IN NUMBER
   );
   PROCEDURE DeleteTechnicalSkills(id IN NUMBER);
END TechnicalSkills_Packegs;


CREATE OR REPLACE PACKAGE BODY TechnicalSkills_Packegs AS

   PROCEDURE GetAllTechnicalSkills AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM TechnicalSkills;
      DBMS_SQL.return_result(cur_all);
   END GetAllTechnicalSkills;

   PROCEDURE GetTechnicalSkillsById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM TechnicalSkills WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetTechnicalSkillsById;

   PROCEDURE CreateTechnicalSkills(
       ID IN NUMBER, 
       SkillsName IN VARCHAR2, 
       Details IN CLOB, 
       Rate IN NUMBER, 
       UserID IN NUMBER
   ) AS
   BEGIN
      INSERT INTO TechnicalSkills (
         ID, SkillsName, Details, Rate, UserID
      )
      VALUES (
         ID, SkillsName, Details, Rate, UserID
      );
      COMMIT;
   END CreateTechnicalSkills;

   PROCEDURE UpdateTechnicalSkills(
       TSID IN NUMBER, 
       TSSkillsName IN VARCHAR2, 
       TSDetails IN CLOB, 
       TSRate IN NUMBER, 
       TSUserID IN NUMBER
   ) AS
   BEGIN
      UPDATE TechnicalSkills
      SET 
          SkillsName = TSSkillsName, 
          Details = TSDetails, 
          Rate = TSRate, 
          UserID = TSUserID
      WHERE ID = TSID;
      COMMIT;
   END UpdateTechnicalSkills;

   PROCEDURE DeleteTechnicalSkills(id IN NUMBER) AS
   BEGIN
      DELETE FROM TechnicalSkills WHERE ID = id;
      COMMIT;
   END DeleteTechnicalSkills;

END TechnicalSkills_Packegs;




--soft skills Package
CREATE OR REPLACE PACKAGE SoftSkills_Packegs AS
   PROCEDURE GetAllSoftSkills;
   PROCEDURE GetSoftSkillsById(id IN NUMBER);
   PROCEDURE CreateSoftSkills(
       ID IN NUMBER, 
       SkillsName IN VARCHAR2, 
       Details IN CLOB, 
       Rate IN NUMBER, 
       UserID IN NUMBER
   );
   PROCEDURE UpdateSoftSkills(
       SSID IN NUMBER, 
       SSSkillsName IN VARCHAR2, 
       SSDetails IN CLOB, 
       SSRate IN NUMBER, 
       SSUserID IN NUMBER
   );
   PROCEDURE DeleteSoftSkills(id IN NUMBER);
END SoftSkills_Packegs;



CREATE OR REPLACE PACKAGE BODY SoftSkills_Packegs AS

   PROCEDURE GetAllSoftSkills AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM SoftSkills;
      DBMS_SQL.return_result(cur_all);
   END GetAllSoftSkills;

   PROCEDURE GetSoftSkillsById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM SoftSkills WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetSoftSkillsById;

   PROCEDURE CreateSoftSkills(
       ID IN NUMBER, 
       SkillsName IN VARCHAR2, 
       Details IN CLOB, 
       Rate IN NUMBER, 
       UserID IN NUMBER
   ) AS
   BEGIN
      INSERT INTO SoftSkills (
         ID, SkillsName, Details, Rate, UserID
      )
      VALUES (
         ID, SkillsName, Details, Rate, UserID
      );
      COMMIT;
   END CreateSoftSkills;

   PROCEDURE UpdateSoftSkills(
       SSID IN NUMBER, 
       SSSkillsName IN VARCHAR2, 
       SSDetails IN CLOB, 
       SSRate IN NUMBER, 
       SSUserID IN NUMBER
   ) AS
   BEGIN
      UPDATE SoftSkills
      SET 
          SkillsName = SSSkillsName, 
          Details = SSDetails, 
          Rate = SSRate, 
          UserID = SSUserID
      WHERE ID = SSID;
      COMMIT;
   END UpdateSoftSkills;

   PROCEDURE DeleteSoftSkills(id IN NUMBER) AS
   BEGIN
      DELETE FROM SoftSkills WHERE ID = id;
      COMMIT;
   END DeleteSoftSkills;

END SoftSkills_Packegs;



--Testimonial Package
CREATE OR REPLACE PACKAGE Testimonial_Packegs AS
   PROCEDURE GetAllTestimonials;
   PROCEDURE GetTestimonialById(id IN NUMBER);
   PROCEDURE CreateTestimonial(
       ID IN NUMBER, 
       Name IN VARCHAR2, 
       Email IN VARCHAR2, 
       Message IN VARCHAR2, 
       MessageDate IN DATE, 
       UserID IN NUMBER
   );
   PROCEDURE UpdateTestimonial(
       TID IN NUMBER, 
       TName IN VARCHAR2, 
       TEmail IN VARCHAR2, 
       TMessage IN VARCHAR2, 
       TMessageDate IN DATE, 
       TUserID IN NUMBER
   );
   PROCEDURE DeleteTestimonial(id IN NUMBER);
END Testimonial_Packegs;


CREATE OR REPLACE PACKAGE BODY Testimonial_Packegs AS

   PROCEDURE GetAllTestimonials AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM Testimonial;
      DBMS_SQL.return_result(cur_all);
   END GetAllTestimonials;

   PROCEDURE GetTestimonialById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM Testimonial WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetTestimonialById;

   PROCEDURE CreateTestimonial(
       ID IN NUMBER, 
       Name IN VARCHAR2, 
       Email IN VARCHAR2, 
       Message IN VARCHAR2, 
       MessageDate IN DATE, 
       UserID IN NUMBER
   ) AS
   BEGIN
      INSERT INTO Testimonial (
         ID, Name, Email, Message, MessageDate, UserID
      )
      VALUES (
         ID, Name, Email, Message, MessageDate, UserID
      );
      COMMIT;
   END CreateTestimonial;

   PROCEDURE UpdateTestimonial(
       TID IN NUMBER, 
       TName IN VARCHAR2, 
       TEmail IN VARCHAR2, 
       TMessage IN VARCHAR2, 
       TMessageDate IN DATE, 
       TUserID IN NUMBER
   ) AS
   BEGIN
      UPDATE Testimonial
      SET 
          Name = TName, 
          Email = TEmail, 
          Message = TMessage, 
          MessageDate = TMessageDate, 
          UserID = TUserID
      WHERE ID = TID;
      COMMIT;
   END UpdateTestimonial;

   PROCEDURE DeleteTestimonial(id IN NUMBER) AS
   BEGIN
      DELETE FROM Testimonial WHERE ID = id;
      COMMIT;
   END DeleteTestimonial;

END Testimonial_Packegs;





CREATE OR REPLACE PACKAGE WebsiteInformation_Packegs AS
   PROCEDURE GetAllWebsiteInformation;
   PROCEDURE GetWebsiteInformationById(id IN NUMBER);
   PROCEDURE CreateWebsiteInformation(
       ID IN NUMBER, 
       Header IN VARCHAR2, 
       Text1 IN VARCHAR2, 
       Text2 IN VARCHAR2, 
       Text3 IN VARCHAR2, 
       Image1 IN VARCHAR2, 
       Image2 IN VARCHAR2, 
       Image3 IN VARCHAR2
   );
   PROCEDURE UpdateWebsiteInformation(
       WID IN NUMBER, 
       WHeader IN VARCHAR2, 
       WText1 IN VARCHAR2, 
       WText2 IN VARCHAR2, 
       WText3 IN VARCHAR2, 
       WImage1 IN VARCHAR2, 
       WImage2 IN VARCHAR2, 
       WImage3 IN VARCHAR2
   );
   PROCEDURE DeleteWebsiteInformation(id IN NUMBER);
END WebsiteInformation_Packegs;


CREATE OR REPLACE PACKAGE BODY WebsiteInformation_Packegs AS

   PROCEDURE GetAllWebsiteInformation AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM WebsiteInformation;
      DBMS_SQL.return_result(cur_all);
   END GetAllWebsiteInformation;

   PROCEDURE GetWebsiteInformationById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM WebsiteInformation WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetWebsiteInformationById;

   PROCEDURE CreateWebsiteInformation(
       ID IN NUMBER, 
       Header IN VARCHAR2, 
       Text1 IN VARCHAR2, 
       Text2 IN VARCHAR2, 
       Text3 IN VARCHAR2, 
       Image1 IN VARCHAR2, 
       Image2 IN VARCHAR2, 
       Image3 IN VARCHAR2
   ) AS
   BEGIN
      INSERT INTO WebsiteInformation (
         ID, Header, Text1, Text2, Text3, Image1, Image2, Image3
      )
      VALUES (
         ID, Header, Text1, Text2, Text3, Image1, Image2, Image3
      );
      COMMIT;
   END CreateWebsiteInformation;

   PROCEDURE UpdateWebsiteInformation(
       WID IN NUMBER, 
       WHeader IN VARCHAR2, 
       WText1 IN VARCHAR2, 
       WText2 IN VARCHAR2, 
       WText3 IN VARCHAR2, 
       WImage1 IN VARCHAR2, 
       WImage2 IN VARCHAR2, 
       WImage3 IN VARCHAR2
   ) AS
   BEGIN
      UPDATE WebsiteInformation
      SET 
          Header = WHeader, 
          Text1 = WText1, 
          Text2 = WText2, 
          Text3 = WText3, 
          Image1 = WImage1, 
          Image2 = WImage2, 
          Image3 = WImage3
      WHERE ID = WID;
      COMMIT;
   END UpdateWebsiteInformation;

   PROCEDURE DeleteWebsiteInformation(id IN NUMBER) AS
   BEGIN
      DELETE FROM WebsiteInformation WHERE ID = id;
      COMMIT;
   END DeleteWebsiteInformation;

END WebsiteInformation_Packegs;



--AboutUs Package
CREATE OR REPLACE PACKAGE AboutUs_Packegs AS
   PROCEDURE GetAllAboutUs;
   PROCEDURE GetAboutUsById(id IN NUMBER);
   PROCEDURE CreateAboutUs( ID IN NUMBER, Header IN VARCHAR2, Text1 IN VARCHAR2, Text2 IN VARCHAR2, Text3 IN VARCHAR2, Image1 IN VARCHAR2, Image2 IN VARCHAR2, Image3 IN VARCHAR2);
   PROCEDURE UpdateAboutUs( AID IN NUMBER, AHeader IN VARCHAR2, AText1 IN VARCHAR2, AText2 IN VARCHAR2, AText3 IN VARCHAR2, AImage1 IN VARCHAR2, AImage2 IN VARCHAR2, AImage3 IN VARCHAR2);
   PROCEDURE DeleteAboutUs(id IN NUMBER);
END AboutUs_Packegs;



CREATE OR REPLACE PACKAGE BODY AboutUs_Packegs AS

   PROCEDURE GetAllAboutUs AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM AboutUs;
      DBMS_SQL.return_result(cur_all);
   END GetAllAboutUs;

   PROCEDURE GetAboutUsById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM AboutUs WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetAboutUsById;

   PROCEDURE CreateAboutUs(
       ID IN NUMBER, 
       Header IN VARCHAR2, 
       Text1 IN VARCHAR2, 
       Text2 IN VARCHAR2, 
       Text3 IN VARCHAR2, 
       Image1 IN VARCHAR2, 
       Image2 IN VARCHAR2, 
       Image3 IN VARCHAR2
   ) AS
   BEGIN
      INSERT INTO AboutUs (
         ID, Header, Text1, Text2, Text3, Image1, Image2, Image3
      )
      VALUES (
         ID, Header, Text1, Text2, Text3, Image1, Image2, Image3
      );
      COMMIT;
   END CreateAboutUs;

   PROCEDURE UpdateAboutUs(
       AID IN NUMBER, 
       AHeader IN VARCHAR2, 
       AText1 IN VARCHAR2, 
       AText2 IN VARCHAR2, 
       AText3 IN VARCHAR2, 
       AImage1 IN VARCHAR2, 
       AImage2 IN VARCHAR2, 
       AImage3 IN VARCHAR2
   ) AS
   BEGIN
      UPDATE AboutUs
      SET 
          Header = AHeader, 
          Text1 = AText1, 
          Text2 = AText2, 
          Text3 = AText3, 
          Image1 = AImage1, 
          Image2 = AImage2, 
          Image3 = AImage3
      WHERE ID = AID;
      COMMIT;
   END UpdateAboutUs;

   PROCEDURE DeleteAboutUs(id IN NUMBER) AS
   BEGIN
      DELETE FROM AboutUs WHERE ID = id;
      COMMIT;
   END DeleteAboutUs;

END AboutUs_Packegs;






--ContactUs Package
CREATE OR REPLACE PACKAGE ContactUs_Packegs AS
   PROCEDURE GetAllContactUs;
   PROCEDURE GetContactUsById(id IN NUMBER);
   PROCEDURE CreateContactUs(
       ID IN NUMBER, 
       Name IN VARCHAR2, 
       Email IN VARCHAR2, 
       Message IN VARCHAR2, 
       MessageDate IN DATE
   );
   PROCEDURE DeleteContactUs(id IN NUMBER);
END ContactUs_Packegs;


CREATE OR REPLACE PACKAGE BODY ContactUs_Packegs AS

   PROCEDURE GetAllContactUs AS
      cur_all SYS_REFCURSOR;
   BEGIN
      OPEN cur_all FOR 
      SELECT * FROM ContactUs;
      DBMS_SQL.return_result(cur_all);
   END GetAllContactUs;

   PROCEDURE GetContactUsById(id IN NUMBER) AS
      cur_item SYS_REFCURSOR;
   BEGIN
      OPEN cur_item FOR 
      SELECT * FROM ContactUs WHERE ID = id;
      DBMS_SQL.return_result(cur_item);
   END GetContactUsById;

   PROCEDURE CreateContactUs(
       ID IN NUMBER, 
       Name IN VARCHAR2, 
       Email IN VARCHAR2, 
       Message IN VARCHAR2, 
       MessageDate IN DATE
   ) AS
   BEGIN
      INSERT INTO ContactUs (
         ID, Name, Email, Message, MessageDate
      )
      VALUES (
         ID, Name, Email, Message, MessageDate
      );
      COMMIT;
   END CreateContactUs;

   PROCEDURE DeleteContactUs(id IN NUMBER) AS
   BEGIN
      DELETE FROM ContactUs WHERE ID = id;
      COMMIT;
   END DeleteContactUs;

END ContactUs_Packegs;






