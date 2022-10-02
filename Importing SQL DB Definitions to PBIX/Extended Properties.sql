SELECT sch.name [schema]
	,tbl.name [table]
	,col.name [column]
	,ep.[name] [Property]
	,ep.value [Value]
FROM sys.extended_properties ep
INNER JOIN sys.objects tbl
	ON tbl.object_id = ep.major_id
INNER JOIN sys.schemas sch
	ON sch.schema_id = tbl.schema_id
LEFT OUTER JOIN sys.columns col
	ON col.object_id = ep.major_id
		AND col.column_id = ep.minor_id
