USE Company;
GO

-- 1. Viết đoạn lệnh (code) có khai báo biến tên emp_salary với kiểu dữ liệu numeric(10,2) (giống với kiểu dữ liệu của trường lương (salary) bảng employee) để cho phép xem tổng lương của công ty đã đạt mức 300000?
-- Nếu tổng lương từ 300000 trở lên hệ thống cần hiển thị thông điệp 'win!', ngược lại chưa đạt thì hiển thị 'lose!'.

-- Lệnh SQL1:
DECLARE @emp_salary NUMERIC(10, 2);
SELECT @emp_salary = SUM(Salary) FROM Employee
IF @emp_salary > 300000
    PRINT 'Win'
ELSE PRINT 'Lose';
GO


-- Thực hiện – Kết quả (kiểm chứng)

-- 2. Viết đoạn lệnh (code) thực hiện mô tả giới tính nhân viên, biết rằng nếu giới tính là M thì 'Gender' là Man, F thì là Woman, các trường hợp khác thì là 'Les or Gay'.
-- Gợi ý: Sử dụng cấu trúc rẽ nhánh iif hoặc case...when.
DECLARE @Gender CHAR(1);
SELECT @Gender = e.Sex FROM Employee e WHERE e.FName = 'John'
IF @Gender = 'M'
    PRINT 'Gender: Man'
ELSE
    IF @Gender = 'F'
        PRINT 'Gender: Woman'
    ELSE
        PRINT 'Gender: Les or Gay'
GO


-- Thực hiện – Kết quả (kiểm chứng)

-- 3. Viết đoạn lệnh (code) thực hiện nâng tổng lương của công ty đã đạt 300000 bằng việc thực hiện cập nhật lương nhân viên tăng 1000 cho đến khi tổng lương công ty đã đạt 300000 nhưng lương của một nhân viên không được tăng quá 100000.
-- Gợi ý: Sử dụng lặp while.
-- Create a #temp table to store the Identity 1, 1 as SSN 
-- Alternative: RowNumber()
SELECT IDENTITY(INT, 1, 1) AS RowNum, SSN, Salary INTO #temp FROM Employee
DECLARE @TotalSalary INT, @EmployeeSalary INT, @Counter INT, @LengthTable INT, @SSN VARCHAR(9)
SELECT @Counter = 1
SELECT @TotalSalary = SUM(Salary) FROM #temp
SELECT @LengthTable = COUNT(*) FROM #temp
WHILE @TotalSalary <= 300000
BEGIN
    SELECT @EmployeeSalary = Salary, @SSN = SSN FROM #temp WHERE RowNum = @Counter
    IF @EmployeeSalary < 100000
        BEGIN
            SET @EmployeeSalary = @EmployeeSalary + 1000
            PRINT 'SSN' + ' ' + @SSN + ', ' + 'Update Salary' + ' ' + CONVERT(VARCHAR, @EmployeeSalary)
            PRINT 'Total Salary' + ' ' + CONVERT(VARCHAR, @TotalSalary)
            -- Update the employee salary in the table
            UPDATE #temp SET Salary = Salary + 1000 WHERE RowNum = @Counter
            -- Add 1000 to the total Salary
            SET @TotalSalary = @TotalSalary + 1000
        END
        -- Update Counter
    SET @Counter = @Counter + 1
    IF @Counter > @LengthTable
        SET @Counter = 1    
END;
GO


-- Thực hiện – Kết quả (kiểm chứng)

-- 4. Bạn xem code của Sinh viên A như sau:
-- begin try 
-- select 1 / 0 as error;
-- end try
-- begin catch
-- Ở đoạn lệnh (code) trên, Sinh viên A vô tình thực hiện phép chia một số cho 0, khi thực hiện hệ thống báo lỗi, tuy nhiên sinh viên A không xác định được lỗi gì?
-- Bạn hãy giúp sinh viên A cấp phát lỗi gồm: hiển thị dòng lỗi, thông điệp lỗi để sinh viên A có thể hoàn thành bài tập.
BEGIN TRY 
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT 
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO




