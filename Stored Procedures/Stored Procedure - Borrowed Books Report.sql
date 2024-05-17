-- drop procedure if exists sp_BorrowedBooksReport

-- go

create procedure sp_BorrowedBooksReport (
	@StartDate date,
	@EndDate date
)
as
begin
	select bo.FirstName + ' ' + bo.LastName as FullName, b.Title, l.DateBorrowed from Loans l
	inner join Borrowers bo on bo.BorrowerID = l.BorrowerID
	inner join Books b on B.BookID = l.BookID
	where l.DateBorrowed between @StartDate and @EndDate
end


-- exec sp_BorrowedBooksReport @StartDate = '2024-03-01', @EndDate = '2024-04-01'