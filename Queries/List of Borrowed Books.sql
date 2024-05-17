select b.* from Books as b
right join Loans as l on b.BookID = l.BookID
where l.BorrowerID = 2