-- 5.	Cấp phát 5 loại lỗi của sinh viên A gồm: tên server, số lỗi, tình trạng lỗi, dòng lỗi, thông điệp lỗi sau khi nhập dữ liệu vào bảng Phòng ban ([dbo].[Department]) với giá trị cột nhập tên phòng ban Dname là 'nonamenonamenoname' và câu lệnh insert của Sinh viên A như sau:
-- INSERT INTO [dbo].[Department]([DName],[DNumber],[Mgrssn],[MgrStartdate]) values('nonamenonamenoname',5,'123456789',getdate())
-- Lệnh
--SQL1
BEGIN TRY
    INSERT INTO [dbo].[Department]([DName],[DNumber],[Mgrssn],[MgrStartdate]) values('nonamenonamenoname',5,'123456789',getdate());
END TRY

BEGIN CATCH
SELECT 
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO
-- Thực hiện – Kết quả (kiểm chứng)

-- 6. Tạo một thủ tục tên proc_project_hours cho phép liệt kê thông tin tất cả dự án và tổng số giờ/tuần mà mà tất cả nhân viên thực hiện cho mỗi dự án.
-- Lệnh
-- --SQL1
CREATE PROCEDURE proc_project_hours 
AS
BEGIN
    SELECT p.PName, SUM(w.Hours) AS TotalHoursperWeek
    FROM Works_On w JOIN Project p ON p.PNumber = w.Pno GROUP BY p.PName;
END


-- --thực thi proc_project_hours để xem kết quả
-- Viết lệnh thực hiện gọi thực thi thủ tục vừa tạo theo 3 cách và hiển thị kết quả ra màn hình.
-- Lệnh
-- --SQL1
EXEC proc_project_hours 
EXECUTE proc_project_hours 
BEGIN EXECUTE proc_project_hours END
GO

-- 7. Tạo một thủ tục tên proc_search_pro_emps cho phép người dùng nhập tên dự án bất kỳ thì hệ thống hệ thống trả về kết quả có/không?
-- Nếu có hệ thống sẽ liệt kê tên của tất cả các nhân viên làm việc cho dự án đó.
-- Nếu không hệ thống hiển thị thông điệp 'not found'.
-- ***Câu hỏi phụ: có bao nhiêu tham số nhập?
-- Lệnh
-- --SQL1
CREATE PROCEDURE proc_search_pro_emps
@ProjectName VARCHAR(50)
AS
BEGIN
-- Check if there is any result
    IF EXISTS(SELECT * FROM Project WHERE PName = @ProjectName)
        BEGIN
            SELECT e.FName + ' ' + e.Minit + ' ' + e.LName AS FullName FROM Employee e 
            JOIN Works_On w ON w.ESSN = e.SSN 
            JOIN Project p ON p.PNumber = w.PNo
            WHERE p.PName = @ProjectName
        END
    ELSE
        PRINT 'Not Found'
END;
GO

-- Viết lệnh thực hiện gọi thực thi thủ tục tên proc_search_pro_emps.
-- Lệnh
-- --SQL1
EXEC proc_search_pro_emps @ProjectName = 'ProductX'
EXEC proc_search_pro_emps @ProjectName = 'ProductY'
EXEC proc_search_pro_emps @ProjectName = 'ProductZ'
EXEC proc_search_pro_emps @ProjectName = 'ProductXZ'
GO

-- 8. Tạo một thủ tục tên proc_insert_date_for_Project cho phép người dùng nhập dữ liệu cho bảng dự án (Project).
-- ***Câu hỏi phụ: có bao nhiêu tham số nhập?
-- Lệnh
-- --SQL1
CREATE PROCEDURE proc_insert_date_for_Project
@ProjectName VARCHAR(50),
@ProjectNumber INT,
@ProjectLocation VARCHAR(50),
@DNum INT
AS
BEGIN
    INSERT INTO Project(PName, PNumber, PLocation, DNum) 
    VALUES (@ProjectName, @ProjectNumber, @ProjectLocation, @DNum);
