USE [master]
GO
/****** Object:  Database [InstaKG]    Script Date: 28/5/2015 3:13:35 AM ******/
CREATE DATABASE [InstaKG]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InstaKG', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\InstaKG.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'InstaKG_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\InstaKG_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [InstaKG] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InstaKG].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InstaKG] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InstaKG] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InstaKG] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InstaKG] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InstaKG] SET ARITHABORT OFF 
GO
ALTER DATABASE [InstaKG] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InstaKG] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [InstaKG] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InstaKG] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InstaKG] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InstaKG] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InstaKG] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InstaKG] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InstaKG] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InstaKG] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InstaKG] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InstaKG] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InstaKG] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InstaKG] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InstaKG] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InstaKG] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InstaKG] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InstaKG] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InstaKG] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [InstaKG] SET  MULTI_USER 
GO
ALTER DATABASE [InstaKG] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InstaKG] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InstaKG] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InstaKG] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [InstaKG]
GO
/****** Object:  StoredProcedure [dbo].[spAuthenticateUser]    Script Date: 28/5/2015 3:13:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuthenticateUser] 
	-- Add the parameters for the stored procedure here
	@Username nvarchar(40),
	@Password nvarchar(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Declare @Count int
	
	SELECT @Count = COUNT(username) FROM accCreds WHERE [username] = @username AND [passwordHash] = @Password

	IF(@Count = 1)
	Begin
		SELECT 1 as ReturnCode
	End
	Else
	Begin
		SELECT -1 as ReturnCode
	End
END

GO
/****** Object:  StoredProcedure [dbo].[spRegisterUser]    Script Date: 28/5/2015 3:13:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Sum
-- Create date: 26-05-2015
-- Description:	Register a new user
-- =============================================
CREATE PROCEDURE [dbo].[spRegisterUser] 
	-- Add the parameters for the stored procedure here
	@Username nvarchar(40),
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@Email nvarchar(30),
	@PasswordSalt nvarchar(64),
	@PasswordHash nvarchar(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @UsernameCount int
	Declare @emailCount int
	Declare @ReturnCode int
	Declare @accID int

	Select @usernameCount = COUNT(Username) FROM AccCreds WHERE Username = @Username
	Select @emailCount = COUNT(Email) FROM Account WHERE Email = @Email
	IF @usernameCount > 0 OR @emailCount > 0
	Begin
		Set @ReturnCode = -1
	End
	Else
	Begin
		Set @ReturnCode = 1
		INSERT INTO Account(fName, lName, email, role) VALUES (@FirstName, @LastName, @Email, 0)
		SELECT @accID=accountID FROM Account WHERE (fName=@FirstName AND lName=@LastName AND email=@Email)
		INSERT INTO accCreds(username, passwordSalt, passwordHash, accountID) VALUES (@Username, @PasswordSalt, @PasswordHash, @accID)
	End
	SELECT @ReturnCode as ReturnValue
END

GO
/****** Object:  StoredProcedure [dbo].[spRetrieveSalt]    Script Date: 28/5/2015 3:13:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Kevin Sum
-- Create date: 26-05-2015
-- Description:	Retrieve Salt for account verification
-- =============================================
CREATE PROCEDURE [dbo].[spRetrieveSalt]
	-- Add the parameters for the stored procedure here
	@Username nvarchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @Count int
	Declare @salt nvarchar(10)
	
	SELECT @Count = COUNT(username) FROM accCreds WHERE [username] = @Username
	
	IF(@Count = 1)
	Begin
		SELECT @salt = passwordSalt FROM accCreds WHERE [username] = @Username
		SELECT @salt as ReturnCode
	End
	Else
	Begin
		SELECT '-1' as ReturnCode
	End
END

GO
/****** Object:  Table [dbo].[AccCreds]    Script Date: 28/5/2015 3:13:35 AM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 28/5/2015 3:13:35 AM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 28/5/2015 3:13:35 AM ******/
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
/****** Object:  Table [dbo].[Image]    Script Date: 28/5/2015 3:13:35 AM ******/
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
USE [master]
GO
ALTER DATABASE [InstaKG] SET  READ_WRITE 
GO
