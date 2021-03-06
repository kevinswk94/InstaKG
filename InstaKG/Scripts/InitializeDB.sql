USE [InstaKG]
GO

/****** Object:  Table [dbo].[Account]    Script Date: 14/6/2015 6:09:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account](
	[accountID] [int] IDENTITY(1,1) NOT NULL,
	[fName] [nvarchar](30) NOT NULL,
	[lName] [nvarchar](30) NOT NULL,
	[email] [nvarchar](30) NOT NULL,
	[birthdate] [date] NULL,
	[gender] [tinyint] NULL,
	[role] [tinyint] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[accountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


USE [InstaKG]
GO

/****** Object:  Table [dbo].[AccCreds]    Script Date: 14/6/2015 6:09:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AccCreds](
	[accCredID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](40) NOT NULL,
	[passwordSalt] [nvarchar](64) NOT NULL,
	[passwordHash] [nvarchar](256) NOT NULL,
	[accountID] [int] NOT NULL,
 CONSTRAINT [PK_AccCreds] PRIMARY KEY CLUSTERED 
(
	[accCredID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [InstaKG]
GO

/****** Object:  Table [dbo].[Image]    Script Date: 14/6/2015 6:10:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Image](
	[imageID] [int] IDENTITY(1,1) NOT NULL,
	[imageTitle] [nvarchar](100) NULL,
	[imageDescription] [nvarchar](1000) NULL,
	[imageData] [varbinary](max) NULL,
	[imageType] [nvarchar](20) NULL,
	[uploadDateTime] [datetime] NOT NULL,
	[accountID] [int] NOT NULL,
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[imageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [InstaKG]
GO

/****** Object:  Table [dbo].[Comment]    Script Date: 14/6/2015 6:10:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Comment](
	[commentID] [int] IDENTITY(1,1) NOT NULL,
	[commentDateTime] [datetime] NULL,
	[commentContent] [nvarchar](500) NULL,
	[commentAuthor] [nvarchar](40) NULL,
	[flag] [bit] NULL,
	[imageID] [int] NULL,
 CONSTRAINT [PK_Commentary] PRIMARY KEY CLUSTERED 
(
	[commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

