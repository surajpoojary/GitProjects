CREATE TABLE Person (
S_ID  NUMBER(10) NOT NULL,
Fname VARCHAR(255) NOT NULL,
Lname VARCHAR(255),
Address1 VARCHAR(255) NOT NULL,
Address2 VARCHAR(255),
City VARCHAR(255) NOT NULL,
State_Name VARCHAR(255) NOT NULL,
Zipcode NUMBER(10) NOT NULL,
Phone NUMBER(10) DEFAULT 0000000000 NOT NULL UNIQUE ,
Gender CHAR,
DOB DATE,
Email_ID VARCHAR(255) NOT NULL,
CONSTRAINT PERSONPK PRIMARY KEY (S_ID),
constraint ckGender check (Gender in ('M', 'F'))
);

CREATE TABLE Mobile_Plans (
Plan_Id NUMBER(10) NOT NULL,
Plan_Name VARCHAR(255) NOT NULL,
Plan_Type NUMBER(1) NOT NULL,
Talktime INTEGER NOT NULL,
Data INTEGER NOT NULL,
Plan_Period NUMBER(1) NOT NULL,
Charge INTEGER NOT NULL,
Payment_Type VARCHAR(8) NOT NULL,
CONSTRAINT MOBILE_PLANSPK PRIMARY KEY (Plan_Id),
constraint ckType check (Plan_Type in (0, 1, 2)),
constraint ckPlanPeriod check (Plan_Period in (0, 1, 2)),
constraint ckPlanType check (Payment_Type in ('Prepaid', 'Postpaid'))
);

CREATE TABLE Account (
Account_Id NUMBER(10) NOT NULL,
Acc_Password VARCHAR(32) NOT NULL,
Activated_Date DATE NOT NULL,
Security_Question NVARCHAR2(255) NOT NULL,
Security_Answer NVARCHAR2(255) NOT NULL,
Billing_Type VARCHAR(9) NOT NULL,
Payment_Type VARCHAR(6) NOT NULL,
Billing_Address NVARCHAR2(255) NOT NULL,
Outstanding_Balance INTEGER,
Plan_Id NUMBER(10) NOT NULL,
Account_Status INTEGER,
CONSTRAINT AccountPK PRIMARY KEY (Account_Id),
CONSTRAINT Account_Mobile_PlansFK FOREIGN KEY (Plan_Id) REFERENCES Mobile_Plans,
constraint ckBillingType check (Billing_Type in ('Paper', 'Paperless')),
constraint ckPaymentType check (Payment_Type in ('EZpay', 'Normal')),
constraint ckAccountStatus check (Account_Status in (0,1))
);

CREATE TABLE Customer (
S_ID NUMBER(10) NOT NULL,
C_ID  NUMBER(10) NOT NULL,
ID_Type NUMBER(1) NOT NULL,
Account_Id NUMBER(10) NOT NULL,
CONSTRAINT CUSTOMERPK PRIMARY KEY (S_ID),
CONSTRAINT CUSTOMER_PERSONFK FOREIGN KEY (S_ID) REFERENCES Person,
CONSTRAINT CUSTOMER_ACCOUNTFK FOREIGN KEY (Account_Id) REFERENCES Account,
constraint ckIDTYPE check (ID_Type in (0, 1, 2))
);

CREATE TABLE Customer_Credit (
S_ID NUMBER(10) NOT NULL,
Credit_Card NUMBER(16) NOT NULL,
Card_Issuer VARCHAR(30) NOT NULL,
Credit_Score INTEGER,
CONSTRAINT CUSTOMER_CREDITPK PRIMARY KEY (S_ID),
CONSTRAINT CUSTOMER_CREDIT_CUSTOMERFK FOREIGN KEY (S_ID) REFERENCES Customer ON DELETE CASCADE
);
 
CREATE TABLE Employee1 (
S_ID NUMBER(10) NOT NULL,
SSN NUMBER(9) NOT NULL UNIQUE,
Work_Email VARCHAR(255),
Salary INTEGER,
Type CHAR,
MgrSID NUMBER(10) NOT NULL,
CONSTRAINT EMPLOYEE1PK PRIMARY KEY (S_ID),
CONSTRAINT EMPLOYEE1_PERSONFK FOREIGN KEY (S_ID) REFERENCES Person,
CONSTRAINT ckTypeEmp check (Type in ('T','S'))
);

ALTER TABLE EMPLOYEE1
ADD CONSTRAINT EMPLOYEE1_EMPLOYEE1FK FOREIGN KEY (MgrSID) REFERENCES Employee1(S_ID);

