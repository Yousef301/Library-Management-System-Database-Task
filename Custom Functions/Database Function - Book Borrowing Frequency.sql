-- drop function if exists fn_BookBorrowingFrequency

-- go

create function fn_BookBorrowingFrequency (
  @BookID int
)
returns int
as
begin
  declare @BorrowingCount int;

  select @BorrowingCount = COUNT(*)
  from Loans
  where BookID = @BookID;

  return @BorrowingCount;
end


-- select BookID, dbo.fn_BookBorrowingFrequency(BookID)
-- from Books
-- where dbo.fn_BookBorrowingFrequency(BookID) >= 5