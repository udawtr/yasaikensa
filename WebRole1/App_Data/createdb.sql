SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[No] [int] NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_ce91fa21-c109-4ee4-8f35-d9306445ef51] PRIMARY KEY CLUSTERED 
(
	[No] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[edicode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[edicode](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[大分類コード] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[大分類名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[中分類コード] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[中分類名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[青果標準品名コード] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[栽培区分] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[品名表記漢字] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[品名表記カナ] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ベジフルコード] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[別称] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[備考] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[青果共通商品コード] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Source1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inspector]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Inspector](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[URL] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_b3bafed1-28d7-4043-b325-cc68b3d30172] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KEN_ALL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KEN_ALL](
	[自治体コード] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[旧郵便番号] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[郵便番号] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[都道府県名カナ] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[市区町村名かな] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[町域名かな] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[都道府県名] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[市区町村名] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[町域名] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[一町域が二以上の郵便番号で表される場合の表示] [smallint] NULL,
	[小字毎に番地が起番されている町域の表示] [smallint] NULL,
	[丁目を有する町域の場合の表示] [smallint] NULL,
	[一つの郵便番号で二以上の町域を表す場合の表示] [smallint] NULL,
	[更新の表示] [smallint] NULL,
	[変更理由] [smallint] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Source] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Place]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Place](
	[県] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[市] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[緯度] [real] NULL,
	[経度] [real] NULL,
	[距離] [real] NULL,
	[方位] [real] NULL,
 CONSTRAINT [PrimaryKey_32236592-b508-4f63-846b-07e7075f00e0] PRIMARY KEY CLUSTERED 
(
	[県] ASC,
	[市] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PrefCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PrefCode](
	[No] [int] NOT NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_a35054a6-695e-471f-8d57-16d2d8024e74] PRIMARY KEY CLUSTERED 
(
	[No] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingRestrictedCity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingRestrictedCity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingRestrictionCode] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CityName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PrimaryKey_67a5ad52-ef41-4dbf-88e4-59619514d286] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingRestrictedProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingRestrictedProduct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingRestrictionCode] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProductName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PrimaryKey_fcec84cd-54fd-4a90-93f2-e55ecd6fccd1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ShippingRestriction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ShippingRestriction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PrefName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CityFilterMode] [int] NOT NULL,
	[ProductFilterMode] [int] NOT NULL,
	[BeginDate] [date] NULL,
	[EndDate] [date] NULL,
	[Caption] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Comment] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_4bfa7d3b-660a-495b-8b2d-40bb93476a2f] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Temp_YasaiKensa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Temp_YasaiKensa](
	[No] [int] NOT NULL,
	[実施主体] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[産地都道府県] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[産地市町村] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[農場採取流通品] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[食品カテゴリ] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[品目] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[検査機関] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[採取日] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果判明日] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[厚生省発表日] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果ヨウ素131] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果セシウム134] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果セシウム137] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果セシウム] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[出展] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[登録日] [datetime] NULL,
	[更新日] [datetime] NULL,
	[採取日D] [date] NULL,
	[公表日D] [date] NULL,
	[判明日D] [date] NULL,
	[ヨウ素131D] [decimal](10, 2) NULL,
	[セシウム134D] [decimal](10, 2) NULL,
	[セシウム137D] [decimal](10, 2) NULL,
	[セシウムD] [decimal](10, 2) NULL,
	[野菜分類] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[野菜品名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_TempYasaiKensa] PRIMARY KEY CLUSTERED 
(
	[No] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YasaiKensa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[YasaiKensa](
	[No] [int] NOT NULL,
	[実施主体] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[産地都道府県] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[産地市町村] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[農場採取流通品] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[食品カテゴリ] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[品目] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[検査機関] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[採取日] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果判明日] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[厚生省発表日] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果ヨウ素131] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果セシウム134] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果セシウム137] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[結果セシウム] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[出展] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[登録日] [datetime] NULL,
	[更新日] [datetime] NULL,
	[採取日D] [date] NULL,
	[公表日D] [date] NULL,
	[判明日D] [date] NULL,
	[ヨウ素131D] [decimal](10, 2) NULL,
	[セシウム134D] [decimal](10, 2) NULL,
	[セシウム137D] [decimal](10, 2) NULL,
	[セシウムD] [decimal](10, 2) NULL,
	[野菜分類] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[野菜品名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_fc9ce538-b2be-4124-ad72-0e0a2d23850e] PRIMARY KEY CLUSTERED 
(
	[No] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YasaiName]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[YasaiName](
	[品目] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[補正] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[大分類名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[中分類名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[別名] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PrimaryKey_YasaiName] PRIMARY KEY CLUSTERED 
(
	[品目] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF)
)
END
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZipCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ZipCode](
	[全国地方公共団体コードID] [int] NULL,
	[旧郵便番号] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[郵便番号] [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[都道府県名かな] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[市区町村名かな] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[町域名かな] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[都道府県名] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[市区町村名] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[町域名] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[一町域が二以上の郵便番号で表される場合の表示] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[小字毎に番地が起番されている町域の表示] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[丁目を有する町域の場合の表示] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[一つの郵便番号で二以上の町域を表す場合の表示] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[更新の表示] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[変更理由] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ZipCode]') AND name = N'ci_azure_fixup_dbo_ZipCode')
CREATE CLUSTERED INDEX [ci_azure_fixup_dbo_ZipCode] ON [dbo].[ZipCode] 
(
	[全国地方公共団体コードID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF)
GO
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Map]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[Map]
AS
select 産地都道府県,産地市町村,count(*) as データ数, 経度, 緯度,距離,方位, max(ヨウ素131D) AS I131, max(ISNULL(セシウム134D,0)+ISNULL(セシウム137D,0)+ISNULL(セシウムD,0)) AS Cs  from YasaiKensa
left join Place on 産地都道府県=県 and 産地市町村=市
group by 産地都道府県,産地市町村,経度,緯度, 距離,方位

' 
GO

-- BCPArgs:5:[dbo].[Category] in "c:\SQLAzureMW\BCPData\dbo.Category.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:2007:[dbo].[edicode] in "c:\SQLAzureMW\BCPData\dbo.edicode.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:19:[dbo].[Inspector] in "c:\SQLAzureMW\BCPData\dbo.Inspector.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:122999:[dbo].[KEN_ALL] in "c:\SQLAzureMW\BCPData\dbo.KEN_ALL.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:1174:[dbo].[Place] in "c:\SQLAzureMW\BCPData\dbo.Place.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:47:[dbo].[PrefCode] in "c:\SQLAzureMW\BCPData\dbo.PrefCode.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:241:[dbo].[ShippingRestrictedCity] in "c:\SQLAzureMW\BCPData\dbo.ShippingRestrictedCity.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:102:[dbo].[ShippingRestrictedProduct] in "c:\SQLAzureMW\BCPData\dbo.ShippingRestrictedProduct.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:92:[dbo].[ShippingRestriction] in "c:\SQLAzureMW\BCPData\dbo.ShippingRestriction.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:130100:[dbo].[YasaiKensa] in "c:\SQLAzureMW\BCPData\dbo.YasaiKensa.dat" -E -n -b 10000 -a 16384
GO
-- BCPArgs:112:[dbo].[YasaiName] in "c:\SQLAzureMW\BCPData\dbo.YasaiName.dat" -E -n -b 10000 -a 16384
GO

