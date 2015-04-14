-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2015-04-14 15:34:51.841




-- tables
-- Table: Accounts
CREATE TABLE Accounts (
    AcctID int  NOT NULL,
    type varchar(50)  NOT NULL,
    BankID int  NOT NULL,
    CONSTRAINT BankIDAcct UNIQUE (BankID),
    CONSTRAINT Accounts_pk PRIMARY KEY (AcctID)
)
;





-- Table: Banks
CREATE TABLE Banks (
    BankID int  NOT NULL,
    Name varchar(200)  NOT NULL,
    Street varchar(255)  NOT NULL,
    City varchar(50)  NOT NULL,
    ZIP int  NOT NULL,
    Phone bigint  NOT NULL,
    CONSTRAINT Banks_pk PRIMARY KEY (BankID)
)
;





-- Table: Categories
CREATE TABLE Categories (
    CategoryID int  NOT NULL,
    Name varchar(50)  NOT NULL,
    TaxDeductible bit  NOT NULL,
    CONSTRAINT Categories UNIQUE (Name),
    CONSTRAINT Categories_pk PRIMARY KEY (CategoryID)
)
;





-- Table: Loans
CREATE TABLE Loans (
    LoanID int  NOT NULL,
    Name varchar(100)  NOT NULL,
    BankID int  NOT NULL,
    Company varchar(100)  NOT NULL,
    CONSTRAINT Loans_pk PRIMARY KEY (LoanID)
)
;





-- Table: Payees
CREATE TABLE Payees (
    Name varchar(100)  NOT NULL,
    LastAmount decimal(10,2)  NOT NULL,
    Category varchar(50)  NOT NULL,
    Note text  NOT NULL,
    "To" varchar(100)  NOT NULL,
    CONSTRAINT CategoryName UNIQUE (Category),
    CONSTRAINT Payees_pk PRIMARY KEY (Name)
)
;





-- Table: Transactions
CREATE TABLE Transactions (
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
    CONSTRAINT AcctID UNIQUE (AcctID),
    CONSTRAINT CategoryCat UNIQUE (CategoryID),
    CONSTRAINT Transactions_pk PRIMARY KEY (TransID)
)
;









-- foreign keys
-- Reference:  AcctID (table: Transactions)


ALTER TABLE Transactions ADD CONSTRAINT AcctID 
    FOREIGN KEY (AcctID)
    REFERENCES Accounts (AcctID)
;

-- Reference:  BankID (table: Accounts)


ALTER TABLE Accounts ADD CONSTRAINT BankID 
    FOREIGN KEY (BankID)
    REFERENCES Banks (BankID)
;

-- Reference:  Banks_Loans (table: Loans)


ALTER TABLE Loans ADD CONSTRAINT Banks_Loans 
    FOREIGN KEY (BankID)
    REFERENCES Banks (BankID)
;

-- Reference:  CategoriesPay (table: Payees)


ALTER TABLE Payees ADD CONSTRAINT CategoriesPay 
    FOREIGN KEY (Category)
    REFERENCES Categories (Name)
;

-- Reference:  CategoriesTran (table: Transactions)


ALTER TABLE Transactions ADD CONSTRAINT CategoriesTran 
    FOREIGN KEY (CategoryID)
    REFERENCES Categories (CategoryID)
;

-- Reference:  Payees_Loans (table: Loans)


ALTER TABLE Loans ADD CONSTRAINT Payees_Loans 
    FOREIGN KEY (Company)
    REFERENCES Payees (Name)
;





-- End of file.