END;
GO

-- Viết lệnh thực hiện gọi thực thi thủ tục tên proc_insert_date_for_project
-- Lệnh
-- --SQL1
EXEC proc_insert_date_for_Project @ProjectName = 'ProjectAI', @ProjectNumber = 40, 
@ProjectLocation = 'Sugarland', @DNum = 5;
GO

-- 9. Tạo một thủ tục tên proc_salary_review cho phép xuất thông tin lương cao nhất, lương thấp nhất, lương trung bình nhân viên của công ty.
-- ***Câu hỏi phụ: có bao nhiêu tham số nhập, xuất?
-- Lệnh
-- --SQL1
-- Cach 1
CREATE PROCEDURE proc_salary_review
AS
BEGIN
    SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, 
    AVG(Salary) AS AverageSalary FROM Employee
END;
GO

EXEC proc_salary_review 
GO
-- Viết một thủ tục tên proc_execute_proc_salary_review để thực hiện gọi thực thi thủ tục tên proc_salary_review.
-- Lệnh
-- --SQL1
CREATE PROCEDURE proc_execute_proc_salary_review 
AS
BEGIN
    EXEC proc_salary_review
END;
GO

-- Viết lệnh thực thi proc_execute_proc_salary_review để xem kết quả.
-- Lệnh
-- --SQL1
EXEC proc_execute_proc_salary_review;
GO

-- 10. Tạo một thủ tục tên proc_Project_salary_total cho phép người dùng nhập vào tên project, hệ thống xuất thông tin tổng số lượng nhân viên, tổng số giờ làm việc của dự án đó.
-- ***Câu hỏi phụ: có bao nhiêu tham số nhập, xuất?
-- Lệnh
-- --SQL1
CREATE PROCEDURE proc_Project_salary_total
@ProjectName VARCHAR(50),
@TotalEmployees INT OUTPUT,
@TotalHours NUMERIC(3, 1) OUTPUT
AS
BEGIN
    IF EXISTS(SELECT * FROM Project WHERE PName = @ProjectName)
        BEGIN
        SELECT @TotalEmployees = COUNT(ESSN), @TotalHours = SUM(Hours) FROM Works_On w
        JOIN Project p ON p.PNumber = w.PNo WHERE p.PName = @ProjectName
        END
    ELSE
        PRINT 'Not Found'
END;
GO


-- Viết một thủ tục tên proc_exec_Project_salary_total để thực hiện gọi thực thi thủ tục tên proc_Project_salary_total.
-- Lệnh
-- --SQL1
CREATE PROCEDURE proc_exec_Project_salary_total
@ProjectName VARCHAR(50)
AS
BEGIN -- USe Declare to return an output value
    DECLARE @TotalEmployees INT, @TotalHours INT 
    EXEC proc_Project_salary_total @ProjectName = @ProjectName, 
    @TotalEmployees = @TotalEmployees OUTPUT, @TotalHours = @TotalHours OUTPUT
    PRINT @TotalEmployees
    PRINT @TotalHours
END;
GO

EXEC proc_exec_Project_salary_total @ProjectName = 'ProductX'

-- 11. Viết câu lệnh xóa các thủ tục procedure vừa tạo
-- Lệnh
-- --SQL1
DROP PROCEDURE proc_project_hours 
DROP PROCEDURE proc_search_pro_emps
DROP PROCEDURE proc_insert_date_for_Project 
DROP PROCEDURE proc_salary_review
DROP PROCEDURE proc_execute_proc_salary_review 
DROP PROCEDURE proc_Project_salary_total 
DROP PROCEDURE proc_exec_Project_salary_total 
GO

-- 12. Liệt kê và mô tả công dụng 5 thủ tục có sẵn trong hệ thống mà bạn biết.
-- ví dụ: đổi tên table, database, xem thông tin thiết kế bảng, gán rule, gán default hoặc gỡ bỏ,…
-- Thực hiện – Kết quả (kiểm chứng)


