--Customer
USE SmartBankingDB;

--1 What is my account balance?
CREATE Procedure AccountBalance
@ID INT
AS
BEGIN
     SELECT B.BranchName, sum(A.Balance)
     FROM Branches B JOIN Accounts A ON A.BranchID=B.BranchID
     WHERE CustomerID=@ID
     GROUP BY B.BranchName
END
exec AccountBalance 13

--2 What are my last 10 transactions?
CREATE Procedure last_10_transactions
@ID INT
AS
BEGIN
     SELECT TOP 10  T.TransactionID, T.TransactionDate, T.Amount, T.TransactionType
     FROM Transactions T JOIN Accounts A ON T.AccountID = A.AccountID
     WHERE A.CustomerID=@ID
     ORDER BY TransactionDate DESC
END
exec last_10_transactions 13

--3 How many accounts do I have?
CREATE Procedure TotalAccounts
@ID INT
AS
BEGIN
     SELECT COUNT(AccountID) 
     FROM Accounts
     WHERE CustomerID=@ID
END
exec TotalAccounts 13

--4 What is the total amount of money I have in the bank?
CREATE Procedure TotalBalance
@ID INT
AS
BEGIN
     SELECT SUM(Balance)
     FROM Accounts
     WHERE CustomerID=@ID
END
exec TotalBalance 13
--5 Do I have any loans?
CREATE Procedure TotalLoans 
@ID INT
AS
BEGIN
     SELECT CASE 
                WHEN COUNT(*)>0 THEN 'Yes'
                ELSE 'No'
            END
     FROM Loans
     WHERE CustomerID=@ID
END
exec TotalLoans 13

--6 What is the status of my loan?
CREATE Procedure status_of_loan
@ID INT
AS
BEGIN
     SELECT Status
     FROM Loans
     WHERE CustomerID=@ID
END
exec status_of_loan 13
--7 Do I have a credit card?
CREATE Procedure credit_card
@ID INT
AS
BEGIN
     SELECT CASE 
                WHEN COUNT(*)>0 THEN 'Yes'
                ELSE 'No'
            END AS HasCreditCard
     FROM CreditCards 
     WHERE CustomerID=@ID
END
exec credit_card 13

--8 How much of my credit limit have I used and credit limit is still available?
CREATE Procedure Credit_limit
@ID INT
AS
BEGIN
     SELECT CurrentDebt AS UsedCredit,(CreditLimit - CurrentDebt) AS AvailableCredit
     FROM CreditCards 
     WHERE CustomerID=@ID
END
exec Credit_limit 13

