--select 'EXEC sys.sp_addextendedproperty @name=N''Description'', @value=N''{add desc}'' , @level0type=N''SCHEMA'', @level0name=N''' + TABLE_SCHEMA
--	  + ''', @level1type=N''VIEW'',@level1name=N''' + TABLE_NAME
--	  + ''', @level2type=N''Column'',@level2name=N''' + COLUMN_NAME
--	  + ''''
--from INFORMATION_SCHEMA.COLUMNS
--where TABLE_SCHEMA = 'dbo'
--and TABLE_NAME <> 'systranschemas'

select 'EXEC sys.sp_addextendedproperty @name=N''Description'', @value=N''The ' + Column_Name + ' for a ' + TABLE_NAME + ''' , @level0type=N''SCHEMA'', @level0name=N''' + TABLE_SCHEMA
	  + ''', @level1type=N''VIEW'',@level1name=N''' + TABLE_NAME
	  + ''', @level2type=N''Column'',@level2name=N''' + COLUMN_NAME
	  + ''''
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'dbo'
and TABLE_NAME <> 'systranschemas'

select 'EXEC sys.sp_addextendedproperty @name=N''Description'', @value=N''The information for a ' + TABLE_NAME + ''' , @level0type=N''SCHEMA'', @level0name=N''' + TABLE_SCHEMA
	  + ''', @level1type=N''VIEW'',@level1name=N''' + TABLE_NAME
	  + ''''
from INFORMATION_SCHEMA.VIEWS v
where v.TABLE_SCHEMA = 'dbo'
and TABLE_NAME <> 'systranschemas'