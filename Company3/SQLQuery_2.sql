
-- B.	Bảng ảo - View
-- Viết câu lệnh tạo các view và thực hiện các yêu cầu:
-- 14.	Viết câu lệnh tạo view tên v_EmpSuperSSN: cho biết các thông tin tên phòng ban, họ tên nhân viên giám sát (Supper_SSN), họ tên nhân viên.
-- Lệnh
USE Company;
GO

CREATE VIEW [v_EmpSuperSSN] AS
SELECT d.DName, e1.FName AS EmpFName, e1.Minit AS EmpMinit, e1.LName AS EmpLName, 
e2.FName AS SuperFName, e2.Minit AS SuperMinit, e2.LName AS SuperLName
FROM Employee e1
JOIN Department d ON e1.DNo = d.DNumber
JOIN Employee e2 ON e1.SSN = e2.Super_SSN;
GO
	
-- --Xem view đã tồn tại?
	
-- Thực hiện – Kết quả (kiểm chứng)
-- --Truy vấn dữ liệu từ view để kiểm tra kết quả
	
-- 15.	Viết câu lệnh tạo view tên v_DepEmp: cho biết các thông tin Tên phòng ban, Tên trưởng phòng, Họ tên nhân viên của mỗi phòng ban.
-- Lệnh
-- --SQL1
CREATE VIEW [v_DepEmp] AS
SELECT d.DName AS Dept, e1.FName AS MgrFName, e1.LName AS MgrLName, 
e2.FName AS EmpFName, e2.LName AS EmpLName FROM Employee e1
JOIN Employee e2 ON e1.SSN = e2.Super_SSN
JOIN Department d ON d.Mgrssn = e1.SSN;
GO

		
-- Thực hiện – Kết quả (kiểm chứng)

-- 16.	Viết câu lệnh tạo view tên v_PrjEmp: cho biết các thông tin Tên dự án, địa điểm dự án, Tên nhân viên tham gia dự án.
-- Lệnh
-- --SQL1
CREATE VIEW [v_PrjEmp] AS
SELECT p.PName AS ProjectName, p.PLocation AS ProjectLocation,
e.FName AS EmpFName, e.Minit AS EmpMinit, e.LName AS EmpLName FROM Project p 
JOIN Works_On w ON p.PNumber = w.PNo
JOIN Employee e ON w.ESSN = e.SSN;
GO


-- Thực hiện – Kết quả (kiểm chứng)

-- 17.	Viết câu lệnh tạo view tên v_EmpDep: cho biết các thông tin tên nhân viên, tên thân nhân (nếu có), mối quan hệ (relationship) của tất cả các nhân viên.
-- Lệnh
-- --SQL1
CREATE VIEW [v_EmpDep] AS
SELECT e.Fname, e.Minit, e.LName, d.Dependent_Name, d.Relationship
FROM Employee e 
LEFT JOIN Dependent d ON e.SSN = d.ESSN;
GO
	
-- Thực hiện – Kết quả (kiểm chứng)
-- 18.	Viết câu lệnh tạo view tên v_DeptPrj: cho biết các thông tin tên phòng ban, tên dự án, địa điểm dự án, số lượng nhân viên và tổng thời gian dự án.
-- Lệnh
-- --SQL1
CREATE VIEW [v_DeptPrj] AS
SELECT d.DName, p.PName, p.PLocation, 
COUNT(DISTINCT w.ESSN) AS NumofEmployees, SUM(w.Hours) AS TotalHours FROM Department d 
JOIN Project p ON d.DNumber = p.DNum
LEFT JOIN Works_On w ON w.PNo = p.PNumber
GROUP BY d.DName, p.PName, p.PLocation;
GO
	
-- Thực hiện – Kết quả (kiểm chứng)

-- 19.	Viết câu lệnh liệt kê các view vừa tạo.
-- Lệnh
-- --SQL1
SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS

-- 20.	Viết câu lệnh truy vấn dữ liệu từ view đã tạo ở câu 1, 2, 3, 4, 5.
-- Lệnh
-- --SQL1
-- --Truy vấn dữ liệu từ view để kiểm tra kết quả, câu 1
SELECT * FROM v_EmpSuperSSN
SELECT * FROM v_DepEmp
SELECT * FROM v_PrjEmp
SELECT * FROM v_EmpDep
SELECT * FROM v_DeptPrj
	
