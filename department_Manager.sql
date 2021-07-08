alter procedure evo1_sp_DepartmentManager
@Id int = 0,
@Description varchar(50),
@Active int,
@mod int = 0
as
begin
if (@mod = 0)
	begin
	if(@Id > 0)
	begin
	update Department set Description = @Description, Active = @Active where DepartmentID = @Id
	end	else
	begin
		Insert into Department values (@Description,@Active)
	end
	
	select @@IDENTITY as result
	end	
else
	begin
	IF (LTRIM(@Description) = '*')
		BEGIN
		SELECT * FROM Department
		END
		ELSE
		BEGIN
		SELECT * FROM Department WHERE Description LIKE '%'+LTRIM(@Description)+'%'				
		END
	end
end


