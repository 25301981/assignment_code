USE Limpopo_MicroLoans_DB;

-- Clients
INSERT INTO Client (FirstName, LastName, IDNumber, DateOfBirth, PhoneNumber, Email, Address)
VALUES
('Thabo', 'Mokgadi', '8001015009081', '1980-01-01', '0821234567', 'thabo.mokgadi@limpopoloans.co.za', '1 Baobab St, Polokwane'),
('Linda', 'Ramphora', '9002025009082', '1990-02-02', '0832345678', 'linda.ramphora@limpopoloans.co.za', '2 Mopani Rd, Tzaneen'),
('Sipho', 'Dlamini', '8503035009083', '1985-03-03', '0843456789', 'sipho.dlamini@limpopoloans.co.za', '3 Marula Ave, Giyani'),
('Patricia', 'Ndlovu', '8804045009084', '1988-04-04', '0824567890', 'patricia.ndlovu@limpopoloans.co.za', '4 Mahogany St, Phalaborwa'),
('Moses', 'Makhado', '8305055009085', '1983-05-05', '0835678901', 'moses.makhado@limpopoloans.co.za', '5 Mopani Rd, Polokwane');

-- Staff
INSERT INTO Staff (FirstName, LastName, Position, PhoneNumber, Email)
VALUES
('Marius', 'Van Wyk', 'Loan Officer', '0811111111', 'marius@limpopoloans.co.za'),
('Nomsa', 'Zulu', 'Branch Manager', '0822222222', 'nomsa@limpopoloans.co.za'),
('Pule', 'Khumalo', 'Loan Officer', '0833333333', 'pule@limpopoloans.co.za');

-- LoanTypes
INSERT INTO LoanType (TypeName, MaxAmount, InterestRate)
VALUES
('Personal', 50000, 10.5),
('Business', 150000, 12.0),
('Emergency', 20000, 8.5);

-- Loans
INSERT INTO Loan (ClientID, LoanTypeID, StaffID, LoanAmount, InterestRate, StartDate, DueDate, Status)
VALUES
(1, 1, 1, 30000, 10.5, '2025-01-01', '2025-12-31', 'Active'),
(2, 2, 2, 100000, 12.0, '2025-02-01', '2026-01-31', 'Active'),
(3, 3, 1, 15000, 8.5, '2025-03-01', '2025-08-31', 'Active'),
(4, 1, 3, 40000, 10.5, '2025-04-01', '2026-03-31', 'Active'),
(5, 2, 2, 120000, 12.0, '2025-05-01', '2026-04-30', 'Active');

-- Repayments
INSERT INTO Repayment (LoanID, PaymentDate, PaymentAmount, BalanceRemaining)
VALUES
(1, '2025-02-01', 5000, 25000),
(1, '2025-03-01', 5000, 20000),
(2, '2025-03-01', 10000, 90000),
(3, '2025-04-01', 3000, 12000),
(4, '2025-05-01', 7000, 33000),
(5, '2025-06-01', 15000, 105000);

-- Penalties
INSERT INTO Penalty (LoanID, PenaltyAmount, PenaltyDate, Reason, Status)
VALUES
(1, 500, '2025-04-01', 'Late Payment', 'Unpaid'),
(2, 1000, '2025-05-01', 'Late Payment', 'Unpaid'),
(3, 200, '2025-05-15', 'Missed Payment', 'Unpaid'),
(4, 300, '2025-06-01', 'Late Payment', 'Unpaid'),
(5, 500, '2025-06-15', 'Missed Payment', 'Unpaid');

-- Insert paid loans
INSERT INTO Loan (ClientID, LoanTypeID, StaffID, LoanAmount, InterestRate, StartDate, DueDate, Status)
VALUES (1, 2, 1, 10000.00, 5.5, '2025-01-01', '2025-06-01', 'Active');

INSERT INTO Repayment (LoanID, PaymentDate, PaymentAmount, BalanceRemaining)
VALUES 
(LAST_INSERT_ID(), '2025-02-01', 5000.00, 5000.00),
(LAST_INSERT_ID(), '2025-03-01', 5000.00, 0.00);


