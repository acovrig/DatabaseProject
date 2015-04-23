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
-- Table: Banks
CREATE TABLE [Banks] (
    BankID int  NOT NULL PRIMARY KEY,
    Name varchar(200)  NOT NULL,
    Street varchar(255)  NOT NULL,
    City varchar(50)  NOT NULL,
    ZIP int  NOT NULL,
    Phone bigint  NOT NULL
);

-- Table: Accounts
CREATE TABLE [Accounts] (
    AcctID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    type varchar(50)  NOT NULL,
    BankID int  NOT NULL,
    CONSTRAINT BankID FOREIGN KEY (BankID) REFERENCES Banks (BankID)
);

-- Table: Categories
CREATE TABLE [Category] (
    CategoryID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(50)  NOT NULL,
    TaxDeductible bit  NOT NULL,
    CONSTRAINT Categories UNIQUE (Name)
);

-- Table: Payees
CREATE TABLE [Payees] (
    Name varchar(100)  NOT NULL UNIQUE,
    LastAmount decimal(10,2)  NOT NULL,
    Category varchar(50)  NOT NULL,
    Note text  NOT NULL,
    "To" varchar(100)  NOT NULL,
    CONSTRAINT CategoryName UNIQUE (Category),
    CONSTRAINT CategoriesPay FOREIGN KEY (Category) REFERENCES Category (Name)
);

-- Table: Loans
CREATE TABLE [Loans] (
    LoanID int  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(100)  NOT NULL,
    BankID int  NOT NULL,
    Company varchar(100)  NOT NULL,
    CONSTRAINT Payees_Loans FOREIGN KEY (Company) REFERENCES Payees (Name),
    CONSTRAINT Banks_Loans FOREIGN KEY (BankID) REFERENCES Banks (BankID)
);

-- Table: Transactions
CREATE TABLE [Transactions] (
    TransID int  NOT NULL,
    Amount decimal(10,2)  NOT NULL,
    AcctID int  NOT NULL,
    "To" varchar(100)  NOT NULL,
    "From" varchar(100)  NOT NULL,
    CategoryID int  NOT NULL,
    Note text  NOT NULL,
    Reconciled bit  NOT NULL,
    CheckNum bit  NOT NULL,
    Image image  NOT NULL,
    CONSTRAINT AcctIDConstraint FOREIGN KEY (AcctID) REFERENCES Accounts (AcctID),
    CONSTRAINT CategoriesTran FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

-- End of file.