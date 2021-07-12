
--SELECT * FROM AGREEMENTS where id =5

declare @id int = 10
declare @current int = @id
create table #encontrados (Id int)

insert into #encontrados values (@current)

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

	 while (@cont3 = 0)
	 begin
		set @current = (select top 1 id from #encontrados order by id desc)
		if((select isnull(Id,0) from AGREEMENTS where previewsID  = @current) > 0)
		begin
		set @current = (select  Id from AGREEMENTS where previewsID  = @current )
		Insert into #encontrados values(@current)
		end
		else begin set @cont3 = 1 end
	 end
	 
select * from #encontrados order by id

drop table #encontrados