-- 21.	Viết câu lệnh xóa các view vừa tạo ở câu 1, 2, 3, 4, 5.
-- Lệnh
-- --SQL1
-- --Truy vấn dữ liệu từ view để kiểm tra kết quả, câu 1
DROP VIEW v_EmpSuperSSN
DROP VIEW v_DepEmp
DROP VIEW v_PrjEmp
DROP VIEW v_EmpDep
DROP VIEW v_DeptPrj

-- C.	Chỉ mục - INDEX
-- Viết câu lệnh tạo các chỉ mục (index) và thực hiện các yêu cầu:
-- 22.	Liệt kê các kiểu chỉ mục (index) có trong SQL mà bạn biết.
-- Thực hiện – Kết quả (kiểm chứng)

-- 23.	Viết câu lệnh tạo Single Column Index với tên index là idx_fname cho trường Fname trong bảng Employee.
-- Lệnh
-- --SQL1
CREATE INDEX idx_fname ON Employee(FName);
GO

-- 24.	Viết câu lệnh tạo Single Column Index với tên idx_DepdName cho trường Dependent_Name trong bảng Dependent.
-- Lệnh
-- --SQL1
CREATE INDEX idx_DepdName ON Dependent(Dependent_Name);
GO

-- 25.	Viết câu lệnh tạo Single Column Index với tên idx_Dloca cho trường DLocation trong bảng Dept_Location.
-- Lệnh
-- --SQL1
CREATE INDEX idx_Dloca ON Dept_Location(DLocation);
GO


-- 26.	Viết câu lệnh tạo Single Column Index với tên idx_PrjLoc cho trường PLocation trong bảng Project.
-- Lệnh
-- --SQL1
CREATE INDEX idx_PrjLoc ON Project(PLocation);
GO

-- 27.	Viết câu lệnh tạo Unique Index với tên index là idx_ssn cho trường ssn trong bảng Employee.
-- Lệnh
-- --SQL1
CREATE UNIQUE INDEX idx_ssn ON Employee(SSN);
GO



-- 28.	Viết câu lệnh tạo Unique Index với tên index là idx_address cho trường address trong bảng Employee.
-- Lệnh
-- --SQL1
CREATE INDEX idx_address ON Employee(Address);
GO


-- 29.	Viết câu lệnh tạo Composite Index với tên idx_EmpFLName cho 2 trường: (FName + Lname) trong bảng Employee.
-- Lệnh
-- --SQL1
CREATE INDEX idx_EmpFLName ON Employee(FName, LName);
GO


-- 30.	Viết câu lệnh tạo Composite Index với tên idx_EmpLFName cho 2 trường: (LName + Fname) trong bảng Employee.
-- Lệnh
-- --SQL1
CREATE INDEX idx_EmpLFName ON Employee(LName, FName);
GO


-- 31.	Liệt kê tên các chỉ mục Implicit Index được tạo tự động cho các ràng buộc Primary key hoặc các ràng buộc Unique trong CSDL Company.
-- Lệnh
-- --SQL1
SELECT * FROM sys.tables -- Returns all tables in the system
SELECT * FROM sys.indexes -- Returns all Index Name
SELECT * FROM sys.key_constraints

SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    kc.type_desc AS ConstraintType
FROM 
    sys.key_constraints kc
    JOIN sys.tables t ON kc.parent_object_id = t.object_id
    JOIN sys.indexes i ON kc.parent_object_id = i.object_id AND kc.unique_index_id = i.index_id
WHERE kc.type IN ('PK', 'UQ');
GO


-- 32.	Xem thời gian thực thi câu lệnh sau khi thực hiện tạo index. “Liệt kê thông tin bảng nhân viên. Lưu ý: Sinh viên viết câu lệnh và chụp màn hình kết quả.
-- Lệnh
-- --SQL1
SET STATISTICS TIME ON;
SELECT * FROM Employee;
SET STATISTICS TIME OFF;
GO

-- Kết quả

-- 33.	Viết câu lệnh liệt kê các index vừa tạo.
-- Lệnh và kết quả
-- --SQL1
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

-- 34.	Viết câu lệnh xóa các index tối thiểu 3 index vừa tạo.
-- Lệnh
-- --SQL1
DROP INDEX idx_fname;
DROP INDEX idx_DepdName;
DROP INDEX idx_Dloca;
DROP INDEX idx_PrjLoc;
DROP INDEX idx_ssn;
DROP INDEX idx_address;
DROP INDEX idx_EmpFLName;
DROP INDEX idx_EmpLFName;
GO
