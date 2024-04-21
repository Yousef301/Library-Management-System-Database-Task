select Top 1 Genre, count(Genre) as BorrowCount,
	DENSE_RANK() over (order by count(Genre) desc) as Ranks
from Books as b
inner join Loans as l on b.BookID = l.BookID
where month(l.DateBorrowed) = 2
group by Genre