-- Retrieve all loans for Client 1 > Thabo Mokgadi
SELECT 
    L.LoanID, L.LoanAmount, L.InterestRate, L.StartDate, L.DueDate, L.Status, C.ClientID, C.FirstName, C.LastName, C.Email, C.PhoneNumber
FROM Loan L
INNER JOIN Client C
    ON L.ClientID = C.ClientID
WHERE L.ClientID = 1;

select * from  Loan L;

-- Unsettled penalties
SELECT C.ClientID, C.FirstName, C.LastName, C.IDNumber, C.DateOfBirth, C.PhoneNumber, C.Email, C.Address, P.PenaltyID, P.LoanID, P.PenaltyAmount, P.PenaltyDate, P.Reason, P.Status 
FROM Client C 
INNER JOIN Loan L ON C.ClientID = L.ClientID 
INNER JOIN Penalty P ON L.LoanID = P.LoanID 
WHERE P.Status = 'Unpaid';

-- Update loan status to 'Paid' after full repayment using CTE
WITH LoanRepayments AS (
    SELECT 
        L.LoanID, L.LoanAmount, L.Status AS CurrentStatus, IFNULL(SUM(R.PaymentAmount), 0) AS TotalPaid
    FROM Loan L
    LEFT JOIN Repayment R
        ON L.LoanID = R.LoanID
    GROUP BY L.LoanID, L.LoanAmount, L.Status
)
UPDATE Loan L
JOIN LoanRepayments LR
    ON L.LoanID = LR.LoanID
SET L.Status = 'Paid'
WHERE LR.TotalPaid >= LR.LoanAmount
AND L.Status <> 'Paid';

-- Delete panalty by id
DELETE FROM Penalty
WHERE PenaltyID = 1;

-- Total repayments per client
SELECT  
	C.ClientID, C.FirstName, C.LastName, SUM(R.PaymentAmount) AS TotalRepayments
FROM Client C
INNER JOIN Loan L ON C.ClientID = L.ClientID
INNER JOIN Repayment R ON L.LoanID = R.LoanID
GROUP BY C.ClientID, C.FirstName, C.LastName
ORDER BY C.ClientID;
