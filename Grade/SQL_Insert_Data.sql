﻿USE [GradeManagement]
GO

-- Insert into Subject
INSERT [dbo].[Subject] ([SubjectCode], [SubjectName]) VALUES (N'IT201DV01', N'Cơ sở dữ liệu')
GO
INSERT [dbo].[Subject] ([SubjectCode], [SubjectName]) VALUES (N'IT101DV01', N'Nhập môn lập trình')
GO

-- Insert into Class
INSERT [dbo].[Class] ([ClassCode], [SubjectCode], [Semester], [Lecturer]) VALUES (N'IT101DV01_01', N'IT101DV01', N'25.1A', N'Nguyễn Thị Thu dự')
GO
INSERT [dbo].[Class] ([ClassCode], [SubjectCode], [Semester], [Lecturer]) VALUES (N'IT101DV01_02', N'IT101DV01', N'25.2A', N'Nguyễn Bá Trung')
GO
INSERT [dbo].[Class] ([ClassCode], [SubjectCode], [Semester], [Lecturer]) VALUES (N'IT201DV01_01', N'IT201DV01', N'24.1A', N'Võ Thị Thu Hà')
GO
INSERT [dbo].[Class] ([ClassCode], [SubjectCode], [Semester], [Lecturer]) VALUES (N'IT201DV01_02', N'IT201DV01', N'24.1A', N'Nguyễn Phượng Hoàng')
GO
INSERT [dbo].[Class] ([ClassCode], [SubjectCode], [Semester], [Lecturer]) VALUES (N'IT201DV01_03', N'IT201DV01', N'25.2A', N'Võ Thị Thu Hà')
GO

-- Insert into Student
INSERT [dbo].[Student] ([StudentID], [FullName], [Major]) VALUES (N'2300004', N'Đinh Thy Ngọc Anh', N'CNTT')
GO
INSERT [dbo].[Student] ([StudentID], [FullName], [Major]) VALUES (N'2300005', N'Huỳnh Thị Thúy Anh', N'KTPM')
GO
INSERT [dbo].[Student] ([StudentID], [FullName], [Major]) VALUES (N'2300006', N'Lương Thị Thanh Bình', N'CNTT')
GO
INSERT [dbo].[Student] ([StudentID], [FullName], [Major]) VALUES (N'2300007', N'Trần Thị Kim Duyên', N'CNTT')
GO
INSERT [dbo].[Student] ([StudentID], [FullName], [Major]) VALUES (N'2300008', N'Trần Thụy Phương Đài', N'KTPM')
GO

-- Insert into Enrollment
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300004', N'IT101DV01_02', CAST(8.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300004', N'IT201DV01_01', CAST(7.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300005', N'IT101DV01_01', CAST(7.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300005', N'IT201DV01_01', CAST(5.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300006', N'IT101DV01_01', CAST(4.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300006', N'IT101DV01_02', CAST(9.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300006', N'IT201DV01_01', CAST(3.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300006', N'IT201DV01_02', CAST(6.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300007', N'IT101DV01_01', CAST(8.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300007', N'IT201DV01_03', CAST(8.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300008', N'IT201DV01_02', CAST(4.00 AS Decimal(5, 2)))
GO
INSERT [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES (N'2300008', N'IT201DV01_03', CAST(9.00 AS Decimal(5, 2)))
GO

