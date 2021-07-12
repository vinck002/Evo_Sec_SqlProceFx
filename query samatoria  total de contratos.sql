declare @id int = 92585
declare @current int = @id
declare @source int = 0
create table #encontrados (Id int)

create table #temp (Id int)

insert into #encontrados values (@current)

declare @cont int = 1
declare @cont2 int = 0
declare @cont3 int = 0
declare @cont4 int = 0

	Loop1:
	while(@cont2 = 0)
	begin
		if ((select Count(preveusAgreement) from agreements where preveusAgreement = @current /*@current*/) > 1)
		begin 
			insert into #temp select AgreementID from agreements where preveusAgreement = @current /*@current 135554*/
			insert into #encontrados select AgreementID from agreements where preveusAgreement = @current /*@current*/ and AgreementID not in (select * from #encontrados)
			 declare @idtemp int
			 while (( select count(*) from #temp) > 0)
			 begin  
				 set @idtemp = (select top 1 Id from #temp order by Id asc )
				 set @current = @idtemp
				 --goto Loop1
				 insert into #encontrados values (@idtemp)
				 delete from #temp where Id = @idtemp
				 goto Loop1
		     end
		
		end
		else if((select isnull(preveusAgreement,0) from AGREEMENTS where AgreementID  = @current) > 0) 
		begin 
				set @current= (select preveusAgreement from AGREEMENTS where AgreementID = @current)
				insert into #encontrados values(@current /*@current*/) 
		 end
		 else
		 begin
		 set @cont2=1
		 end

end
	 --set @current = (select top 1 id from #encontrados order by id asc)
	select dbo.fx_retur_LstContratIDForward (143084)

	alter function fx_retur_LstContratIDForward (@current bigint ) returns varchar(100)
	begin
		declare @encontrados table(Id int)
		declare @result varchar(100)
		declare @cont3 int = 0
		
			 while (@cont3 = 0)
				begin
					--set @current = (select top 1 id from @encontrados order by id desc)
					if((select isnull(AgreementID,0) from AGREEMENTS where preveusAgreement  = @current) > 0)
					begin
					set @current = (select  AgreementID from AGREEMENTS where preveusAgreement  = @current )
					set @result = @result + ''+Convert(varchar(7),@current)+','
					Insert into @encontrados values(@current)
					end
					else begin set @cont3 = 1 end
				 end
				 --set @result = Convert(varchar(100),(select * from @encontrados))
		return @result;
	 end
select * from #encontrados order by id
--select * from #temp
drop table #temp
drop table #encontrados