-- Bất kỳ, hệ thống trả về kết quả tăng lương vừa nhập lên 10%.
-- Gợi ý: sử dụng hàm Scalar functions
-- Lệnh
-- SQL1
CREATE FUNCTION salary_increase (@Salary NUMERIC(10, 0))
RETURNS NUMERIC(10, 0)
AS 
BEGIN
    RETURN @Salary * 1.10
END;
GO


-- Viết mã lệnh (code) thực hiện gọi hàm vừa tạo và hiển thị kết quả ra màn hình.
-- Lệnh
-- SQL1
-- Remember to add dbo.FunctionName()
SELECT Salary, dbo.salary_increase(Salary) AS SalaryTenPercent FROM Employee;
GO

-- 14. Tạo hàm tên fx_review_salary, cho phép người dùng xem những nhân viên có lương cao hơn lương bình quân công ty.
-- Gợi ý: sử dụng Inline Table-Valued Function
-- Lệnh
-- SQL1 Inline Table-Valued Function always return a table
CREATE FUNCTION fx_review_salary()
RETURNS TABLE
AS
    RETURN (SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee));
GO
-- Caution (SELECT * FROM Employee WHERE Salary > AVG(Salary)) Is invalid
-- Viết mã lệnh (code) thực hiện gọi hàm vừa tạo và hiển thị kết quả ra màn hình.
-- Lệnh
-- SQL1
SELECT * FROM dbo.fx_review_salary();
GO


-- 15. Tạo hàm tên fx_emp_project, cho phép người dùng nhập tên nhân viên bất kỳ, hệ thống trả về thông tin các project mà nhân viên đó tham gia.
-- Gợi ý: sử dụng Inline Table-Valued Function
-- Lệnh
-- SQL1
CREATE FUNCTION fx_emp_project(@FullName VARCHAR(100))
RETURNS TABLE
AS
    RETURN (SELECT p.PName, p.PNumber, p.PLocation, p.DNum FROM Works_On w 
    JOIN Employee e ON w.ESSN = e.SSN 
    JOIN Project p ON p.PNumber = w.PNo
    WHERE (e.FName + e.LName) = @FullName)
GO


-- Viết mã lệnh (code) thực hiện gọi hàm vừa tạo và hiển thị kết quả ra màn hình.
-- Lệnh
-- SQL1
SELECT * FROM dbo.fx_emp_project('JohnSmith');
GO

SELECT * FROM dbo.fx_emp_project('FranklinWong');
GO

-- 16. Tạo hàm tên fx_emp_project_2, cho phép người dùng nhập tên nhân viên bất kỳ, hệ thống trả về thông tin các project mà nhân viên đó tham gia thực hiện.
-- Kết quả những dòng trả về được lưu vào một bảng tạm (trong một biến tạm - a temporary table).
-- Gợi ý: sử dụng Multistatement Table-Valued Function
-- Lệnh
-- SQL1
CREATE FUNCTION fx_emp_project2(@FullName VARCHAR(100))
RETURNS @TemproraryTable TABLE (PName VARCHAR(50), PNumber INT, PLocation VARCHAR(50), DNum INT)
AS
    BEGIN
    INSERT INTO @TemproraryTable SELECT p.PName, p.PNumber, p.PLocation, p.DNum FROM Works_On w 
    JOIN Employee e ON w.ESSN = e.SSN 
    JOIN Project p ON p.PNumber = w.PNo
    WHERE (e.FName + e.LName) = @FullName
    RETURN
    END
GO


-- Viết mã lệnh (code) thực hiện gọi hàm vừa tạo và hiển thị kết quả ra màn hình.
-- Lệnh
-- SQL1
SELECT * FROM dbo.fx_emp_project2('JohnSmith');
GO

SELECT * FROM dbo.fx_emp_project2('FranklinWong');
GO
