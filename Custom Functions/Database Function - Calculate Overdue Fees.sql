-- drop function if exists fn_CalculateOverdueFees

-- go

create function fn_CalculateOverdueFees(@LoanID int)
returns int as 
begin
	declare @DaysDifference int;
	declare @StartDate date;
	declare @EndDate date;

	select @StartDate = DueDate, @EndDate = DateReturned
	from Loans
	where LoanID = @LoanID;

	set @EndDate = ISNULL(@EndDate, GETDATE());

	set @DaysDifference = DATEDIFF(day, @StartDate, @EndDate);

	if @DaysDifference > 0 
	begin
		if @DaysDifference > 30
		begin
			return 2 * @DaysDifference
		end
		return 1 * @DaysDifference
	end
	return 0
end


-- SELECT LoanID, dbo.fn_CalculateOverdueFees(LoanID) AS OverdueFees -- LoanID 36 has fee
-- FROM Loans;