CREATE TABLE Technician (
Supervision_Area_Code NUMBER(5),
S_ID NUMBER(10) NOT NULL,
Availability VARCHAR(3) DEFAULT 'yes' NOT NULL ,
CONSTRAINT TECHNICIANPK PRIMARY KEY (S_ID),
CONSTRAINT TECHNICIAN_EMPLOYEE1FK FOREIGN KEY (S_ID) REFERENCES Employee1,
CONSTRAINT ckAvailablity check (Availability in ('yes','no'))
);

CREATE TABLE Staff (
Primary_Language NVARCHAR2(25),
S_ID NUMBER(10) NOT NULL,
CONSTRAINT STAFFPK PRIMARY KEY (S_ID),
CONSTRAINT STAFF_EMPLOYEE1FK FOREIGN KEY (S_ID) REFERENCES Employee1
);

CREATE TABLE Bills (
Bill_Id NUMBER(38) NOT NULL,
Cycle_Start_Date DATE NOT NULL,
Cycle_End_DateCycle_End_Date DATE NOT NULL,
Total_Charge INTEGER NOT NULL,
Payment_Due_Date DATE NOT NULL,
Payment_Status INTEGER NOT NULL,
Fines INTEGER DEFAULT 0 NOT NULL,
Original_Charge INTEGER NOT NULL,
Account_Id NUMBER(10) NOT NULL,
CONSTRAINT BILLSPK PRIMARY KEY (Bill_Id),
CONSTRAINT BILLS_ACCOUNTFK FOREIGN KEY (Account_Id) REFERENCES Account ON DELETE CASCADE,
CONSTRAINT ckPayment_Status check (Payment_Status in ('0','1'))
);

CREATE TABLE Customer_Service (
Service_Id NUMBER(38) NOT NULL,
Account_Id NUMBER(10),
Service_Complaint_Description NVARCHAR2(2000) NOT NULL,
Service_Requested_Date DATE,
Service_Completion_Date DATE,
Service_Report NVARCHAR2(2000),
Service_Status INTEGER,
CONSTRAINT CUSTOMER_SRVCPK PRIMARY KEY (Service_Id),
CONSTRAINT CUSTOMER_SRVC_ACCOUNTFK FOREIGN KEY (Account_Id) REFERENCES Account ON DELETE CASCADE
);

CREATE TABLE Staff_Service (
Service_Id NUMBER(38) NOT NULL,
S_ID NUMBER(10) NOT NULL,
Call_Date DATE,
Call_Report NVARCHAR2(2000),
CONSTRAINT STAFF_SRVCPK PRIMARY KEY (Service_Id,S_ID),
CONSTRAINT STAFF_SRVC_CUSTOMER_SRVCFK FOREIGN KEY (Service_Id) REFERENCES Customer_Service ON DELETE CASCADE,
CONSTRAINT STAFF_SRVC_STAFFFK FOREIGN KEY (S_ID) REFERENCES Staff
);

CREATE TABLE Technician_Service (
Service_Id NUMBER(38) NOT NULL,
S_ID NUMBER(10) NOT NULL,
Call_Date DATE,
Call_Report NVARCHAR2(2000),
R_S_ID NUMBER(10) NOT NULL,
CONSTRAINT TECHN_SRVCPK PRIMARY KEY (Service_Id,S_ID),
CONSTRAINT TECHN_SRVC_CUSTOMER_SRVCFK FOREIGN KEY (Service_Id) REFERENCES Customer_Service ON DELETE CASCADE,
CONSTRAINT TECHN_SRVC_TECHNICIANFK FOREIGN KEY (S_ID) REFERENCES Technician
);


CREATE TABLE Mobile_Nos (
Mobile_No NUMBER(10) NOT NULL,
IMSI NUMBER(15) NOT NULL,
PUK NUMBER(8) NOT NULL,
Type VARCHAR(8) NOT NULL,
Activate_By_Date DATE NOT NULL,
Availability NUMBER(1) NOT NULL,
CONSTRAINT MOBILE_NOSPK PRIMARY KEY (Mobile_No),
constraint ckTypeMobNos check (Type in ('Prepaid', 'Postpaid')),
constraint ckAvailability check (Availability in (0,1))
);

CREATE TABLE Mobile (
Mobile_No NUMBER(10) NOT NULL,
Account_Id NUMBER(10) NOT NULL,
CONSTRAINT MOBILEPK PRIMARY KEY (Mobile_No),
CONSTRAINT MOBILE_ACCOUNTFK FOREIGN KEY (Account_Id) REFERENCES Account ON DELETE CASCADE
);

