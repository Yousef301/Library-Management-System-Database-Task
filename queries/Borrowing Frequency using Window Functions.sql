with BorrowedBooks as (
  select 
    b.BorrowerID,
    count(*) as BorrowingCount
  from Loans l
  inner join Borrowers b on l.BorrowerID = b.BorrowerID
  group by b.BorrowerID
)
select
  b.FirstName,
  b.LastName,
  bb.BorrowingCount,
  DENSE_RANK() over (order by bb.BorrowingCount desc) as BorrowingRank
from Borrowers b
inner join BorrowedBooks bb on b.BorrowerID = bb.BorrowerID
order by BorrowingRank