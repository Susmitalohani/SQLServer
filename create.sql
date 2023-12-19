

CREATE TABLE patient(
 patient_id INT PRIMARY KEY IDENTITY,
 first_name VARCHAR(50) NOT NULL ,
 middle_name VARCHAR(50),
 last_name VARCHAR(50) NOT NULL,
 nationality VARCHAR(50)NOT NULL,
 gender VARCHAR(10) NOT NULL,
 address VARCHAR(50) NOT NULL,
 age VARCHAR(20)NOT NULL,
 phone VARCHAR(15) NOT NULL,
 email VARCHAR(50) UNIQUE,
 doctor_id INT FOREIGN KEY REFERENCES doctor(doctor_id),


 )


 CREATE TABLE doctor(
 doctor_id INT PRIMARY KEY IDENTITY,
 first_name VARCHAR(50) NOT NULL,
 middle_name VARCHAR(50),
 last_name VARCHAR(50)  NOT NULL,
 specialist VARCHAR(50)  NOT NULL
 )

 CREATE TABLE employee(
 emp_id INT PRIMARY KEY IDENTITY,
 first_name VARCHAR(50) NOT NULL ,
 middle_name VARCHAR(50),
 last_name varchar(50) NOT NULL,
 gender VARCHAR(10) NOT NULL,
 address VARCHAR(50) NOT NULL,
 age VARCHAR(20)NOT NULL,
 phone VARCHAR(15) NOT NULL,
 email VARCHAR(50) UNIQUE,
 )

 CREATE TABLE department(
 dep_id INT PRIMARY KEY IDENTITY,
 dep_name VARCHAR(50) NOT NULL,
 emp_id INT FOREIGN KEY REFERENCES dbo.employee(emp_id),
 )


 CREATE TABLE appointment(
  app_id INT PRIMARY KEY IDENTITY,
  app_type VARCHAR(30) NOT NULL,
  create_date VARCHAR(30) NOT null,
  app_date DATE NOT null,
  app_time TIME NOT null,
  patient_id INT FOREIGN KEY REFERENCES dbo.patient(patient_id)
  )

  CREATE  TABLE room(
  room_no INT PRIMARY KEY IDENTITY,
  room_type VARCHAR(50) NOT NULL,
  patient_id INT FOREIGN KEY REFERENCES patient(patient_id) NOT  NULL
  )

  CREATE TABLE bill(
  bill_no INT PRIMARY KEY IDENTITY,
  patient_id INT FOREIGN KEY REFERENCES dbo.patient(patient_id)NOT NULL,
  doctor_charge MONEY NOT NULL,
  medicine_charge MONEY,
  room_charge MONEY,
  operation_charge MONEY,
  no_of_days INT,
  nursing_charge MONEY,
  lab_charge MONEY,
  advance MONEY,
  total_bill MONEY NOT null
  )

  CREATE TABLE report(
  patient_id INT FOREIGN KEY REFERENCES dbo.patient(patient_id),
  report_id INT PRIMARY KEY IDENTITY,
  diagnose VARCHAR(50),
  medicine_id INT
  )

  CREATE TABLE medicine(
  medicine_id INT PRIMARY KEY NOT NULL,
  medicine_name VARCHAR(50) NOT NULL,
  medicine_cost MONEY NOT NULL,
  patient_id INT FOREIGN KEY REFERENCES dbo.patient(patient_id)
  )


  CREATE TABLE hospital_details(
  hospital_id INT PRIMARY KEY IDENTITY,
  hospital_name VARCHAR(50) NOT NULL,
  area VARCHAR(50) NOT NULL,
  road VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL
  )

  CREATE TABLE payroll(
  emp_id INT FOREIGN KEY REFERENCES dbo.employee(emp_id) NOT NULL,
  salary MONEY NOT NULL,
  bonus_salary MONEY,
  account_no INT NOT NULL
  )

  CREATE TABLE lab(
  emp_id INT FOREIGN KEY REFERENCES dbo.employee(emp_id) NOT NULL,
  lab_no INT PRIMARY KEY IDENTITY NOT NULL,
  patient_id INT FOREIGN KEY REFERENCES dbo.patient(patient_id) NOT NULL,
  test_type VARCHAR(50) NOT NULL ,
  test_code VARCHAR(50) NOT NULL,
  weight FLOAT,
  height FLOAT,
  BP FLOAT,
  temp FLOAT,
  report_id INT FOREIGN KEY REFERENCES dbo.report(report_id) NOT NULL
  )

  IF OBJECT_ID('sp_patient') IS NOT NULL
DROP PROC sp_patient;

CREATE PROC sp_patient 
	@patient_id INt ,
	@first_name VARCHAR(50) NOT NULL ,
	@middle_name VARCHAR(50),
	@last_name varchar(50) NOT NULL,
	@nationality VARCHAR(50)NOT NULL,
	@gender VARCHAR(10) NOT NULL,
	@address VARCHAR(50) NOT NULL,
	@age VARCHAR(20)NOT NULL,
	@phone VARCHAR(15) NOT NULL,
	@email VARCHAR(50),
	@flag varchar(1)
AS
BEGIN 
IF @flag = 'i'
BEGIN 
IF @patient_id NOT IN (SELECT @patient_id FROM patient)
BEGIN 
	print 'Invalid patient_id.';
	RETURN;
END;
IF @nationality NOT IN (SELECT @patient_id FROM patient)
BEGIN 
	print 'Invalid patient_id.';
	RETURN;
END;


IF @first_name NOT IN 
		THROW 50001,'Please enter first name.',1;
IF @last_name IS NULL
		THROW 50001,'Please enter last name.',1;
IF @nationality IS NULL
		THROW 50001,'Please enter nationality.',1;
IF @gender IS NULL
		THROW 50001,'Please enter gender.',1;
IF @address IS NULL
		THROW 50001,'Please enter address.',1;
IF @phone IS NULL
		THROW 50001,'Please enter mobile number.',1;
IF @email IS NULL
		THROW 50001,'Please enter email address.',1;
IF  @email! =('^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a??-zA-Z]{2,4}$')
  THROW 50001,'Please enter the correct email address',1;



