-- Created by Vertabelo (http://vertabelo.com)
-- Script type: create
-- Scope: [tables, references, sequences, views, procedures]
-- Generated at Thu Mar 19 16:36:43 UTC 2015




-- tables
-- Table Accounts
CREATE TABLE Accounts (
    AcctID int    NOT NULL ,
    type varchar(50)    NOT NULL ,
    BankID int    NOT NULL ,
    UNIQUE INDEX BankIDAcct (BankID),
    CONSTRAINT Accounts_pk PRIMARY KEY (AcctID)
);

-- Table Banks
CREATE TABLE Banks (
    BankID int    NOT NULL ,
    Name varchar(200)    NOT NULL ,
    Address varchar(255)    NOT NULL ,
    Phone bigint    NOT NULL ,
    CONSTRAINT Banks_pk PRIMARY KEY (BankID)
);

-- Table Categories
CREATE TABLE Categories (
    CategoryID int    NOT NULL ,
    Name varchar(50)    NOT NULL ,
    TaxDeductible bool    NOT NULL ,
    UNIQUE INDEX Categories (Name),
    CONSTRAINT Categories_pk PRIMARY KEY (CategoryID)
);

-- Table Payees
CREATE TABLE Payees (
    Name varchar(100)    NOT NULL ,
    LastAmount decimal(10,2)    NOT NULL ,
    Category varchar(50)    NOT NULL ,
    Note text    NOT NULL ,
    `To` varchar(100)    NOT NULL ,
    UNIQUE INDEX CategoryName (Category),
    CONSTRAINT Payees_pk PRIMARY KEY (Name)
);

-- Table Tithe
CREATE TABLE Tithe (
    TransID int    NOT NULL ,
    Tithe decimal(10,2)    NOT NULL ,
    Paid bool    NOT NULL ,
    UNIQUE INDEX Tithe_ak_1 (TransID),
    CONSTRAINT Tithe_pk PRIMARY KEY (TransID)
);

-- Table Transactions
CREATE TABLE Transactions (
    TransID int    NOT NULL ,
    Amount decimal(10,2)    NOT NULL ,
    AcctID int    NOT NULL ,
    `To` varchar(100)    NOT NULL ,
    `From` varchar(100)    NOT NULL ,
    CategoryID int    NOT NULL ,
    Note text    NOT NULL ,
    Reconciled bool    NOT NULL ,
    CheckNum bool    NOT NULL ,
    Image blob    NOT NULL ,
    UNIQUE INDEX AcctID (AcctID),
    UNIQUE INDEX CategoryCat (CategoryID),
    CONSTRAINT Transactions_pk PRIMARY KEY (TransID)
);





-- foreign keys
-- Reference:  AcctID (table: Transactions)


ALTER TABLE Transactions ADD CONSTRAINT AcctID FOREIGN KEY AcctID (AcctID)
    REFERENCES Accounts (AcctID)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;
-- Reference:  BankID (table: Accounts)


ALTER TABLE Accounts ADD CONSTRAINT BankID FOREIGN KEY BankID (BankID)
    REFERENCES Banks (BankID)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;
-- Reference:  CategoriesPay (table: Payees)


ALTER TABLE Payees ADD CONSTRAINT CategoriesPay FOREIGN KEY CategoriesPay (Category)
    REFERENCES Categories (Name)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;
-- Reference:  CategoriesTran (table: Transactions)


ALTER TABLE Transactions ADD CONSTRAINT CategoriesTran FOREIGN KEY CategoriesTran (CategoryID)
    REFERENCES Categories (CategoryID)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;
-- Reference:  Tithe_Transactions (table: Tithe)


ALTER TABLE Tithe ADD CONSTRAINT Tithe_Transactions FOREIGN KEY Tithe_Transactions (TransID)
    REFERENCES Transactions (TransID);



-- End of file.

