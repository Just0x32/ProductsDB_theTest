CREATE DATABASE productsdb
GO
USE productsdb

CREATE TABLE Products
(
	Id INT IDENTITY (1, 1) NOT NULL UNIQUE,
	Name NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Tools_Id PRIMARY KEY (Id)
)

INSERT Products VALUES
	('Отвёртка'),
	('Нож'),
	('Изолента'),
	('Лом'),
	('Лопата'),
	('Отмычки'),
	('Домкрат')

CREATE TABLE Categories
(
	Id INT IDENTITY (1, 1) NOT NULL UNIQUE,
	Name NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Categories_Id PRIMARY KEY (Id)
)

INSERT Categories VALUES
	('Дом'),
	('Сад'),
	('Авто')

CREATE TABLE Products_By_Categories
(
	Id INT IDENTITY (1, 1) NOT NULL UNIQUE,
	ProductId INT NOT NULL,
	CategoryId INT NOT NULL,
	CONSTRAINT PK_Products_By_Categories_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Products_By_Categories_Products FOREIGN KEY (ProductId)
		REFERENCES Products (Id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Products_By_Categories_Categories FOREIGN KEY (CategoryId)
		REFERENCES Categories (Id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)

INSERT Products_By_Categories VALUES
	(1, 2),
	(1, 3),
	(2, 1),
	(2, 2),
	(3, 1),
	(3, 3),
	(4, 3),
	(5, 2),
	(7, 3)

SELECT Products.[Name] as Product, Categories.[Name] as Category
	FROM Products, Categories, Products_By_Categories prod_cat
	WHERE prod_cat.ProductId = Products.Id AND prod_cat.CategoryId = Categories.Id
UNION
SELECT Products.[Name] as Product, 'Без категории' as Category
	FROM Products
	WHERE Products.Id NOT IN
	(
		SELECT ProductId
			FROM Products_By_Categories
	)
	
ORDER BY Product