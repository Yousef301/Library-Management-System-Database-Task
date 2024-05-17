select 
  b.Title,
  b.Author,
  bo.FirstName,
  bo.LastName,
  l.DateBorrowed,
  DATEDIFF(DAY, l.DueDate, GETDATE()) as DaysOverdue
from Loans l
inner join Books b on l.BookID = b.BookID
inner join Borrowers bo on l.BorrowerID = bo.BorrowerID
where DATEDIFF(DAY, l.DueDate, GETDATE()) > 10
and l.DateReturned is null
order by DaysOverdue desc