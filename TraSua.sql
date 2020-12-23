CREATE DATABASE MilkTeaShop 
GO

USE MilkTeaShop
GO
---------------------------
--MilkTea
-- Menu 
-- TableOfGuest
--Bill
--DetailBill
--Acount
--Ingredient 
----------------------------


CREATE TABLE OrderCard
(
	CardId INT PRIMARY KEY,
	CardName nvarchar(50) not null,
	CardStatus INT NOT NULL DEFAULT 0 --0 Trống || 1 Có người 
)
GO


CREATE TABLE Category
(
	CategoryId varchar(10) PRIMARY KEY not null,
	CategoryName NVARCHAR (100) NOT NULL
)
GO

CREATE TABLE Bill
(
	BillId varchar(10) PRIMARY KEY,
	CardId  INT constraint FK_TK_Card FOREIGN KEY (CardId ) REFERENCES OrderCard (CardId) NOT NULL,
	BillDate datetime DEFAULT GETDATE(),
	--BillStatus INT NOT NULL DEFAULT 0, --1:đã thanh toán ,--0:chưa thanh toán,
	TotalPrice int DEFAULT 0,
)
GO


CREATE TABLE Drink
(
	DrinkId varchar(10) PRIMARY KEY not null,
	CategoryId  varchar(10) constraint FK_TK_Menu FOREIGN KEY (CategoryId) REFERENCES  Category(CategoryId) not null,
	DrinkName NVARCHAR(50) NOT NULL DEFAULT N'Trà sữa truyền thống',
	Price int NOT NULL DEFAULT 0
)
GO

CREATE TABLE BillDetail
(
	BillDetailId varchar(20) PRIMARY KEY,
	BillId  varchar(10) constraint FK_TK_Bill FOREIGN KEY (BillId) REFERENCES Bill (BillId) not null,
	DrinkId varchar(10) constraint FK_TK_Drink FOREIGN KEY (DrinkId) REFERENCES Drink (DrinkId) not null,
	Number INT NOT NULL DEFAULT 0,
	Size NVARCHAR(10) NOT NULL,
	Topping NVARCHAR(250) NOT NULL,
	Ice VARCHAR(10) NOT NULL,
	SUGAR VARCHAR(10) NOT NULL,
	BillDetailPrice int not null
)
GO


CREATE TABLE Ingredient
(
	IngredientID varchar(10) PRIMARY KEY not null,
	IngredientName NVARCHAR(100) NOT NULL,
	IngredientPrice bigint not null, 
	ProducedDate DATE NOT NULL DEFAULT GETDATE(),
	ExpiryDate DATE NOT NULL DEFAULT GETDATE()
)
GO

CREATE TABLE Supplies
(
	DrinkId varchar(10) CONSTRAINT FK_PK_DrinkLink  FOREIGN KEY(DrinkId) REFERENCES Drink (DrinkId) not null,
	IngredientID varchar(10)  CONSTRAINT FK_PK_IngredientLink FOREIGN KEY(IngredientId) REFERENCES Ingredient (IngredientId) not null,
	Primary Key(DrinkId, IngredientId)
)

/*Topping NVARCHAR(50) NOT NULL,
Ice INT NOT NULL,
SUGAR INT NOT NULL*/





CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL,
	PassWord NVARCHAR(100) NOT NULL ,
	Position NVARCHAR(100) NOT NULL ,--1:quản lý,--2:nv quản lý kho,--3:nv quản lý hóa đơn ,--4:nv quản lý menu
)
GO

INSERT dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Position
)
VALUES
(   N'kminh', -- UserName - nvarchar(100)
    N'Khải Minh', -- DisplayName - nvarchar(100)
    N'1701yeu2409', -- PassWord - nvarchar(100)
    N'Quản lý'   -- Position - nvarchar(100)
    )

INSERT dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Position
)
VALUES
(   N'hminh', -- UserName - nvarchar(100)
    N'Huỳnh Minh', -- DisplayName - nvarchar(100)
    N'minhdesigner', -- PassWord - nvarchar(100)
    N'Quản lý Menu'   -- Position - nvarchar(100)
    )

INSERT dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Position
)
VALUES
(   N'luan', -- UserName - nvarchar(100)
    N'Thành Luân', -- DisplayName - nvarchar(100)
    N'luanmegame', -- PassWord - nvarchar(100)
    N'Quản lý kho'   -- Position - nvarchar(100)
    )

INSERT dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Position
)
VALUES
(   N'quyen', -- UserName - nvarchar(100)
    N'Trần Quyền', -- DisplayName - nvarchar(100)
    N'quyencothu', -- PassWord - nvarchar(100)
    N'Nhân viên'   -- Position - nvarchar(100)
    )

INSERT INTO Category VALUES ('ORG', N'Nguyên bản')
INSERT INTO Category VALUES ('NOEL', N'Giáng sinh')
INSERT INTO Drink VALUES ('TRADIT','ORG', N'Trà sữa Truyền thống',  20000)
INSERT INTO Drink VALUES ('FMILK', 'ORG', N'Sữa tươi', 20000)
