USE Company;
GO

-- 1. Tạo trigger tên trg_check_lblank kiểm tra khi nhập hoặc sửa dữ liệu các trường fname, lname cho bảng nhân viên 
-- có chứa kí tự trắng bên trái. Nếu có, hệ thống sẽ xóa bỏ các ký tự trắng này.

--SQL1
CREATE TRIGGER trg_check_lblank
ON Employee
FOR INSERT, UPDATE
AS
BEGIN
    UPDATE Employee SET FName = LTRIM(FName) WHERE FName IN (SELECT FName FROM INSERTED) AND FName LIKE ' %'
    UPDATE Employee SET LName = LTRIM(LName) WHERE LName IN (SELECT LName FROM INSERTED) AND LName LIKE ' %'
END;
GO




-- Viết câu lệnh thực hiện nhập fname, lname rỗng (null) hoặc cập nhật fname, lname có chứa ký tự trắng bên trái để kiểm chứng trigger vừa tạo.

--SQL1
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES (' John', 'B', ' Dean', '123456797', '1955-01-11', 'Houston, TX', 'M', 31000);
GO

-- 2. Tạo trigger tên trg_check_number kiểm tra khi nhập hoặc sửa dữ liệu cho trường ssn, supperssn cho bảng nhân viên 
-- bắt buộc phải là 9 ký số. Nếu nhập sai hệ thống sẽ ngăn chặn không cho phép nhập 
-- và hiển thị thông điệp hướng dẫn người dùng nhập lại đúng theo cú pháp: 111111111.
CREATE TRIGGER trg_check_number
ON Employee
INSTEAD OF INSERT, UPDATE
AS
IF EXISTS (SELECT SSN FROM Employee WHERE SSN IN (SELECT SSN FROM INSERTED) 
AND SSN NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
        RAISERROR('Invalid SSN, must be 9-digit long, e.g., 111111111', 16, 1)
        ROLLBACK TRANSACTION
    END
ELSE
    IF EXISTS (SELECT Super_SSN FROM Employee WHERE Super_SSN IN (SELECT Super_SSN FROM INSERTED) 
    AND Super_SSN NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
        RAISERROR('Invalid Super_SSN, must be 9-digit long, e.g., 111111111', 16, 1)
        ROLLBACK TRANSACTION
    END 
GO
--SQL1
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('John', 'D', ' Roose', '123456733ee', '1955-07-21', 'Houston, TX', 'M', 31000);
GO

-- Thực hiện – Kết quả (kiểm chứng)

-- 3. Viết trigger tên trg_NoDel_Dept không cho phép xóa dữ liệu bảng phòng ban (Department). 
-- Khi hành động diễn ra, hệ thống hiển thị thông điệp 'Deletion of Department is not allowed', 
-- và khôi phục trạng thái ban đầu như chưa xóa.
-- Instead of: Override the Trigger error before checking constraint
CREATE TRIGGER trg_NoDel_Dept
ON Department
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Deletion of Department is not allowed', 16, 1)
    ROLLBACK TRANSACTION
END;
GO

--SQL1
DELETE FROM Department WHERE Dnumber = 5
GO
-- Thực hiện – Kết quả (kiểm chứng)

-- 4. Viết trigger tên trg_NoUpdateName_Dept không cho phép sửa tên phòng ban.

-- Gợi ý:
-- a. Tạo 1 bảng Temp với cấu trúc bảng giống bảng Department như bên dưới.

-- CREATE TABLE Temp
-- (
--     [DName] varchar(15),
--     [DNumber] numeric(4,0),
--     [Mgrssn] char(9),
--     [MgrStartdate] datetime
-- )

-- b. Kế tiếp, tạo trigger INSTEAD OF UPDATE nhập dữ liệu vào bảng Temp này.

--SQL1

-- Thực hiện – Kết quả (kiểm chứng)

-- 5. Giả sử sinh viên A đã tạo một CSDL tên mysales gồm 2 bảng tbl_product, tbl_order như bên dưới:

--SQL1
create database mysales
use mysales
CREATE TABLE tbl_product
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	productID varchar(15) NOT NULL UNIQUE,
	productName NVARCHAR(200) NOT NULL UNIQUE,
	productQTY DECIMAL(6,2),
	productPrice DECIMAL(10,2) NOT NULL,
	lineTotal DECIMAL(18,2),
	productDate DATETIME NOT NULL
)
CREATE TABLE tbl_order
(
	orderID INT NOT NULL,
	productID varchar(15) NOT NULL,
	orderQty DECIMAL(6,2),
	productName NVARCHAR(100),
	TOTAL DECIMAL(18,2),
	orderDate DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_tbl_Order_OrderID_productID PRIMARY KEY(orderID,productID), 
	CONSTRAINT FK_tbl_Order_productID FOREIGN KEY(productID) REFERENCES tbl_product(productID)
)
GO

-- Yêu cầu:
-- a. Tạo trigger thực hiện tính tự động lineTotal = productQTY * productPrice mỗi khi nhập hoặc cập nhật dữ liệu cho bảng tbl_product
CREATE TRIGGER trg_LineTotal
ON tbl_product
FOR INSERT, UPDATE
AS
BEGIN
    UPDATE tbl_product SET lineTotal = productQTY * productPrice
END;
GO

--SQL1
-- --- câu a
INSERT INTo 

-- b. Tạo trigger thực hiện tính tự động giảm số lượng (productQTY) trong bảng tbl_product mỗi khi nhập dữ liệu 
-- theo từng mã sản phẩm (productID) trên bảng tbl_order

--SQL1
-- --- câu b

-- c. Tạo trigger thực hiện tính tự động cập nhật số lượng (productQTY) trong bảng tbl_product 
-- mỗi khi cập nhật dữ liệu theo từng mã sản phẩm (productID) trên bảng tbl_order

--SQL1
-- --- câu c

-- 6. Viết lệnh vô hiệu hóa trigger vừa tạo ở câu 1

--SQL1
DISABLE TRIGGER trg_check_lblank ON Employee;
GO

DISABLE TRIGGER trg_NoDel_Dept ON Department;
GO

DISABLE TRIGGER trg_check_number ON Employee;
GO

-- 7. Viết lệnh kích hoạt trigger vừa tạo ở câu 1

--SQL1
ENABLE TRIGGER trg_check_lblank ON Employee;
GO

ENABLE TRIGGER trg_NoDel_Dept ON Department;
GO

ENABLE TRIGGER trg_check_number ON Employee;
GO
-- 8. Viết lệnh xóa trigger vừa tạo câu 1
--SQL1
DROP TRIGGER trg_check_lblank
GO

DROP TRIGGER trg_NoDel_Dept
GO

DROP TRIGGER trg_check_number
GO