USE MilkTeaShop
GO

CREATE PROC USP_GetAccountByUserName	
@username NVARCHAR(50)
AS
BEGIN
	SELECT* FROM dbo.Account WHERE @username=UserName
END
GO

EXEC dbo.USP_GetAccountByUserName @username = N'kminh' -- nvarchar(50)
GO

CREATE PROC USP_GetAccount	
AS
BEGIN
	SELECT* FROM dbo.Account 
END
GO
 
EXEC dbo.USP_GetAccount
GO

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

EXECUTE dbo.USP_GetCardList

SET IDENTITY_INSERT OrderCard ON

CREATE PROC CardUpdate(@n int)
AS
	BEGIN
		DECLARE @i INT = 0;
		DELETE OrderCard
		DBCC CHECKIDENT(OrderCard, RESEED, 0)
		WHILE @i<@n
		BEGIN
			INSERT dbo.OrderCard(CardName) VALUES (N'Thẻ số '+CAST(@i AS NVARCHAR(44)))
			SET @i+=1
		END
	END
DROP PROC CardUpdate

EXEC CardUpdate 10

--UPDATE dbo.CardUpdate SET CardStatus = N'Đã có người' WHERE CardId =9


CREATE PROC USP_GetPos(@Username nvarchar(100), @pass nvarchar(100))
AS
	BEGIN
		SELECT position
		FROM dbo.Account
		WHERE Username=@Username AND PassWord=@pass
	END

EXEC USP_GetPos N'hminh', N'minhdesigner' 

EXEC USP_GetPos N'kminh', N'1701yeu2409' 

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
DROP PROC CheckAccount
EXEC CheckAccount N'hminh', 'minhdesigner'
EXEC CheckAccount N'hminh1', 'minhdesigner1'


CREATE PROC SelectCategoryNumber(@CategoryId nvarchar(10))
AS
	BEGIN
		SELECT COUNT(*) FROM Category WHERE (CategoryId = @CategoryId)
	END

EXEC SelectCategoryNumber N'N0'