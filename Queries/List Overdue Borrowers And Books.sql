drop procedure if exists sp_ListOverdueBorrowersAndBooks

go

create procedure sp_ListOverdueBorrowersAndBooks
as
begin
	create table #OverdueBorrowers(
		BorrowerID int primary key
	)

	insert into #OverdueBorrowers
	select bo.BorrowerID
	from Borrowers bo
	inner join Loans l on bo.BorrowerID = l.BorrowerID 
	where DateReturned is null and getdate() > DueDate

	if not exists (select 1 from #OverdueBorrowers)
	begin
		select 'No overdue borrowers found.'
		return
	end

	select l.BorrowerID,
		   l.BookID,
		   b.Title,
		   l.DateBorrowed,
		   l.DueDate
	from #OverdueBorrowers ob
    inner join Loans l on ob.BorrowerID = l.BorrowerID
    inner join Books b on l.BookID = b.BookID
    where l.DateReturned is null and getdate() > DueDate

  drop table #OverdueBorrowers;
end


exec sp_ListOverdueBorrowersAndBooks