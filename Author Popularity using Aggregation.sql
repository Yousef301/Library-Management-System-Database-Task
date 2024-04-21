select 
  Author,
  count(*) as BorrowingCount,
  DENSE_RANK() over (order by count(*) desc) as AuthorRank
from Loans l
inner join Books b on l.BookID = b.BookID
group by Author
order by BorrowingCount desc;