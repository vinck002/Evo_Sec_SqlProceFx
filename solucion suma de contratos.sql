
--SELECT * FROM AGREEMENTS where id =5

declare @id int = 20
declare @current int = @id
create table #encontrados (idn int identity(1,1),Id int)
create table #temp (idn int identity(1,1), Id int)

insert into #encontrados values (@current)
declare @Idtemp int = 0
declare @cont int = 1
declare @cont2 int = 0
declare @cont3 int = 0



	while(@cont2 = 0)
	begin
		if ((select isnull(previewsID,0) from AGREEMENTS where id  = @current) > 0)
		begin
		 
		set @current= (select previewsID from AGREEMENTS where id = @current )
		 insert into #encontrados values(@current)
		end	else 
		begin 

			set @cont2=1
		end
	 end
set @current = (select top 1 id from #encontrados order by idn desc)

	 while (@cont3 = 0)
	 begin
		if((select count(Id) from AGREEMENTS where previewsID  = @current) > 0 or (select count(*) Id from #temp) > 0)
			begin
			
				insert into #temp select Id from AGREEMENTS where previewsID  = @current
				
				while((select count(*) from #temp) > 0 )
				begin
				set @Idtemp = (select top 1 Id from #temp order by Id)
				set @current = @Idtemp
					
				insert into #encontrados values(@Idtemp)
				if((select count(Id) from AGREEMENTS where previewsID  = @current) > 0)begin insert into #temp select Id from AGREEMENTS where previewsID  = @current end
	
				delete from #temp where Id = @Idtemp
				--
				end
			end
		else
			
			if((select isnull(Id,0) from AGREEMENTS where previewsID  = @current) > 0)
			begin
		
			set @current = (select  Id from AGREEMENTS where previewsID  = @current )
			Insert into #encontrados values(@current)
			end
			else begin set @cont3 = 1 end
	 end
	 
select distinct Id from #encontrados order by id

drop table #encontrados
drop table #temp
