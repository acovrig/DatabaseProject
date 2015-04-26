-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2015-04-14 15:34:51.841

USE master
IF EXISTS(select * from sys.databases where name='Money')
	DROP DATABASE Money
	CREATE DATABASE Money
GO
USE Money
GO

-- tables
-- Table: Bank
CREATE TABLE [Bank] (
    BankID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(200)  NOT NULL,
    Street varchar(255)  NOT NULL,
    City varchar(50)  NOT NULL,
    ZIP int  NOT NULL,
    Phone bigint  NOT NULL
);

-- Table: BankAccount
CREATE TABLE [BankAccount] (
    AcctID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] varchar(50) NOT NULL,
    [Type] varchar(50)  NOT NULL,
    BankID int  NOT NULL,
    CONSTRAINT BankID FOREIGN KEY (BankID) REFERENCES Bank (BankID)
);

-- Table: Category
CREATE TABLE [Category] (
    CategoryID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(50)  NOT NULL,
    TaxDeductible bit  NOT NULL,
    CONSTRAINT Categories UNIQUE (Name)
);

-- Table: Payee
CREATE TABLE [Payee] (
    Name varchar(100)  NOT NULL UNIQUE,
    LastAmount decimal(10,2)  NOT NULL,
    Category varchar(50)  NOT NULL,
    Note text  NOT NULL,
    CONSTRAINT CategoriesPay FOREIGN KEY (Category) REFERENCES Category (Name)
);

-- Table: Loan
CREATE TABLE [Loan] (
    LoanID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(100)  NOT NULL,
    BankID int  NOT NULL,
    Company varchar(100)  NOT NULL,
    CONSTRAINT Payees_Loans FOREIGN KEY (Company) REFERENCES Payee (Name),
    CONSTRAINT Banks_Loans FOREIGN KEY (BankID) REFERENCES Bank (BankID)
);

-- Table: Transaction
CREATE TABLE [Transaction] (
    TransID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TransDate date NOT NULL,
	Amount decimal(10,2) NOT NULL,
    AcctID int  NOT NULL,
    "To" varchar(100)  NOT NULL,
    CategoryID int  NOT NULL,
    Note text  NOT NULL,
    Reconciled bit  NOT NULL,
    CheckNum INT  NOT NULL,
    CONSTRAINT AcctIDConstraint FOREIGN KEY (AcctID) REFERENCES BankAccount (AcctID),
    CONSTRAINT CategoriesTran FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

-- End of file.

GO
INSERT INTO [Bank] (Name, Street, City, ZIP, Phone) VALUES ('SunTrust', '9526 Apison Pike', 'Collegedale', 37315, 4239106000);
INSERT INTO [Bank] (Name, Street, City, ZIP, Phone) VALUES ('The Farmers Bank', '9527 Apison Pike', 'Collegedale', 37315, 4239106001);
INSERT INTO [BankAccount] (Type, Name, BankID) VALUES ('Checking', 'SunTrust Checking', 1);
INSERT INTO [BankAccount] (Type, Name, BankID) VALUES ('Savings', 'SunTrust Savings', 1);
INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Food', 0);
INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Utilities', 1);
INSERT INTO [Transaction] (Amount, TransDate, AcctID, [To], CategoryID, Note, Reconciled, CheckNum) VALUES (50.37, '2015-04-25', 1, 'Walmart', 1, 'Food for the week, how boring', 0, 0);
INSERT INTO [Transaction] (Amount, TransDate, AcctID, [To], CategoryID, Note, Reconciled, CheckNum) VALUES (506.39, '2015-04-27', 2, 'BestBuy', 2, 'Emergency HDD replacements', 0, 0);
INSERT INTO [Payee] (Name, LastAmount, Category, Note) VALUES ('Comcast', 250, 'Utilities', 'Crappy internet');
INSERT INTO [Payee] (Name, LastAmount, Category, NOte) VALUES ('Sprint', 350, 'Utilities', 'Unlimited Data');
GO
/*
CREATE LOGIN [web] WITH	PASSWORD = 'IQx2>WGX3R-5gX8keljj';
GO
*/
CREATE USER [web] FOR LOGIN [web];
GO