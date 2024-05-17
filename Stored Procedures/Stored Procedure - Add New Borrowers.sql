-- drop procedure if exists sp_AddNewBorrower

-- go;

create procedure sp_AddNewBorrower (
  @FirstName varchar(100),
  @LastName varchar(100),
  @Email varchar(100),
  @DateOfBirth date,
  @MembershipDate date
)
as
begin
  declare @NewBorrowerID table (BorrowerID int); -- Declare table variable

  if EXISTS (select 1 from Borrowers where Email = @Email)
  begin
    select 'Error: Email address already exists.' as ErrorMessage;
    return;
  end;

  insert into Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
  output INSERTED.BorrowerID into @NewBorrowerID
  values (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

  select 'Success: New borrower added with ID ' + CAST((select BorrowerID from @NewBorrowerID) as varchar(10)) + '.' as SuccessMessage;
end;


exec sp_AddNewBorrower 
  @FirstName = 'Test2',
  @LastName = 'Test2',
  @Email = 'tes2t@example.com',
  @DateOfBirth = '1980-02-12',
  @MembershipDate = '2024-04-20';