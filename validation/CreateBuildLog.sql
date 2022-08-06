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
    [DatabaseName] NVARCHAR(MAX) NULL,
    [Version] VARCHAR(14) NULL,
    [ClrVersion] NVARCHAR(4000) NULL,
    [ClrSigningKey] VARBINARY(8000) NULL,
    [InstalledOnSqlVersion] NUMERIC(10, 2) NULL,
    [SqlVersion] NUMERIC(10, 2) NULL,
    [SqlBuild] NUMERIC(10, 2) NULL,
    [SqlEdition] NVARCHAR(128) NULL,
    [HostPlatform] NVARCHAR(256) NULL
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

