USE [master]
GO
/****** Object:  Database [CLOTHING STORE]    Script Date: 12/10/2023 1:35:25 PM ******/
CREATE DATABASE [CLOTHING STORE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CLOTHING STORE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CLOTHING STORE.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CLOTHING STORE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CLOTHING STORE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CLOTHING STORE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CLOTHING STORE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CLOTHING STORE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET ARITHABORT OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CLOTHING STORE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CLOTHING STORE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CLOTHING STORE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CLOTHING STORE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET RECOVERY FULL 
GO
ALTER DATABASE [CLOTHING STORE] SET  MULTI_USER 
GO
ALTER DATABASE [CLOTHING STORE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CLOTHING STORE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CLOTHING STORE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CLOTHING STORE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CLOTHING STORE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CLOTHING STORE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CLOTHING STORE', N'ON'
GO
ALTER DATABASE [CLOTHING STORE] SET QUERY_STORE = ON
GO
ALTER DATABASE [CLOTHING STORE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CLOTHING STORE]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[BarCode] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[TotalAmount] [money] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC,
	[BarCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Collection] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Complaints]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Complaints](
	[ComplaintID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[Complaint] [ntext] NOT NULL,
	[Resolved] [char](1) NOT NULL,
 CONSTRAINT [PK_Complaints] PRIMARY KEY CLUSTERED 
(
	[ComplaintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[CustomerEmail] [nvarchar](50) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Phone] [nvarchar](24) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distributor]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distributor](
	[DistributorID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Name] [nvarchar](30) NULL,
	[Phone] [nvarchar](24) NULL,
 CONSTRAINT [PK_Distributor] PRIMARY KEY CLUSTERED 
(
	[DistributorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item_Inventory]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item_Inventory](
	[BarCode] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Size] [nvarchar](2) NOT NULL,
	[Color] [ntext] NOT NULL,
	[UnitsInStock] [int] NOT NULL,
	[ReorderLevel] [int] NULL,
	[Discontinued] [bit] NOT NULL,
	[WarehouseID] [int] NOT NULL,
 CONSTRAINT [PK_Item_Inventory] PRIMARY KEY CLUSTERED 
(
	[BarCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](max) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Collection] [ntext] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Material]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material](
	[MaterialID] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [nvarchar](15) NOT NULL,
	[SellerID] [int] NOT NULL,
	[meters_Purchased] [int] NOT NULL,
	[Price_permeter] [money] NOT NULL,
	[UnitsInStock_after] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
 CONSTRAINT [PK_Material] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order Details]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[OrderID] [int] NOT NULL,
	[BarCode] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[PaymentMethod] [ntext] NOT NULL,
 CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[BarCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NOT NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seller]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seller](
	[SellerID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](30) NOT NULL,
	[SellerContact] [nvarchar](30) NULL,
	[WarehouseLocation] [nvarchar](40) NULL,
 CONSTRAINT [PK_Seller] PRIMARY KEY CLUSTERED 
(
	[SellerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 12/10/2023 1:35:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[WarehouseID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseLocation] [nvarchar](40) NOT NULL,
	[contact] [nvarchar](24) NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (1, 1, 1, 49.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (2, 9, 2, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (3, 13, 1, 49.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (4, 5, 1, 49.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (5, 16, 2, 54.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (6, 6, 3, 49.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (7, 12, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (8, 1, 1, 49.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (9, 11, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (10, 16, 2, 54.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (11, 12, 2, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (12, 45, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (13, 45, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (14, 1, 2, 99.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (15, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (16, 39, 1, 79.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (17, 39, 1, 79.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (18, 27, 2, 99.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (19, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (20, 33, 2, 79.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (21, 45, 2, 59.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (22, 39, 1, 79.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (23, 14, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (24, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (25, 39, 3, 239.9700)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (26, 39, 2, 159.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (27, 39, 1, 79.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (28, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (29, 14, 2, 259.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (30, 14, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (31, 45, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (32, 45, 2, 59.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (33, 14, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (34, 57, 2, 259.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (35, 14, 2, 259.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (36, 7, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (37, 14, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (38, 8, 2, 159.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (39, 16, 1, 54.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (40, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (41, 33, 2, 79.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (42, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (43, 57, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (44, 69, 1, 19.0000)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (45, 9, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (46, 33, 2, 79.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (47, 33, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (48, 20, 1, 69.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (49, 39, 1, 79.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (50, 27, 2, 99.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (51, 45, 1, 29.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (52, 14, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (54, 33, 3, 119.9700)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (55, 27, 2, 99.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (56, 16, 1, 54.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (57, 14, 2, 259.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (58, 69, 2, 38.0000)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (59, 9, 2, 59.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (60, 7, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (61, 27, 1, 49.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (62, 33, 2, 79.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (63, 27, 2, 99.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (64, 14, 1, 129.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (65, 14, 2, 259.9800)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (66, 7, 1, 39.9900)
GO
INSERT [dbo].[Cart] ([CartID], [BarCode], [Quantity], [TotalAmount]) VALUES (67, 14, 1, 129.9900)
GO
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (1, N'Co-ord sets', N'Summer')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (2, N'Long Dresses', N'Summer')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (3, N'Pants and Jeans', N'Year-Round')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (4, N'Skirts', N'Year-Round')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (5, N'TankTops', N'Summer')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (6, N'Shirts', N'Summer')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (7, N'Formal Wear', N'Summer')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (8, N'JumpSuit', N'Summer')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (9, N'Scarfs', N'Year-Round')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (10, N'Coats and Blazers', N'Winter')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (11, N'Puffers and Jackets', N'Winter')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (12, N'Sweaters and Cardigans', N'Winter')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (13, N'Hoodie and Sweatshirts', N'Winter')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (14, N'Long Dresses', N'Winter')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (15, N'Formal Wear', N'Winter')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (16, N'Bottoms', N'Year-Round')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Collection]) VALUES (17, N'Co-ord sets', N'Winter')
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Complaints] ON 
GO
INSERT [dbo].[Complaints] ([ComplaintID], [OrderID], [Complaint], [Resolved]) VALUES (1, 3, N'wrong item delivered', N'y')
GO
INSERT [dbo].[Complaints] ([ComplaintID], [OrderID], [Complaint], [Resolved]) VALUES (2, 5, N'delayed shipment', N'n')
GO
INSERT [dbo].[Complaints] ([ComplaintID], [OrderID], [Complaint], [Resolved]) VALUES (3, 8, N'Missing parts in the order', N'n')
GO
INSERT [dbo].[Complaints] ([ComplaintID], [OrderID], [Complaint], [Resolved]) VALUES (4, 12, N'Item doesnt match the description', N'y')
GO
INSERT [dbo].[Complaints] ([ComplaintID], [OrderID], [Complaint], [Resolved]) VALUES (5, 1, N'defected item delivered', N'n')
GO
INSERT [dbo].[Complaints] ([ComplaintID], [OrderID], [Complaint], [Resolved]) VALUES (6, 24, N'faulty', N'y')
GO
SET IDENTITY_INSERT [dbo].[Complaints] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (1, N'Muhammad Ahmed', N'muhammad.ahmed@example.com', N'123 Main Street', N'Karachi', N'Sindh', N'74500', N'321-123-4567')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (2, N'Fatima Khan', N'fatima.khan@example.com', N'456 Park Avenue', N'Lahore', N'Punjab', N'54000', N'456-789-0123')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (3, N'Asad Ali', N'asad.ali@example.com', N'789 Liberty Road', N'Islamabad', N'Punjab', N'44000', N'789-012-3456')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (4, N'Saba Malik', N'saba.malik@example.com', N'234 Green Lane', N'Rawalpindi', N'Punjab', N'46000', N'234-567-8901')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (5, N'Bilal Ahmed', N'bilal.ahmed@example.com', N'567 Blue Street', N'Faisalabad', N'Punjab', N'38000', N'567-890-1234')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (6, N'Zainab Raza', N'zainab.raza@example.com', N'890 Red Road', N'Multan', N'Punjab', N'60000', N'890-123-4567')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (7, N'Sohaib Khan', N'sohaib.khan@example.com', N'012 Yellow Lane', N'Peshawar', N'KPK', N'25000', N'012-345-6789')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (8, N'Ayesha Ali', N'ayesha.ali@example.com', N'678 Orange Street', N'Quetta', N'Balochistan', N'87000', N'678-901-2345')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (9, N'Usman Ahmed', N'usman.ahmed@example.com', N'901 Violet Road', N'Gujranwala', N'Punjab', N'52000', N'901-234-5678')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (10, N'Sadia Malik', N'sadia.malik@example.com', N'345 Brown Lane', N'Sialkot', N'Punjab', N'51300', N'345-678-9012')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (12, N'abc', N'abc@gmail.com', N'habib university', N'karachi', N'sindh', N'1234', N'098-765-432')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (13, N'naaseh', N'naasehsajid@gmail.com', N'abc', N'karachi', N'sindh', N'74600', N'334')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (14, N'abcdf', N'abcdf', N'abcdf', N'abcdf', N'abcdf', N'123', N'123-666-777')
GO
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerEmail], [Address], [City], [Region], [PostalCode], [Phone]) VALUES (15, N'abc', N'abc', N'abc', N'Karachi', N'Sindh', N'74600', N'334')
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Distributor] ON 
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (1, N'Pak Traders', N'Ali Khan', N'321-123-4567')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (2, N'Pak Traders', N'Fatima Ahmed', N'456-789-0123')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (3, N'EN Distributors', N'Amir Malik', N'789-012-3456')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (4, N'Pak Traders', N'Sadia Khan', N'234-567-8901')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (5, N'MP Suppliers', N'Bilal Ahmed', N'567-890-1234')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (6, N'EN Distributors', N'Ayesha Ali', N'890-123-4567')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (7, N'MP Suppliers', N'Asim Khan', N'012-345-6789')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (8, N'MP Suppliers', N'Sana Ahmad', N'678-901-2345')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (9, N'EN Distributors', N'Ahmed Raza', N'901-234-5678')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (10, N'EN Distributors', N'Zainab Malik', N'123-456-7890')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (11, N'Pak Traders', N'Qasim Khan', N'012-345-678')
GO
INSERT [dbo].[Distributor] ([DistributorID], [CompanyName], [Name], [Phone]) VALUES (12, N'ABC', N'XYZ', N'456-987-000')
GO
SET IDENTITY_INSERT [dbo].[Distributor] OFF
GO
SET IDENTITY_INSERT [dbo].[Item_Inventory] ON 
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (1, 1, N'S', N'Blue', 50, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (2, 1, N'S', N'Red', 50, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (3, 1, N'S', N'Blue', 50, 10, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (4, 1, N'S', N'Red', 50, 10, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (5, 1, N'S', N'Blue', 50, 10, 0, 4)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (6, 1, N'S', N'Red', 50, 10, 0, 4)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (7, 2, N'M', N'Green', 29, 8, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (8, 3, N'L', N'Black', 20, 5, 0, 3)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (9, 4, N'L', N'Blue', 40, 15, 0, 5)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (10, 4, N'L', N'Red', 48, 15, 0, 5)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (11, 4, N'M', N'Red', 40, 15, 0, 5)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (12, 4, N'M', N'Red', 40, 15, 0, 5)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (13, 5, N'S', N'Navy Blue', 25, 12, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (14, 6, N'M', N'White', 35, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (15, 6, N'M', N'White', 30, 10, 0, 3)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (16, 7, N'L', N'Purple', 15, 7, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (17, 8, N'L', N'Orange', 45, 20, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (18, 8, N'S', N'Orange', 45, 20, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (19, 9, N'S', N'Pink', 10, 5, 0, 3)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (20, 10, N'M', N'Brown', 30, 15, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (21, 1, N'M', N'Red', 60, 10, 0, 2)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (22, 11, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (23, 11, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (24, 11, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (25, 11, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (26, 11, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (27, 11, N'L', N'Blue', 18, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (28, 12, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (29, 12, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (30, 12, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (31, 12, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (32, 12, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (33, 12, N'L', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (34, 13, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (35, 13, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (36, 13, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (37, 13, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (38, 13, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (39, 13, N'L', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (40, 14, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (41, 14, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (42, 14, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (43, 14, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (44, 14, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (45, 14, N'L', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (46, 15, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (47, 15, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (48, 15, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (49, 15, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (50, 15, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (51, 15, N'L', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (52, 16, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (53, 16, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (54, 16, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (55, 16, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (56, 16, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (57, 16, N'L', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (58, 17, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (59, 17, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (60, 17, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (61, 17, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (62, 17, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (63, 17, N'L', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (64, 18, N'S', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (65, 18, N'M', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (66, 18, N'S', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (67, 18, N'M', N'Blue', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (68, 18, N'L', N'Red', 20, 10, 0, 1)
GO
INSERT [dbo].[Item_Inventory] ([BarCode], [ItemID], [Size], [Color], [UnitsInStock], [ReorderLevel], [Discontinued], [WarehouseID]) VALUES (69, 18, N'L', N'Blue', 20, 10, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[Item_Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[Items] ON 
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (1, N'Ribbed knit co-ord', 17, N'Winter', 49.9900, N'Loose-fit ribbed knit sweater with turtle neck and full sleeves. Side slits.')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (2, N'Solid cotton co-ord', 1, N'Summer', 39.9900, N'Solid cotton 2-piece.')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (3, N'A-Line Dress', 2, N'Summer', 79.9900, N'A beautiful floral print summer dress')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (4, N'embroidered denim jeans', 3, N'Year-Round', 29.9900, N'fitted jeans with embroidered pockets')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (5, N'Beaded Plaid skirt', 4, N'Year-Round', 44.9900, N'A stylish plaid skirt')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (6, N'V-Tanktop', 5, N'Summer', 129.9900, N'solid plaided tanktop')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (7, N'WestCoast Shirt', 6, N'Summer', 54.9900, N'solid plain shirt')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (8, N'Off-shoulder sequin gown', 7, N'Summer', 59.9900, N'An elegant gown for special occasions')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (9, N'Lucy Jumpsuit', 8, N'Summer', 89.9900, N'great for evening meetups')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (10, N'Abstract floral scarf', 9, N'Year-Round', 69.9900, N'organza detailings')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (11, N'Long fur coat', 10, N'Winter', 49.9900, N'A beautiful warm coat')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (12, N'short fur jacket', 11, N'Winter', 39.9900, N'Warm woolen jacket for the winter chill')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (13, N'knit tartan cardigan', 12, N'Winter', 79.9900, N'Warm stylish cardigan')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (14, N'cropped sweatshirt', 13, N'Winter', 29.9900, N'Cozy knit sweater for cold days')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (15, N'ribbed dress', 14, N'Winter', 44.9900, N'Comfortable and warm dress for a casual evening')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (16, N'velvet gown', 15, N'Winter', 129.9900, N'An elegant gown for special occasions')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (17, N'pull-on trousers', 16, N'Year-Round', 54.9900, N'Cozy and comfortable trousers')
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [CategoryID], [Collection], [UnitPrice], [Description]) VALUES (18, N'baggy jeans', 3, N'Year-Round', 19.0000, N'abc')
GO
SET IDENTITY_INSERT [dbo].[Items] OFF
GO
SET IDENTITY_INSERT [dbo].[Material] ON 
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (1, N'Cotton', 3, 10, 50.0000, 5, 1)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (2, N'Cotton', 3, 10, 50.0000, 60, 2)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (3, N'Cotton', 3, 10, 50.0000, 50, 3)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (4, N'Cotton', 3, 20, 50.0000, 90, 4)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (5, N'Cotton', 3, 30, 50.0000, 100, 5)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (6, N'Silk', 4, 25, 25.0000, 10, 5)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (7, N'Silk', 4, 25, 25.0000, 100, 3)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (8, N'Silk', 4, 25, 25.0000, 50, 2)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (9, N'Denim', 5, 30, 70.0000, 50, 1)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (10, N'Denim', 5, 50, 70.0000, 100, 3)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (11, N'Denim', 5, 60, 70.0000, 50, 4)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (12, N'Linen', 2, 25, 25.0000, 100, 5)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (13, N'Linen', 2, 25, 25.0000, 50, 2)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (14, N'Linen', 2, 30, 70.0000, 50, 1)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (15, N'Linen', 2, 50, 70.0000, 100, 3)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (16, N'Linen', 2, 60, 70.0000, 50, 4)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (17, N'Wool', 6, 50, 70.0000, 100, 5)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (18, N'Wool', 6, 60, 70.0000, 50, 2)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (19, N'Velvet', 7, 60, 70.0000, 50, 4)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (20, N'Velvet', 7, 50, 70.0000, 100, 5)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (21, N'Rayon', 8, 60, 70.0000, 50, 2)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (22, N'Khaddi', 1, 10, 50.0000, 70, 1)
GO
INSERT [dbo].[Material] ([MaterialID], [MaterialName], [SellerID], [meters_Purchased], [Price_permeter], [UnitsInStock_after], [WarehouseID]) VALUES (23, N'Khaddi', 1, 10, 50.0000, 100, 2)
GO
SET IDENTITY_INSERT [dbo].[Material] OFF
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (1, 1, 49.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (1, 2, 49.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (2, 1, 49.9900, 2, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (3, 3, 49.9900, 1, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (4, 2, 49.9900, 3, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (5, 7, 39.9900, 1, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (6, 6, 49.9900, 2, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (7, 1, 49.9900, 1, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (7, 5, 49.9900, 3, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (8, 10, 29.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (8, 11, 29.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (9, 15, 129.9900, 1, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (10, 17, 59.9900, 2, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (11, 13, 44.9900, 1, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (12, 20, 69.9900, 4, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (13, 19, 89.9900, 1, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (14, 19, 89.9900, 2, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (15, 11, 29.9900, 1, N'online payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (16, 6, 49.9900, 2, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (17, 9, 29.9900, 1, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (18, 10, 29.9900, 2, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (19, 2, 49.9900, 1, N'card payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (20, 3, 49.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (20, 4, 49.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (20, 5, 49.9900, 1, N'cash on delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (21, 14, 259.9800, 2, N'Online Payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (21, 16, 54.9900, 1, N'Online Payment')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (22, 9, 59.9800, 2, N'Cash on Delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (23, 7, 39.9900, 1, N'Cash on Delivery')
GO
INSERT [dbo].[Order Details] ([OrderID], [BarCode], [UnitPrice], [Quantity], [PaymentMethod]) VALUES (24, 27, 99.9800, 2, N'Cash on Delivery')
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (1, 3, CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(N'2023-01-10T00:00:00.000' AS DateTime), 1, N'789 Liberty Road', N'Islamabad', N'Punjab', N'44000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (2, 7, CAST(N'2023-02-12T00:00:00.000' AS DateTime), NULL, 2, N'012 Yellow Lane', N'Peshawar', N'KPK', N'25000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (3, 2, CAST(N'2023-03-20T00:00:00.000' AS DateTime), CAST(N'2023-03-25T00:00:00.000' AS DateTime), 5, N'456 Park Avenue', N'Lahore', N'Punjab', N'54000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (4, 5, CAST(N'2023-04-08T00:00:00.000' AS DateTime), CAST(N'2023-04-15T00:00:00.000' AS DateTime), 6, N'567 Blue Street', N'Faisalabad', N'Punjab', N'38000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (5, 9, CAST(N'2023-05-15T00:00:00.000' AS DateTime), NULL, 6, N'901 Violet Road', N'Gujranwala', N'Punjab', N'52000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (6, 1, CAST(N'2023-06-02T00:00:00.000' AS DateTime), CAST(N'2023-06-08T00:00:00.000' AS DateTime), 3, N'123 Main Street', N'Karachi', N'Sindh', N'74500')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (7, 6, CAST(N'2023-07-10T00:00:00.000' AS DateTime), CAST(N'2023-07-15T00:00:00.000' AS DateTime), 4, N'890 Red Road', N'Multan', N'Punjab', N'60000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (8, 10, CAST(N'2023-08-18T00:00:00.000' AS DateTime), CAST(N'2023-08-24T00:00:00.000' AS DateTime), 4, N'345 Brown Lane', N'Sialkot', N'Punjab', N'51300')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (9, 4, CAST(N'2023-09-25T00:00:00.000' AS DateTime), CAST(N'2023-09-30T00:00:00.000' AS DateTime), 8, N'234 Green Lane', N'Rawalpindi', N'Punjab', N'46000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (10, 8, CAST(N'2023-10-12T00:00:00.000' AS DateTime), CAST(N'2023-10-18T00:00:00.000' AS DateTime), 8, N'678 Orange Street', N'Quetta', N'Balochistan', N'87000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (11, 1, CAST(N'2023-11-15T00:00:00.000' AS DateTime), NULL, 8, N'123 Main Street', N'Karachi', N'Sindh', N'74500')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (12, 5, CAST(N'2023-12-02T00:00:00.000' AS DateTime), CAST(N'2023-12-08T00:00:00.000' AS DateTime), 9, N'567 Blue Street', N'Faisalabad', N'Punjab', N'38000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (13, 9, CAST(N'2024-01-10T00:00:00.000' AS DateTime), CAST(N'2024-01-15T00:00:00.000' AS DateTime), 9, N'901 Violet Road', N'Gujranwala', N'Punjab', N'52000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (14, 3, CAST(N'2024-02-18T00:00:00.000' AS DateTime), NULL, 10, N'789 Liberty Road', N'Islamabad', N'Punjab', N'44000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (15, 7, CAST(N'2024-03-25T00:00:00.000' AS DateTime), CAST(N'2024-03-31T00:00:00.000' AS DateTime), 10, N'012 Yellow Lane', N'Peshawar', N'KPK', N'25000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (16, 2, CAST(N'2024-04-08T00:00:00.000' AS DateTime), CAST(N'2024-04-15T00:00:00.000' AS DateTime), 3, N'456 Park Avenue', N'Lahore', N'Punjab', N'54000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (17, 6, CAST(N'2024-05-15T00:00:00.000' AS DateTime), CAST(N'2024-05-20T00:00:00.000' AS DateTime), 4, N'890 Red Road', N'Multan', N'Punjab', N'60000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (18, 10, CAST(N'2024-06-02T00:00:00.000' AS DateTime), CAST(N'2024-06-08T00:00:00.000' AS DateTime), 7, N'345 Brown Lane', N'Sialkot', N'Punjab', N'51300')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (19, 4, CAST(N'2024-07-10T00:00:00.000' AS DateTime), CAST(N'2024-07-15T00:00:00.000' AS DateTime), 7, N'234 Green Lane', N'Rawalpindi', N'Punjab', N'46000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (20, 8, CAST(N'2024-08-18T00:00:00.000' AS DateTime), CAST(N'2024-08-24T00:00:00.000' AS DateTime), 7, N'678 Orange Street', N'Quetta', N'Balochistan', N'87000')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (21, 12, CAST(N'2023-12-07T09:46:38.170' AS DateTime), NULL, 5, N'habib university', N'karachi', N'sindh', N'1234')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (22, 13, CAST(N'2023-12-07T11:04:17.823' AS DateTime), NULL, 3, N'abc', N'karachi', N'sindh', N'74600')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (23, 14, CAST(N'2023-12-07T11:12:00.350' AS DateTime), NULL, 7, N'abcdf', N'abcdf', N'abcdf', N'123')
GO
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [ShippedDate], [ShipVia], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode]) VALUES (24, 15, CAST(N'2023-12-07T11:58:40.080' AS DateTime), NULL, 11, N'abc', N'Karachi', N'Sindh', N'74600')
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Seller] ON 
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (1, N'Khaddi', N'0335-3788550', N'Saddar')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (2, N'Linen seller', N'123-456-7890', N'Karachi')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (3, N'Cotton seller', N'987-654-3210', N'Karachi')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (4, N'Silk seller', N'111-222-3333', N'Islamabad')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (5, N'Denim seller', N'444-555-6666', N'Rawalpindi')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (6, N'Wool seller', N'777-888-9999', N'Faisalabad')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (7, N'Velvet seller', N'555-444-3333', N'Islamabad')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (8, N'Rayon seller', N'999-888-7777', N'Quetta')
GO
INSERT [dbo].[Seller] ([SellerID], [CompanyName], [SellerContact], [WarehouseLocation]) VALUES (9, N'abc seller', N'888-000-1111', N'Rawalpindi')
GO
SET IDENTITY_INSERT [dbo].[Seller] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 
GO
INSERT [dbo].[Warehouse] ([WarehouseID], [WarehouseLocation], [contact]) VALUES (1, N'456 Oak Avenue, Lahore', N'+92 301 2345678')
GO
INSERT [dbo].[Warehouse] ([WarehouseID], [WarehouseLocation], [contact]) VALUES (2, N'123 Main Street, Karachi', N'+92 300 1234567')
GO
INSERT [dbo].[Warehouse] ([WarehouseID], [WarehouseLocation], [contact]) VALUES (3, N'789 Pine Road, Islamabad', N'+92 302 3456789')
GO
INSERT [dbo].[Warehouse] ([WarehouseID], [WarehouseLocation], [contact]) VALUES (4, N'321 Maple Lane, Faisalabad', N'+92 303 4567890')
GO
INSERT [dbo].[Warehouse] ([WarehouseID], [WarehouseLocation], [contact]) VALUES (5, N'555 Elm Street, Rawalpindi', N'+92 304 5678901')
GO
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
GO
/****** Object:  Index [BarCode]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [BarCode] ON [dbo].[Cart]
(
	[BarCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CategoryName]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CategoryName] ON [dbo].[Categories]
(
	[CategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [OrderID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [OrderID] ON [dbo].[Complaints]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Resolved]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [Resolved] ON [dbo].[Complaints]
(
	[Resolved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [City]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [City] ON [dbo].[Customers]
(
	[City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CustomerName]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CustomerName] ON [dbo].[Customers]
(
	[CustomerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PostalCode]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [PostalCode] ON [dbo].[Customers]
(
	[PostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Region]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [Region] ON [dbo].[Customers]
(
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CompanyName]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CompanyName] ON [dbo].[Distributor]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ItemID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [ItemID] ON [dbo].[Item_Inventory]
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [WarehouseID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [WarehouseID] ON [dbo].[Item_Inventory]
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CategoryID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CategoryID] ON [dbo].[Items]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UnitPrice]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [UnitPrice] ON [dbo].[Items]
(
	[UnitPrice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SellerID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [SellerID] ON [dbo].[Material]
(
	[SellerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [BarCode]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [BarCode] ON [dbo].[Order Details]
(
	[BarCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [OrderID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [OrderID] ON [dbo].[Order Details]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CustomerID]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CustomerID] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [CustomersOrders]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CustomersOrders] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [OrderDate]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [OrderDate] ON [dbo].[Orders]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ShippedDate]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [ShippedDate] ON [dbo].[Orders]
(
	[ShippedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ShipPostalCode]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [ShipPostalCode] ON [dbo].[Orders]
(
	[ShipPostalCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ShipVia]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [ShipVia] ON [dbo].[Orders]
(
	[ShipVia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CompanyName]    Script Date: 12/10/2023 1:35:26 PM ******/
CREATE NONCLUSTERED INDEX [CompanyName] ON [dbo].[Seller]
(
	[CompanyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Item_Inventory] FOREIGN KEY([BarCode])
REFERENCES [dbo].[Item_Inventory] ([BarCode])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Item_Inventory]
GO
ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_orderid] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_orderid]
GO
ALTER TABLE [dbo].[Item_Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Item_Inventory_Items] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ItemID])
GO
ALTER TABLE [dbo].[Item_Inventory] CHECK CONSTRAINT [FK_Item_Inventory_Items]
GO
ALTER TABLE [dbo].[Item_Inventory]  WITH CHECK ADD  CONSTRAINT [FK_Item_Inventory_Warehouse] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouse] ([WarehouseID])
GO
ALTER TABLE [dbo].[Item_Inventory] CHECK CONSTRAINT [FK_Item_Inventory_Warehouse]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Categories]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD FOREIGN KEY([SellerID])
REFERENCES [dbo].[Seller] ([SellerID])
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouse] ([WarehouseID])
GO
ALTER TABLE [dbo].[Order Details]  WITH CHECK ADD  CONSTRAINT [[FK_Order Details_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [[FK_Order Details_Order]
GO
ALTER TABLE [dbo].[Order Details]  WITH CHECK ADD  CONSTRAINT [FK_Order Details_Item_Inventory] FOREIGN KEY([BarCode])
REFERENCES [dbo].[Item_Inventory] ([BarCode])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order Details_Item_Inventory]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_customer]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Distributor] FOREIGN KEY([ShipVia])
REFERENCES [dbo].[Distributor] ([DistributorID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Distributor]
GO
USE [master]
GO
ALTER DATABASE [CLOTHING STORE] SET  READ_WRITE 
GO
