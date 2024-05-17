with BorrowerLoans as (
	select b.BorrowerID, count(l.LoanID) as TotalLoans
	from Borrowers as b
	left join Loans as l on b.BorrowerID = l.BorrowerID
	where l.DateReturned is null
	group by b.BorrowerID
),
ActiveBorrowers as (
    select bl.BorrowerID
    from BorrowerLoans bl
    where bl.TotalLoans >= 2
)
select * from ActiveBorrowers
