GO
CREATE PROCEDURE #CreateBuildLog
  @TableName NVARCHAR(MAX)
AS
BEGIN
  IF(OBJECT_ID(@TableName) IS NOT NULL)EXEC('DROP TABLE '+@TableName);
  DECLARE @cmd NVARCHAR(MAX) = 
  '
  CREATE TABLE '+@TableName+'
  (
    [id] [int] NOT NULL IDENTITY(1, 1) PRIMARY KEY CLUSTERED,
    [Success] [int] NULL,
    [Skipped] [int] NULL,
    [Failure] [int] NULL,
    [Error] [int] NULL,
    [TestCaseSet] NVARCHAR(MAX) NULL,
    [RunGroup] NVARCHAR(MAX) NULL,
    [DatabaseName] NVARCHAR(MAX) NULL
  );
  ';
  EXEC(@cmd);
  SET @cmd = 'GRANT INSERT ON '+@TableName+' TO PUBLIC;';
  IF(PARSENAME(@TableName,3) IS NOT NULL)
  BEGIN
    SET @cmd = PARSENAME(@TableName,3)+'.sys.sp_executesql N'''+@cmd+''',N''''';
  END;
  EXEC(@cmd);
END;
GO
EXEC #CreateBuildLog @TableName='$(BuildLogTableName)';

