DECLARE @ProductVersion NVARCHAR(128) = CAST(SERVERPROPERTY('ProductVersion') AS NVARCHAR(128));
 DECLARE @FriendlyVersion NVARCHAR(128) = (SELECT FriendlyVersion 
 FROM 
 (  
   SELECT        @ProductVersion ProductVersion,        CASE          WHEN SSV.Major = '15' THEN '2019'          WHEN SSV.Major = '14' THEN '2017'          WHEN SSV.Major = '13' THEN '2016'          WHEN SSV.Major = '12' THEN '2014'          WHEN SSV.Major = '11' THEN '2012'          WHEN SSV.Major = '10' AND SSV.Minor IN ('50','5') THEN '2008R2'          WHEN SSV.Major = '10' AND SSV.Minor IN ('00','0') THEN '2008'         END FriendlyVersion
 FROM
 (
 SELECT REVERSE(PARSENAME(X.RP,1)) Major,        REVERSE(PARSENAME(X.RP,2)) Minor,         REVERSE(PARSENAME(X.RP,3)) Build,        REVERSE(PARSENAME(X.RP,4)) Revision   FROM (SELECT REVERSE(@ProductVersion)) AS X(RP) 
 )SSV
 )X
 ); 
 PRINT @FriendlyVersion;
