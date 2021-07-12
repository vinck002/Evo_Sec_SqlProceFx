
----********************************************************07-08-2021****************************
Alter procedure Evo_sp_FillComboRole
as
begin
select Id, Descri  from Role where id in (select distinct GrpRoleId from Role )
end

--*************************************** BUSCAR ROLES*****************************************
alter PROCEDURE Evo_sp_RoleManager
@Id int,
@Code varchar(4),
@Description varchar(35),
@GrpRole int,
@mod int 
as
begin
if(@mod = 1)
begin
	if(ltrim(@Description) <> '*' or ltrim(@Code) <> '*' ) 
	begin
	 select * from Role where GrpRoleId in (case when @GrpRole > 0  then @GrpRole else (select Id from Role) end ) and  Descri like '%'+LTRIM(@Description)+'%'
	end
	else begin  select * from Role   end

end
else
begin
	if(@Id > 0)
	begin update Role set Code = @Code,Descri = @Description, GrpRoleId = @GrpRole , LS_Order = (select isnull(count (LS_Order),0) + 1 from Role where GrpRoleId = @GrpRole) WHERE Id = @Id  end
	else 
	begin Insert into Role values(@Code,@Description,1,@GrpRole,(select isnull(count (LS_Order),0) + 1 from Role where GrpRoleId = @GrpRole),null) 
	if(@GrpRole = 0) begin Update Role set GrpRoleId = SCOPE_IDENTITY() where Id = SCOPE_IDENTITY() end
	end
end

end

select * from Role where Code like '%'+ltrim('')+'%'
select * from Role where GrpRoleId in  (select Id from Role) and Descri like '%m%' and 
