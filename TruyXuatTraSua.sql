USE MilkTeaShop
GO

CREATE PROC USP_GetAccountByUserName	
@username NVARCHAR(50)
AS
BEGIN
	SELECT* FROM dbo.Account WHERE @username=UserName
END
GO

--EXEC dbo.USP_GetAccountByUserName @username = N'kminh' -- nvarchar(50)
--GO

CREATE PROC USP_GetAccount	
AS
BEGIN
	SELECT* FROM dbo.Account 
END
GO
 
--EXEC dbo.USP_GetAccount
--GO

CREATE PROC USP_Login	
@userName NVARCHAR(100),@passWord NVARCHAR(100), @position NVARCHAR(100)
AS
BEGIN
	SELECT* FROM dbo.Account WHERE  @userName=UserName AND @passWord=PassWord  AND @position=Position
END
GO

CREATE PROC USP_GetCardList
AS
BEGIN
	SELECT* FROM dbo.OrderCard
END
GO

--EXECUTE dbo.USP_GetCardList

--SET IDENTITY_INSERT OrderCard ON

CREATE PROC CardUpdate(@i int)
AS
	BEGIN
		--DBCC CHECKIDENT(OrderCard, RESEED, 0)
		INSERT dbo.OrderCard VALUES (@i, N'Thẻ số '+CAST(@i AS NVARCHAR(44)), 0)
		SELECT* FROM dbo.OrderCard
	END
GO
--DROP PROC CardUpdate

--EXEC CardUpdate 31

CREATE PROC CardRemove(@i int)
AS
	BEGIN
		--DBCC CHECKIDENT(OrderCard, RESEED, 0)
		DELETE dbo.OrderCard WHERE CardId=@i
		SELECT* FROM dbo.OrderCard
	END
GO

--UPDATE dbo.CardUpdate SET CardStatus = N'Đã có người' WHERE CardId =9


CREATE PROC USP_GetPos(@Username nvarchar(100), @pass nvarchar(100))
AS
	BEGIN
		SELECT position
		FROM dbo.Account
		WHERE Username=@Username AND PassWord=@pass
	END
GO
--EXEC USP_GetPos N'hminh', N'minhdesigner' 

--EXEC USP_GetPos N'kminh', N'1701yeu2409' 

CREATE PROC CheckAccount(@Username nvarchar(100), @pass nvarchar(100))
AS
	BEGIN
		DECLARE @Bool nvarchar(10)
		SET @Bool=(SELECT COUNT(*) FROM dbo.Account WHERE @Username = Username AND @pass = PassWord)
		IF(@Bool=1)
			SELECT N'true'
		IF(@Bool=0)
			SELECT N'false'
	END
GO
--DROP PROC CheckAccount
--EXEC CheckAccount N'hminh', 'minhdesigner'
--EXEC CheckAccount N'hminh1', 'minhdesigner1'


CREATE PROC SelectCategoryNumber(@CategoryId nvarchar(10))
AS
	BEGIN
		SELECT COUNT(*) FROM Category WHERE (CategoryId = @CategoryId)
	END
GO
--EXEC SelectCategoryNumber N'N0'

CREATE PROC SelectAllCategoryId
AS
	BEGIN
		SELECT CategoryId FROM Category
	END
--EXEC SelectAllCategoryId
GO

CREATE PROC SelectCategoryName(@Cid varchar(10))
AS
	BEGIN
		SELECT CategoryName FROM Category WHERE CategoryId=@Cid
	END
--EXEC SelectCategoryName 'ORG'
GO

/*CREATE PROC InsertBill(@CardId int)
AS
	BEGIN
		INSERT dbo.Bill VALUES (CAST(@CardId AS VARCHAR(10)) + CAST(DatePart(Hour, GetDate()) AS varchar(10)) + CAST(DatePart(Minute, GetDate()) AS varchar(10)) + CAST(DatePart(SECOND, GetDate()) AS varchar(10)), 
		@CardId, getDate(), 0, 0)
		
		SELECT* FROM dbo.Bill
	END	
GO*/

CREATE PROC GetBillId(@CardId int)
AS
	BEGIN
		--DBCC CHECKIDENT(BillDetail, RESEED, 1)
		SELECT CAST(@CardId AS VARCHAR(10)) + CAST(DatePart(Hour, GetDate()) AS varchar(10)) + CAST(DatePart(Minute, GetDate()) AS varchar(10)) + CAST(DatePart(SECOND, GetDate()) AS varchar(10))
	END	

CREATE PROC GetBillDetailId(@BillId int)
AS
	BEGIN
		--DBCC CHECKIDENT(BillDetail, RESEED, 1)
		SELECT @BillId + CAST(DatePart(Minute, GetDate()) AS varchar(10)) + CAST(DatePart(SECOND, GetDate()) AS varchar(10))
	END	
--DROP PROC GetBillId
--DBCC CHECKIDENT(OrderCard, RESEED, 0)
--InsertBill 1

CREATE PROC GetCurrentDate
AS
	BEGIN
		SELECT GETDATE()
	END

CREATE PROC GetLatestBillId
AS
	BEGIN
		SELECT TOP 1 *
		FROM Bill
		ORDER BY BillDate DESC
	END

SET IDENTITY_INSERT BillDetail Off

CREATE PROC InsertBillDetail(@BillId varchar(10), @DrinkId varchar(10), @Number int, @Size varchar(10), @Topping varchar(250), @Ice varchar(10), @Sugar varchar(10), @BillDetailPrice int)
AS
	BEGIN
		INSERT INTO BillDetail(BillId) VALUES(@BillId)
		INSERT INTO BillDetail(DrinkId) VALUES(@DrinkId)
		INSERT INTO BillDetail(Number) VALUES(@Number)
		INSERT INTO BillDetail(Size) VALUES(@Size)
		INSERT INTO BillDetail(Topping) VALUES(@Topping)
		INSERT INTO BillDetail(Ice) VALUES(@Ice)
		INSERT INTO BillDetail(Sugar) VALUES(@Sugar)
		INSERT INTO BillDetail(BillDetailPrice) VALUES(@BillDetailPrice)
	END
--INSERT INTO BillDetail VALUES('2185853', 'TRADIT', 1, N'S (Nhỏ)', N'Trân châu vàng', '50%', '50%', 25000)

CREATE PROC GetBillDetailByLatestBillId
AS
	BEGIN
		SELECT *
		FROM BillDetail 
		WHERE BillId=(SELECT TOP 1 BillId FROM Bill ORDER BY BillDate DESC)
	END


CREATE TRIGGER tr_UpdateBill 
ON BillDetail
	FOR INSERT
		AS
			BEGIN
				UPDATE Bill SET TotalPrice+=BillDetail.BillDetailPrice
				FROM inserted, BillDetail
			END
--DROP TRIGGER tr_UpdateBill
--INSERT INTO BillDetail VALUES('2185853', 'TRADIT', 1, N'S (Nhỏ)', N'Trân châu vàng', '50%', '50%', 25000)


--INSERT INTO BillDetail VALUES('10212350', 'TRADIT', 1, N'S (Nhỏ)', N'Trân châu vàng', '50%', '50%', 25000)

--DBCC CHECKIDENT(BillDetail, RESEED, 0)
