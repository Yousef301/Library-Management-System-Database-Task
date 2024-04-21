select 
    Genre,
    count(Genre) as TotalBorrowed,
    floor((DATEDIFF(YEAR, bo.DateOfBirth, GETDATE()) - 1) / 10) as AgeGroup
from 
    Borrowers bo
INNER JOIN 
    Loans l on bo.BorrowerID = l.BorrowerID
INNER JOIN 
    Books b on b.BookID = l.BookID
group by 
    floor((DATEDIFF(YEAR, bo.DateOfBirth, GETDATE()) - 1) / 10), Genre
having 
    count(Genre) = (
        select top 1
            count(Genre)
        from 
            Borrowers inner_bo
        INNER JOIN 
            Loans inner_l on inner_bo.BorrowerID = inner_l.BorrowerID
        INNER JOIN 
            Books inner_b on inner_b.BookID = inner_l.BookID
        where 
            floor((DATEDIFF(YEAR, inner_bo.DateOfBirth, GETDATE()) - 1) / 10) = floor((DATEDIFF(YEAR, bo.DateOfBirth, GETDATE()) - 1) / 10)
        group by
            Genre
        order by 
            count(Genre) desc
    )
order by
    AgeGroup, TotalBorrowed
