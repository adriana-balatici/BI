create table Tags(
id int primary key identity(1,1),
tag varchar(500)
)
DECLARE @MyCursor CURSOR;
DECLARE @tags NVARCHAR(1000);
BEGIN
    SET @MyCursor = CURSOR FOR
    select tags from dbo.USvideos    

    OPEN @MyCursor 
    FETCH NEXT FROM @MyCursor 
    INTO @tags

    WHILE @@FETCH_STATUS = 0
    BEGIN
      
    INSERT INTO Tags (tag)
	SELECT value as tag 
	FROM STRING_SPLIT(@tags, '|')  
	WHERE RTRIM(value) <> '';  
	


      FETCH NEXT FROM @MyCursor 
      INTO @tags
    END; 

    CLOSE @MyCursor ;
    DEALLOCATE @MyCursor;
END;


