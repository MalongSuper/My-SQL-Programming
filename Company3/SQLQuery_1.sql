-- A.	Ràng buộc - Constraint
-- 1.	Viết câu lệnh thêm trường HireDate (ngày vào làm) vào bảng Employee. Viết câu lệnh tạo ràng buộc (Default) tên def_EmpHireDate để khi thêm một nhân viên mới thì mặc nhiên HireDate là ngày hiện hành.
-- Lệnh
-- --SQL1
USE Company;
GO

ALTER TABLE EMPLOYEE
ADD EmpHireDate DATE;

ALTER TABLE Employee
ADD CONSTRAINT def_EmpHireDate DEFAULT GETDATE() FOR EmpHireDate;

	
-- Thực hiện – Kết quả (kiểm chứng)

-- (Chụp màn hình kết quả dán vào đây)
-- 2.	Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpSex để khi nhập, sửa giới tính (Sex) nhân viên chỉ nhận giá trị ‘M’ hoặc ‘F’.
-- Lệnh
-- --SQL1
ALTER TABLE  EMPLOYEE
ADD CONSTRAINT chk_EmpSex CHECK (Sex = 'M' OR Sex = 'F');
GO
-- Thực hiện – Kết quả (kiểm chứng)

-- 3.	Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpSal để khi thêm hay cập nhật lương (Salary) một nhân viên tối thiểu là 25000.
-- Lệnh
-- --SQL1
ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_EmpSal CHECK (Salary >= 25000);
GO
-- Thực hiện – Kết quả (kiểm chứng)

-- 4.	Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpAge18 để khi thêm hay cập nhật ngày vào làm (HireDate) phải từ 18 tuổi trở lên.
-- Lệnh
-- --SQL1
ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_EmpAge18 CHECK ((DATEPART(year, EmpHireDate) - DATEPART(year, BDate)) >= 18);
GO
-- Thực hiện – Kết quả (kiểm chứng)

-- 5.	Viết câu lệnh thêm cột Password sử dụng kiểu dữ liệu varchar(20) vào bảng Employee. Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpPwd để khi nhập, hiệu chỉnh dữ liệu cho trường này có thể bỏ trống (rỗng) hoặc phải từ 8 ký tự trở lên.
-- Lệnh
-- --SQL1
ALTER TABLE EMPLOYEE
ADD Password VARCHAR(20),
    CONSTRAINT chk_EmpPwd CHECK (Password IS NULL OR LEN(Password) >= 8);
GO
-- Thực hiện – Kết quả (kiểm chứng)
-- 6.	Viết câu lệnh tạo mặc định (default) tên df_sex với giá trị có sẵn (mặc định) là nữ nếu người dùng không nhập dữ liệu. Thực hiện gán/áp dụng  default df_sex cho giới tính (Sex) trong bảng Nhân viên (Employee).
-- Lệnh
-- --SQL1
ALTER TABLE EMPLOYEE
ADD CONSTRAINT df_sex DEFAULT 'F' FOR Sex;
GO
-- 7.	Viết câu lệnh tạo một qui tắc nhập liệu (rule) tên rule_Salary cho phép người dùng nhập lương lơn hơn hoặc bằng zero và nhỏ hơn bằng 100000. Thực hiện gán/áp dụng rule rule_Salary cho lương (Salary) trong bảng Nhân viên (Employee).
-- Lệnh
-- --SQL1
ALTER TABLE EMPLOYEE
ADD CONSTRAINT rule_Salary CHECK (Salary >= 0 OR Salary < 10000) 

-- 8.	Viết câu lệnh liệt kê các ràng buộc đang tồn tại trong 1 CSDL, ví dụ: Company
-- Lệnh 
-- --SQL1
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

-- Thực hiện – Kết quả (kiểm chứng)

-- 9.	Viết câu lệnh tạo cho biết tên ràng buộc khóa chính (Primary key) trong bảng Employee của 1 CSDL. ví dụ: CSDL Company.
-- Lệnh 
-- --SQL1
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Employee';

-- Thực hiện – Kết quả (kiểm chứng)

-- 10.	Viết câu lệnh xóa các ràng buộc đã tạo ở câu 1, 2 ,3, 5 gồm: def_EmpHireDate, chk_EmpSex, chk_EmpSal, chk_EmpPwd.
-- Lệnh 
-- --SQL1
ALTER TABLE EMPLOYEE
DROP CONSTRAINT def_EmpHireDate;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_EmpSex;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_EmpSal;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_EmpPwd;

-- 11.	Viết câu lệnh gỡ bỏ các mặc định (default) đã tạo (nếu có) trên trường Sex bảng Employee và xóa các mặc định (default) này.
-- Lệnh 
-- --SQL1
ALTER TABLE EMPLOYEE
DROP CONSTRAINT df_sex;

-- 12.	Viết câu lệnh gỡ bỏ các các quy tắc nhập liệu (rule) đã tạo (nếu có) trên trường Salary bảng Employee và xóa các quy tắc nhập liệu (rule) này.
-- Lệnh
-- --SQL1
ALTER TABLE EMPLOYEE
DROP CONSTRAINT rule_Salary;

-- 13.	Liệt kê các ràng buộc trong SQL mà bạn biết, lưu ý tối thiểu 3 ràng buộc.
-- Thực hiện – Kết quả (kiểm chứng)
-- Tra Loi: PRIMARY KEY, UNIQUE KEY, FOREIGN KEY, DEFAULT, CHECK



