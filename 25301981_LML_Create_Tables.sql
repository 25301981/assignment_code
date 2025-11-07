-- 1. Create Database
CREATE DATABASE IF NOT EXISTS Limpopo_MicroLoans_DB;
USE Limpopo_MicroLoans_DB;

-- 2. Create Tables
CREATE TABLE Client (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    IDNumber VARCHAR(20) UNIQUE NOT NULL,
    DateOfBirth DATE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(255) NOT NULL
);

CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE LoanType (
    LoanTypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50) NOT NULL,
    MaxAmount DECIMAL(15,2) NOT NULL,
    InterestRate DECIMAL(5,2) NOT NULL
);

CREATE TABLE Loan (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT NOT NULL,
    LoanTypeID INT NOT NULL,
    StaffID INT NOT NULL,
    LoanAmount DECIMAL(15,2) NOT NULL,
    InterestRate DECIMAL(5,2) NOT NULL,
    StartDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    Status ENUM('Active','Paid','Overdue') NOT NULL DEFAULT 'Active',
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (LoanTypeID) REFERENCES LoanType(LoanTypeID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Repayment (
    RepaymentID INT AUTO_INCREMENT PRIMARY KEY,
    LoanID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentAmount DECIMAL(15,2) NOT NULL,
    BalanceRemaining DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);

CREATE TABLE Penalty (
    PenaltyID INT AUTO_INCREMENT PRIMARY KEY,
    LoanID INT NOT NULL,
    PenaltyAmount DECIMAL(10,2) NOT NULL,
    PenaltyDate DATE NOT NULL,
    Reason VARCHAR(255) NOT NULL,
    Status ENUM('Paid','Unpaid') NOT NULL DEFAULT 'Unpaid',
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);
