set nocount on


select 'Object' + Char(9) + 'Description' as [Line]
UNION ALL
SELECT 'Model.T.' + tbl.[name] + Char(9)  + CAST(ep.value as VARCHAR(500)) as [Line]
FROM sys.extended_properties ep
INNER JOIN sys.objects tbl
	ON tbl.object_id = ep.major_id
INNER JOIN sys.schemas sch
	ON sch.schema_id = tbl.schema_id
LEFT OUTER JOIN sys.columns col
	ON col.object_id = ep.major_id
		AND col.column_id = ep.minor_id
where sch.name = 'dbo'
and ep.[name] = 'Description' 
and col.[name] is null
UNION ALL
SELECT 'Model.T.' + tbl.[name] + '.C.' + col.[name] + Char(9)  + CAST(ep.value as VARCHAR(500)) as [Line]
FROM sys.extended_properties ep
INNER JOIN sys.objects tbl
	ON tbl.object_id = ep.major_id
INNER JOIN sys.schemas sch
	ON sch.schema_id = tbl.schema_id
LEFT OUTER JOIN sys.columns col
	ON col.object_id = ep.major_id
		AND col.column_id = ep.minor_id
where sch.name = 'dbo'
and ep.[name] = 'Description' 
and col.[name] is NOT null