CREATE TABLE M_Service_Plans (
M_Service_Id NUMBER(10) NOT NULL,
Service_Name VARCHAR(255) NOT NULL,
Charge INTEGER NOT NULL,
CONSTRAINT M_SRVC_PLANSPK PRIMARY KEY (M_Service_Id)
);

CREATE TABLE Mobile_Services (
Mobile_No NUMBER(10) NOT NULL,
M_Service_Id NUMBER(10) NOT NULL,
CONSTRAINT MOBILE_SRVCSPK PRIMARY KEY (Mobile_No,M_Service_Id),
CONSTRAINT MOBILE_SRVCS_MOBILEFK FOREIGN KEY (Mobile_No) REFERENCES Mobile ON DELETE CASCADE,
CONSTRAINT MOBILE_SRVCS_M_SRVCS_PLANSFK FOREIGN KEY (M_Service_Id) REFERENCES M_Service_Plans
);

CREATE TABLE Mobile_Transactions (
Transaction_ID NUMBER(38) NOT NULL,
Mobile_No NUMBER(10) NOT NULL,
MT_Date DATE NOT NULL,
MT_Time TIMESTAMP(0) NOT NULL,
MT_Type NUMBER(1) NOT NULL,
CONSTRAINT MOBILE_XSPK PRIMARY KEY (Transaction_ID),
CONSTRAINT MOBILE_XS_MOBILEFK FOREIGN KEY (Mobile_No) REFERENCES Mobile ON DELETE CASCADE,
CONSTRAINT ckTypeMobTrans check (MT_Type in (0, 1, 2))
);

CREATE TABLE MT_Call	(
Transaction_ID NUMBER(38) NOT NULL,
Destination VARCHAR(255),
Call_Number NUMBER(10),
Minutes INTEGER,
CONSTRAINT MT_CALLPK PRIMARY KEY (Transaction_ID),
CONSTRAINT MT_CALL_MOBILE_XSFK FOREIGN KEY (Transaction_ID) REFERENCES Mobile_Transactions ON DELETE CASCADE
);
	
CREATE TABLE MT_Text	( 
Transaction_ID NUMBER(38) NOT NULL,
Destination VARCHAR(255),
Text_Number NUMBER(10),
Direction VARCHAR(8),
CONSTRAINT MT_TEXTPK PRIMARY KEY (Transaction_ID),
CONSTRAINT MT_TEXT_MOBILE_XSFK FOREIGN KEY (Transaction_ID) REFERENCES Mobile_Transactions ON DELETE CASCADE,  
CONSTRAINT ckDirection check (Direction in ('Outgoing','Incoming'))
);
  
CREATE TABLE MT_Data	(
Transaction_ID NUMBER(38) NOT NULL,
Data_Usage DECIMAL(7,3),
CONSTRAINT MT_DATAPK PRIMARY KEY (Transaction_ID),
CONSTRAINT MT_DATA_MOBILE_XSFK FOREIGN KEY (Transaction_ID) REFERENCES Mobile_Transactions ON DELETE CASCADE
);
	
CREATE TABLE Services	(
Service_Id NUMBER(10) NOT NULL,
Service_Name VARCHAR(255) NOT NULL,
Monthy_Charge INTEGER NOT NULL,
CONSTRAINT SERVICESPK PRIMARY KEY (Service_Id)
);
	
CREATE TABLE Account_Services	(
Account_Id NUMBER(10),
Service_Id NUMBER(10),
CONSTRAINT ACCOUNT_SRVCSPK PRIMARY KEY (Account_Id,Service_Id),
CONSTRAINT ACCOUNT_SRVCS_ACCOUNTFK FOREIGN KEY (Account_Id) REFERENCES Account ON DELETE CASCADE,
CONSTRAINT ACCOUNT_SRVCS_SRVCSFK FOREIGN KEY (Service_Id) REFERENCES Services
);
	
CREATE TABLE Service_Transactions (
Transaction_Id NUMBER(38) NOT NULL,
ST_Date DATE NOT NULL,
ST_Time TIMESTAMP(0) NOT NULL,
Account_Id NUMBER(10),
Service_Id NUMBER(10),
ST_Duration INTEGER NOT NULL,
CONSTRAINT SRVC_XSPK PRIMARY KEY (Transaction_Id),
CONSTRAINT SRVC_XS_ACCOUNT_SRVCSFK FOREIGN KEY (Account_Id,Service_Id) REFERENCES Account_Services ON DELETE CASCADE
);

