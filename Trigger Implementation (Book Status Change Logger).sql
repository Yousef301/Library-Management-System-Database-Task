--create table BooksAuditLog(
--	AuditID int primary key identity(1, 1),
--	BookID int not null,
--	PreviousStatus varchar(100) check (PreviousStatus IN ('Available', 'Borrowed')),
--	CurrentStatus varchar(100) check (CurrentStatus IN ('Available', 'Borrowed')),
--	ChangeDate datetime not null,
--	foreign key (BookID) references Books(BookID)
--)

create trigger tr_BookStatusChange on Books
after update
as
begin
	declare @BookID int, @PreviousStatus varchar(100), @NewStatus varchar(100);
	
	select @BookID = inserted.BookID,
		   @PreviousStatus = deleted.CurrentStatus,
		   @NewStatus = inserted.CurrentStatus
	from inserted
	inner join deleted on deleted.BookID = inserted.BookID

	if @PreviousStatus <> @NewStatus
	begin
		insert into BooksAuditLog
        values (@BookID, @PreviousStatus, @NewStatus, getdate());
    end
end


-- Test

-- update Books
-- set CurrentStatus = 'Available'
-- where BookID = 1

-- select * from BooksAuditLog