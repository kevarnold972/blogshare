EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'The table primary key' 
	, @level0type=N'SCHEMA',@level0name=N'dbo'
	, @level1type=N'VIEW',@level1name=N'Store'
	, @level2type=N'Column',@level2name=N'StoreKey'