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
    BankID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(200) NOT NULL,
    Street varchar(255) NOT NULL,
    City varchar(50) NOT NULL,
    ZIP int NOT NULL,
    Phone bigint NOT NULL
);

-- Table: BankAccount
CREATE TABLE [BankAccount] (
    AcctID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] varchar(50) NOT NULL,
    [Type] varchar(50) NOT NULL,
    BankID int NOT NULL,
    CONSTRAINT BankID FOREIGN KEY (BankID) REFERENCES Bank (BankID)
);

-- Table: Category
CREATE TABLE [Category] (
    CategoryID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(50) NOT NULL,
    TaxDeductible bit NOT NULL,
    CONSTRAINT Categories UNIQUE (Name)
);

-- Table: RecurringTransaction
CREATE TABLE [RecurringTransaction] (
    RecurringTransactionIDNumberThingyIDoNotLikeThisProject int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name varchar(100) NOT NULL UNIQUE,
    ExpectedAmount decimal(10,2) NOT NULL,
    Category varchar(50) NOT NULL,
    Note text NOT NULL,
    CONSTRAINT CategoriesPay FOREIGN KEY (Category) REFERENCES Category (Name)
);

-- Table: Transaction
CREATE TABLE [Transaction] (
    TransID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TransDate date NOT NULL,
	Amount decimal(10,2) NOT NULL,
    AcctID int NOT NULL,
    ToFrom varchar(100) NOT NULL,
    CategoryID int NOT NULL,
    Note text NOT NULL,
    Reconciled bit NOT NULL,
    CheckNum INT NOT NULL,
    CONSTRAINT AcctIDConstraint FOREIGN KEY (AcctID) REFERENCES BankAccount (AcctID),
    CONSTRAINT CategoriesTran FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);

-- End of file.

GO

INSERT INTO [Bank] ([Name],[Street],[City],[ZIP],[Phone]) VALUES ('SunTrust','304-3629 Metus Ave','Millet','49000','7362957001');
INSERT INTO [Bank] ([Name],[Street],[City],[ZIP],[Phone]) VALUES ('PNC Bank','1013 Venenatis Street','Avise','52319','9558756503');
INSERT INTO [Bank] ([Name],[Street],[City],[ZIP],[Phone]) VALUES ('Collegedale Credit Union','P.O. Box 552, 6981 Aliquet St.','Lomza','13200','1798487826');

INSERT INTO [BankAccount] (Type, Name, BankID) VALUES ('Checking', 'SunTrust Checking', 1)
INSERT INTO [BankAccount] (Type, Name, BankID) VALUES ('Checking', 'PNC Checking', 2)
INSERT INTO [BankAccount] (Type, Name, BankID) VALUES ('Savings', 'Credit Union', 3)
INSERT INTO [BankAccount] (Type, Name, BankID) VALUES ('Loan', 'Car loan', 3)

INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Miscellaneous', 0);
INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Food', 0);
INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Utilities', 0);
INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Donations', 1);
INSERT INTO [Category] (Name, TaxDeductible) VALUES ('Loans', 0);

INSERT INTO [RecurringTransaction] (Name, ExpectedAmount, Category, Note) VALUES ('Comcast', 250.00, 'Utilities', 'Crappy internet');
INSERT INTO [RecurringTransaction] (Name, ExpectedAmount, Category, Note) VALUES ('Sprint', 350.00, 'Utilities', 'Unlimited data');

INSERT INTO [Transaction] (Amount, TransDate, AcctID, ToFrom, CategoryID, Note, Reconciled, CheckNum) VALUES
    (1000.00, '2014-06-01', 3, 'Initial', 1, 'Initial commit', 1, 0),
    (-200.00, '2015-01-01', 3, 'SunTrust checking', 1, 'Initial to SunTrust', 1, 0),
    (200.00, '2015-01-01', 1, 'savings', 1, 'Initial commit', 1, 0),
    (-200.00, '2015-02-01', 3, 'PNC checking', 1, 'Initial to PNC', 1, 0),
    (200.00, '2015-02-01', 2, 'savings', 1, 'Initial commit', 1, 0),
    (-5000.00, '2015-03-15', 4, 'Credit union', 5, 'Initial borrow', 1, 0),
    (-50.37, '2015-03-25', 1, 'Walmart', 2, 'Food for the week', 0, 0),
    (-350.00, '2015-03-27', 3, 'PNC checking', 1, 'Emergency transfer', 0, 0),
    (350.00, '2015-03-27', 2, 'savings', 1, 'Emergency transfer', 0, 0),
    (-506.39, '2015-03-27', 2, 'BestBuy', 3, 'Emergency HDD replacements', 0, 1001),
    (-50.00, '2015-04-15', 4, 'Credit union', 5, 'Interest', 0, 0),
    (100.00, '2015-04-15', 4, 'Credit union', 5, 'Payment', 0, 0);
GO
/*
CREATE LOGIN [web] WITH	PASSWORD = 'IQx2>WGX3R-5gX8keljj';
GO
*/
CREATE USER [web] FOR LOGIN [web];
GO