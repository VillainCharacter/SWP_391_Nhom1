Drop database SWP391
create database SWP391
USE SWP391;

-- Tạo bảng Brand
CREATE TABLE Brand (
    bid INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
);

-- Tạo bảng Category
CREATE TABLE Category (
    cid INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
);

-- Tạo bảng Product
CREATE TABLE Product (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cid INT NOT NULL,
    bid INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    image NVARCHAR(255),
    price FLOAT(10) NOT NULL,
    description NVARCHAR(MAX),
    stock INT NOT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (cid) REFERENCES Category(cid),
    CONSTRAINT FK_Product_Brand FOREIGN KEY (bid) REFERENCES Brand(bid)
);

-- Tạo bảng Users
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(50) NOT NULL,
    pass NVARCHAR(50) NOT NULL,
    fullName NVARCHAR(100),
    phone VARCHAR(15),
    address NVARCHAR(1000),
    roleId INT NOT NULL,
    gender NVARCHAR(10),
    dob DATE
);


-- Tạo bảng Feedback
CREATE TABLE Feedback (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    pid INT NOT NULL,
    comment NVARCHAR(MAX),
    rate INT NOT NULL CHECK (rate >= 1 AND rate <= 5), -- Added CHECK constraint for rate
    CONSTRAINT FK_Feedback_User FOREIGN KEY (userId) REFERENCES Users(id),
    CONSTRAINT FK_Feedback_Product FOREIGN KEY (pid) REFERENCES Product(id)
);

-- Tạo bảng Cart
CREATE TABLE Cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    pid INT NOT NULL,
    quantity INT NOT NULL,
    price FLOAT(10),
    CONSTRAINT FK_Cart_User FOREIGN KEY (userId) REFERENCES Users(id),
    CONSTRAINT FK_Cart_Product FOREIGN KEY (pid) REFERENCES Product(id)
);

-- Tạo bảng ProductCart (liên kết nhiều-nhiều giữa Product và Cart)
CREATE TABLE ProductCart (
    pid INT NOT NULL,
    cartId INT NOT NULL,
    CONSTRAINT PK_ProductCart PRIMARY KEY (pid, cartId),
    CONSTRAINT FK_ProductCart_Product FOREIGN KEY (pid) REFERENCES Product(id),
    CONSTRAINT FK_ProductCart_Cart FOREIGN KEY (cartId) REFERENCES Cart(id)
);

-- Tạo bảng Order
CREATE TABLE [Order] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    date DATE NOT NULL,
    status NVARCHAR(500),
    total FLOAT(10) NOT NULL,
    CONSTRAINT FK_Order_User FOREIGN KEY (userId) REFERENCES Users(id)
);

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetail (
    id INT IDENTITY(1,1) PRIMARY KEY,
    oid INT NOT NULL,
    pid INT NOT NULL,
    price FLOAT(10) NOT NULL, -- Changed to FLOAT to be consistent with other price columns
    quantity INT NOT NULL,
    total FLOAT(20) NOT NULL,
    CONSTRAINT FK_OrderDetail_Order FOREIGN KEY (oid) REFERENCES [Order](id),
    CONSTRAINT FK_OrderDetail_Product FOREIGN KEY (pid) REFERENCES Product(id)
);

-- Tạo bảng Payment
CREATE TABLE Payment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    oid INT NOT NULL,
    type INT NOT NULL,
    date DATE NOT NULL,
    amount FLOAT(20) NOT NULL,
    CONSTRAINT FK_Payment_Order FOREIGN KEY (oid) REFERENCES [Order](id)
);

-- Thêm dữ liệu vào bảng Brand
SET IDENTITY_INSERT Brand ON;

INSERT INTO Brand (bid, name) VALUES
(1, 'Apple'),
(2, 'Samsung'),
(3, 'Xiaomi'),
(4, 'OPPO'),
(5, 'ASUS'),
(6, 'Nokia'),
(7, 'Sony'),
(8, 'DELL'),
(9, 'HP'),
(10, 'LG'),
(11, 'Acer');

SET IDENTITY_INSERT Brand OFF;

-- Thêm dữ liệu vào bảng Category
SET IDENTITY_INSERT Category ON;

INSERT INTO Category (cid, name) VALUES
(1, N'Điện Thoại,Tablet'),
(2, N'Laptop'),
(3, N'Đồng hồ'),
(4, N'Phụ kiện');

SET IDENTITY_INSERT Category OFF;

-- Thêm dữ liệu vào bảng Users

INSERT INTO Users (email, pass, fullName, phone, address, roleId, gender, dob)
VALUES 
('hai31082003@gmail.com', '123', 'John Doe', '1234567890', '123 Main St, Anytown, USA', 1, 'male', '1980-01-01'),
('longvupp@gmail.com', '123', 'Jane Smith', '0987654321', '456 Elm St, Othertown, USA', 2, 'male', '1990-02-02'),
('alice.jones@example.com', 'password789', 'Alice Jones', '1231231234', '789 Oak St, Sometown, USA', 3, 'female', '2000-03-03');


-- Thêm dữ liệu vào bảng Product
INSERT INTO Product (bid, cid, name, image, price, description, stock) VALUES

(1, 1, 'iPhone 13', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-13_2_.png', 13390000, N'iPhone 13 có một sự thay đổi lớn về camera so với trên iPhone 12 Series. Cụ thể, iPhone có thể được trang bị ống kính siêu rộng mới giúp máy hiển thị được nhiều chi tiết hơn ở các bức hình thiếu sáng. Trong khi đó ống kính góc rộng có thể thu được nhiều sáng hơn, lên đến 47% giúp chất lượng bức ảnh, video được cải thiện hơn.', 100),
(1, 1, 'iPhone 14', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-14_1.png', 16590000, 'iPhone 14 128GB sở hữu màn hình Retina XDR OLED kích thước 6.1 inch cùng độ sáng vượt trội lên đến 1200 nits. Máy cũng được trang bị camera kép 12 MP phía sau cùng cảm biến điểm ảnh lớn, đạt 1.9 micron giúp cải thiện khả năng chụp thiếu sáng. Mẫu iPhone 14 mới cũng mang trong mình con chip Apple A15 Bionic phiên bản 5 nhân mang lại hiệu suất vượt trội.', 100),
(1, 1, 'iPhone 15', 'https://cellphones.com.vn/iphone-15.html', 22590000, N'iPhone 15 128GB được trang bị màn hình Dynamic Island kích thước 6.1 inch với công nghệ hiển thị Super Retina XDR màn lại trải nghiệm hình ảnh vượt trội. Điện thoại với mặt lưng kính nhám chống bám mồ hôi. Camera trên iPhone 15 series cũng được nâng cấp lên cảm biến 48MP cùng tính năng chụp zoom quang học tới 2x. Cùng với thiết kế cổng sạc thay đổi từ lightning sang USB-C vô cùng ấn tượng.', 100),
(2, 1, 'Samsung Galaxy S24 Ultra', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/s/ss-s24-ultra-xam-222.png', 29990000, N'Samsung S24 Ultra là siêu phẩm smartphone đỉnh cao mở đầu năm 2024 đến từ nhà Samsung với chip Snapdragon 8 Gen 3 For Galaxy mạnh mẽ, công nghệ tương lai Galaxy AI cùng khung viền Titan đẳng cấp hứa hẹn sẽ mang tới nhiều sự thay đổi lớn về mặt thiết kế và cấu hình. SS Galaxy S24 bản Ultra sở hữu màn hình 6.8 inch Dynamic AMOLED 2X tần số quét 120Hz. Máy cũng sở hữu camera chính 200MP, camera zoom quang học 50MP, camera tele 10MP và camera góc siêu rộng 12MP.', 10),
(2, 1, 'Samsung Galaxy S23 Ultra', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-s23-ulatra_2__1.png', 23990000, N'Samsung S23 Ultra là dòng điện thoại cao cấp của Samsung, sở hữu camera độ phân giải 200MP ấn tượng, chip Snapdragon 8 Gen 2 mạnh mẽ, bộ nhớ RAM 8GB mang lại hiệu suất xử lý vượt trội cùng khung viền vuông vức sang trọng. Sản phẩm được ra mắt từ đầu năm 2023.', 100),
(2, 1, 'Samsung Galaxy Z Flip5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-z-lip5_3_.png', 19990000, N'Samsung Galaxy Z Flip 5 có thiết kế màn hình rộng 6.7 inch và độ phân giải Full HD+ (1080 x 2640 Pixels), dung lượng RAM 8GB, bộ nhớ trong 256GB. Màn hình Dynamic AMOLED 2X của điện thoại này hiển thị rõ nét và sắc nét, mang đến trải nghiệm ấn tượng khi sử dụng.', 100),
(3, 1, 'Xiaomi 14', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-pre-xanh-la.png', 19990000, N'Xiaomi 14 5G mang trên mình màn hình OLED 6.36-inch, cùng với bộ vi xử lý Qualcomm Snapdragon 8 Gen 3, làm nên một cấu hình siêu mạnh mẽ cho người dùng. Đi kèm với đó là viên pin dung lượng 4610mAh hỗ trợ tốc độ sạc 90W kết hợp cùng hệ thống ba camera sau với cảm biến chính 50MP, đảm bảo hiệu suất và khả năng chụp ảnh ấn tượng. Đặc biệt hơn, Xiaomi 14 5G không chỉ sẵn sàng cho 5G mà còn hỗ trợ sạc không dây, mang lại sự tiện lợi cao cho người dùng.', 100),
(3, 1, 'Xiaomi 14 Ultra 5G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-ultra_3.png', 29990000, N'Trải nghiệm chụp hình như máy ảnh nhờ 4 camera cao cấp, mãn nhãn với thiết kế thanh lịch cùng các gam màu bắt mắt,ghi điểm mạnh mẽ với màn hình AMOLED đẹp mắt, thẩm mỹ,chip Snapdragon 8 Gen 3 hoạt động mạnh mẽ, pin 5000mAh', 100),
(3, 1, 'Xiaomi 13T Pro 5G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13-pro-thumb-xanh-la9.jpg', 14790000, N'Xiaomi 13T Pro là flagship mới nhất nhà Xiaomi, mạnh mẽ ấn tượng với chip MediaTek Dimensity 9200+, cùng với đó là RAM 12GB và bộ nhớ trong lên tới 512GB. Đặc biệt, khả năng chụp ảnh đỉnh cao nhờ cụm camera siêu chất, viên pin lớn 5000mAh cùng sạc nhanh 120W. Tất cả sẽ mang tới một siêu phẩm đình đám giúp bạn có được trải nghiệm độc đáo và khẳng định được cá tính của mình.', 100),
(4, 1, 'OPPO A78', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a78.png', 6990000, N'Là mẫu điện thoại tầm trung đầu tiên được OPPO ra mắt trong năm 2023, OPPO A78 sở hữu một thiết kế bắt mắt cùng những cải tiến trong hiệu năng với vi xử lý Qualcomm Snapdragon 680 có khả năng hỗ trợ kết nối 4G, 8GB RAM ( mở rộng thêm 8GB), 256GB bộ nhớ và viên pin 5000mAh hỗ trợ công nghệ sạc siêu tốc 67W.', 100),
(4, 1, 'OPPO A17K', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a17k.png', 2790000, N'OPPO A17K có thiết kế màn hình LCD với kích thước 6.56 inch cùng độ phân giải full HD +. Đồng thời so với hệ tiền nhiệm, A17K được nâng cấp với RAM 4GB cùng bộ nhớ trong 64GB giúp người dùng có lưu trữ được nhiều hơn.', 100),
(4, 1, 'OPPO Reno11 F', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-oppo-reno-11-f-2.png', 8490000, N'OPPO Reno11 F 5G cung cấp trải nghiệm hiển thị, xử lý siêu mượt mà với màn hình AMOLED 6.7 inch hiện đại cùng chipset MediaTek Dimensity 7050 mạnh mẽ. Hệ thống quay chụp trên thế hệ Reno11 F 5G này được cải thiện hơn thông qua cụm 3 camera với độ phân giải lần lượt là 64MP, 8MP và 2MP. Ngoài ra, cung cấp năng lượng cho thế hệ OPPO smartphone này là viên pin 5000mAh cùng sạc nhanh 67W, mang tới trải nghiệm liền mạch suốt ngày dài.', 100),
(5, 1, 'ASUS ROG Phone 7 Ultimate', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_365.jpg', 26190000, N'Asus ROG phone 7 Ultimate 16GB 512GB sở hữu con chip Snapdragon 8 Gen 2 với sức mạnh siêu khủng đến từ nhà Qualcomm. Màn hình được làm từ màn amoled có kích thước khủng tận 6.78 inch cho chất lượng hình ảnh Full HD Plus. Camera siêu xịn với độ phân giải lên đến 50MP đi kèm viên pin dung lượng vô đối 6000mAh và chế độ sạc HyperCharge 65W.', 100),
(6, 1, 'Nokia 215', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-215-4g-600jpg-600x600.jpg', 980000, N'Với nhiều người dùng thích sự nhỏ gọn của các thiết kế dòng điện thoại phổ thông của Nokia, việc trang bị cho mình một chiếc Nokia 215 4G là một sự lựa chọn phù hợp với đầy đủ các tính năng và còn thêm cả khả năng có thể truy cập internet mang đến cho người dùng trải nghiệm hoàn toàn mới.', 100),
(6, 1, 'Nokia 3210 4G', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-3210-4g.png', 1550000, N'Nokia 3210 4G là một trong những sản phẩm điện thoại phổ thông phù hợp với những ai yêu thích sự đơn giản, hoài cổ và cần một chiếc điện thoại phụ để liên lạc, giải trí cơ bản. Với thiết kế ấn tượng cùng tính năng đa dạng, chắc chắn khi sở hữu và sử dụng bạn sẽ cảm nhận được sự thuận tiện.', 100),
(6, 1, 'Nokia 110 4G Pro', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/n/o/nokia-110-4g-pro_1__1.png', 710000, N'Nổi bật với thiết kế mới mẻ kết hợp với nhiều thông số kỹ thuật ấn tượng, Nokia 110 4G Pro được đánh giá là vượt trội hơn hẳn so với các dòng điện thoại phổ thông cùng phân khúc khác. Máy sở hữu kết nối 4G ổn định cùng dung lượng pin lớn, giúp bạn thoải mái trải nghiệm Internet nhanh chóng, thuận thiện mọi lúc, mọi nơi. Nếu bạn đang tìm kiếm một mẫu điện thoại đơn giản, đáng tin cậy thì Nokia 110 Pro 4G sẽ là gợi ý không nên bỏ qua nhé!', 100),


(1, 2, 'Macbook Pro 14 M3 Pro', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/g/p/gpu.png', 48990000, N'Macbook Pro M3 Pro bản 14 inch 18GB/512GB có khả năng lý đồ họa chuyên sâu, kết cấu 3D một cách ổn định và mượt mà. Bên cạnh đó, sản phẩm có chất lượng hiển thị rất sắc nét, và tần số quét lên tới 120Hz, giúp người dùng làm việc hiệu quả, nhanh chóng.', 100),
(1, 2, 'Apple Macbook Air M2 2022', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/m/a/macbook_air_m2_1_1.png', 23890000, N'Macbook Air M2 2022 với thiết kế sang trọng, vẻ ngoài siêu mỏng đầy lịch lãm. Mẫu Macbook Air mới với những nâng cấp về thiết kế và cấu hình cùng giá bán phải chăng, đây sẽ là một thiết bị lý tưởng cho công việc và giải trí.', 100),
(1, 2, 'Apple MacBook Air M1 256GB 2020', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/i/air_m2.png', 18690000, N'Macbook Air M1 là dòng sản phẩm có thiết kế mỏng nhẹ, sang trọng và tinh tế cùng với đó là giá thành phải chăng nên MacBook Air đã thu hút được đông đảo người dùng yêu thích và lựa chọn. Đây cũng là một trong những phiên bản Macbook Air mới nhất mà khách hàng không thể bỏ qua khi đến với HoLaTech.', 100),
(5, 2, 'Laptop ASUS TUF Gaming F15 FX506HF-HN078W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_13__5_14.png', 17290000, N'Laptop Asus Tuf Gaming F15 FX506HF-HN078W với thiết kế năng động, mang vẻ đẹp thu hút với CPU core intel i5, GPU GeForce RTX™ 2050 và RAM 8 GB. Kết hợp là màn hiển thị FHD IPS 144Hz cực kỳ rõ nét. Ngoài ra laptop Asus Gaming cũng có thêm hệ thống âm thanh đỉnh cao nhờ vào công nghệ tiên tiến để phục vụ tối đa người dùng.', 100),
(5, 2, 'Laptop ASUS ROG Strix G16 G614JU-N3135W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_20__1_21.png', 31490000, N'Laptop Asus ROG Strix G16 G614JU-N3135W trang bị cho mình một bộ vi xử lý Intel Core i5 thế hệ 13 mới nhất cho phép máy vận hành mượt mà mọi tác vụ. Tốc độ xử lý lên đến 4.6GHz giúp tăng hiệu suất, giảm thời gian xử lý và cho bạn trải nghiệm tuyệt vời ở các tựa game nặng hay trình thiết kế đồ họa nhiều chi tiết.', 100),
(5, 2, 'Laptop ASUS TUF Gaming F15 FX507VV-LP157W', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_14__4_8.png', 29990000, N'Laptop ASUS TUF Gaming F15 FX507VV-LP157W là một chiếc laptop chơi game tầm trung được trang bị bộ vi xử lý Intel Core i7-13620H và card đồ họa RTX 4060 8GB GDDR6. Màn hình 15,6 inch Full HD có tần số quét 144Hz cho trải nghiệm chơi game mượt mà và sắc nét. Laptop được trang bị hệ thống tản nhiệt Arc Flow Fans giúp duy trì hiệu năng ổn định trong thời gian dài.', 100),
(8, 2, 'Laptop Dell Vostro 3520 F0V0VI3', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-dell-vostro-3520-f0v0vi3-thumbnails.png', 9690000, N'Laptop Dell Vostro 3520 F0V0VI3 sử dụng bị bộ vi xử lý Intel Core i3 - 1215U kết hợp với RAM dung lượng 8GB cho khả năng xử lý công việc hàng ngày hiệu quả. Máy được trang bị ổ cứng SSD PCIe tốc độ cao với dung lượng 512GB giúp bạn truy cập và tải thông tin nhanh chóng. Màn hình full HD kích thước 15.6 inch mang đến những khung hình mượt mà và sắc nét. Máy có các cổng giao tiếp thông dụng để bạn dễ dàng chia sẻ dữ liệu. ', 100),
(8, 2, 'Laptop Dell Vostro 3520 GD02R', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_6__152.png', 12490000, N'Dell Vostro 3520 GD02R có thể được coi là dòng laptop Dell Vostro được ưa chuộng bởi những người dùng văn phòng nhờ vào hiệu năng ổn định cũng như màn hình sống động vừa đáp ứng tốt cho cả nhu cầu làm việc cũng như giải trí hằng ngày.', 100),
(8, 2, 'Laptop Dell Vostro 3520', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop_dell_vostro_3520i7.png', 18490000, N'Laptop Dell Vostro 3520 là một trong những sản phẩm laptop Dell Vostro đáng chú ý của thương hiệu Dell, được thiết kế để đáp ứng nhu cầu làm việc và giải trí của người dùng hiện đại. Với thiết kế nhỏ gọn, hiệu năng mạnh mẽ và tính năng bảo mật ấn tượng, sản phẩm này sẽ là một trợ thủ đắc lực cho công việc và giải trí hàng ngày của bạn.', 100),
(11, 2, 'Laptop Gaming Acer Nitro V ANV15-51-55CA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-gaming-acer-nitro-v-anv15-51-55ca.jpg', 26990000, N'Laptop Gaming Nitro V ANV15-51-55CA đem lại trải nghiệm gaming mạnh mẽ với bộ vi xử lý Intel Gen 13 i5-13420H, cùng card đồ họa rời NVIDIA RTX 4050. Ngoài ra, ấn phẩm laptop Acer gaming này cũng được trang bị 16GB RAM DDR5, cung cấp khả năng xử lý đa nhiệm mượt mà, và bộ nhớ SSD 512GB, đảm bảo tốc độ truy xuất dữ liệu siêu nhanh chóng. Cùng với đó là kích thước màn hình 15,6 inch, tần số quét 144Hz giúp tối ưu hóa trải nghiệm hình ảnh sắc nét và mượt mà cho game thủ.', 100),
(11, 2, 'Laptop Acer Swift Go 14 AI SFG14-73-71ZX NX.KSLSV.002', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-acer-swift-go-14-ai-sfg14-73-71zx.png', 26490000, N'Laptop Acer Swift Go 14 AI SFG14-73-71ZX tự hào là một trong những chiếc laptop xách tay tích hợp hiệu quả công nghệ trí tuệ nhân tạo. Kết hợp với con chip Intel Core cùng card đồ họa Intel Arc Graphics, mẫu laptop Acer Swift này cho hiệu suất nhanh nhất có thể.', 100),
(11, 2, 'Laptop Acer Aspire 3 A315-59-381E', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-acer-aspire-3-a315-59-381e-thumbnails.png', 9790000, N'Laptop Acer Aspire 3 A315-59-381E mang đến một diện mạo thanh lịch với cấu hình ổn định trong phân khúc tầm trung. Với CPU Intel Core i3-1215U và ổ cứng SSD dung lượng 512GB, máy đáp ứng được nhu cầu làm việc hàng ngày và giải trí đa dạng của người dùng.', 100),
(11, 2, 'Laptop Acer Gaming Aspire 7 A715-76-53PJ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_7__1_12.png', 14990000, N'Laptop Acer Gaming Aspire 7 A715-76-53PJ là chiếc laptop sở hữu cấu hình mạnh với bộ vi xử lý Intel Core thế hệ 12 và card đồ họa Intel UHD Graphics. Máy có màn hình 15.6 inch, độ phân giải Full HD (1920 x 1080), bộ nhớ RAM 16GB DDR4 và dung lượng lưu trữ SSD 512GB. Ngoài ra, máy còn được trang bị các cổng kết nối như HDMI, USB Type-C, USB 3.2 Gen 1 Type-A, RJ-45 và có khả năng chơi game tốt.', 100),
(10, 2, 'Laptop LG Gram 2023 17Z90R-G.AH78A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_d_i_10_.png', 38990000, N'Laptop LG Gram 2023 17Z90R-G.AH78A5 là dòng laptop siêu mỏng nhẹ của LG sở hữu một cấu hình ổn định rất thích hợp với người dùng văn phòng. Mẫu laptop LG Gram 2023 này gây ấn tượng với người dùng về khả năng hiển thị, hiệu năng sử dụng.', 100),
(10, 2, 'Laptop LG Gram 2023 14Z90RS-G.AH54A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/4/14z90rs-ah54a5.png', 28490000, N'Laptop LG Gram 2023 14Z90RS-G.AH54A5 là một dòng máy tính xách tay nhẹ và mạnh mẽ được phát hành vào năm 2023. Thông qua nhiều đặc điểm nổi bật, phiên bản laptop LG Gram 2023 này hứa hẹn sẽ mang đến những giây phút làm việc và giải trí tuyệt vời dành cho bạn.', 100),
(10, 2, 'Laptop LG Gram 2023 15Z90RT-G.AH55A5', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_5__2_1.png', 31990000, N'Laptop LG Gram 2023 15Z90RT-G.AH55A5 sở hữu kiểu dáng mỏng nhẹ đặc trưng, màn hình lớn, đem lại hình ảnh sống động. Chiếc laptop LG 2023 có hiệu năng ở mức ổn định, giúp bạn đa nhiệm tốt và giải quyết được nhanh các tác vụ từ văn phòng cơ bản đến nâng cao. ', 100),
(9, 2, 'Laptop HP 15 250 G8 85C69EA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_6_3.png', 11990000, N'Laptop HP 15 250 G8 85C69EA là dòng máy được làm gọn nhẹ cho tính di động cao, phù hợp dùng được ở mọi nơi. Hiệu suất của máy được duy trì ổn định nhờ vào cấu hình tầm trung cùng thời lượng pin tốt để bạn hoàn thành nhanh chóng mọi tác vụ.', 100),
(9, 2, 'Laptop HP Elitebook 630 G9 6M142PA', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_14__1_65.png', 16990000, N'Laptop HP Elitebook 630 G9 6M142PA được giới doanh nhân ưu ái lựa chọn với những đặc điểm vượt bậc. Thông qua loạt công nghệ hiện đại cùng bộ vi xử lý i5 thế hệ 12, phiên bản laptop HP này chắc chắn sẽ giúp bạn hoàn thành công việc một cách hiệu quả và nhanh chóng.', 100),
(9, 2, 'Laptop HP Pavilion 15-EG3093TU 8C5L4PA', 'https://cellphones.com.vn/laptop-hp-14-ep0112tu-8c5l1pa.html', 16990000, N'Laptop HP Pavilion 15-EG3093TU 8C5L4PA đi cùng bộ vi xử lý CPU Gen 13 và bộ nhớ RAM 16 GB chuẩn DDR4 mang đến khả năng xử lý vô cùng nhanh chóng. Màn hình rộng 15.6 inch Full HD trên máy cung cấp hình ảnh sắc nét và màu sắc chân thực. Hơn nữa, ổ cứng sản phẩm laptop HP Pavilion giúp lưu trữ dữ liệu một cách hiệu quả và tối ưu hóa tốc độ làm việc.', 100),

(1, 3, 'Apple Watch SE 2 2023 40mm', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple-watch-se-2023-40mm.png', 5790000, N'Apple Watch SE 2023 40mm (GPS) không chỉ là một sản phẩm đồng hồ xem giờ, nó còn tích hợp rất nhiều tính năng theo dõi sức khỏe, luyện tập thông minh. Với thiết kế vô cùng sang trọng như màn hình Retina, khung viền nhôm cùng kính cường lực chắc chắn.', 100),
(1, 3, 'Apple Watch Series 9 45mm', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_lte_3__1.png', 10690000, N'Đồng hồ Apple Watch Series 9 45mm sở hữu on chip S9 SiP - CPU với 5,6 tỷ bóng bán dẫn giúp mang lại hiệu năng cải thiện hơn 60% so với thế hệ S8. Màn hình thiết bị với kích thước 45mm cùng độ sáng tối đa lên 2000 nit mang lại trải nghiệm hiển thị vượt trội. Cùng với đó, đồng hồ Apple Watch s9 này còn được trang bị nhiều tính năng hỗ trợ theo dõi sức khỏe và tập luyện thông minh.', 100),
(1, 3, 'Apple Watch Ultra 2 49mm ', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/a/p/apple_watch_ultra_2.png', 20990000, N'Đồng hồ Apple Watch Ultra 2 sở hữu khung viền titan sang trọng cùng con chip S9 SiP thế hệ mới mang lại một trải nghiệm dùng ổn định và mượt mà. Đồng hồ với ba phiên bản dây đeo thì hợp cho từng nhu cầu sử dụng khác nhau của người dùng.', 100),
(2, 3, 'Đồng hồ Samsung Galaxy Fit 3', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung_3.png', 1290000, N'Đồng hồ Samsung Galaxy Fit 3 thiết kế thanh mảnh, gọn gàng, màn hình AMOLED 1.6 inch, trọng lượng chỉ 36.8g, kháng nước 5ATM và bụi IP68 cùng viên pin 208mAh kéo dài dến 13 ngày ấn tượng tích hợp sạc không dây.', 100);

-- Thêm dữ liệu vào bảng Feedback
INSERT INTO Feedback (userId, pid, comment, rate) VALUES
(1, 1, 'Great phone!', 5),
(2, 2, 'Good value for money.', 4);

-- Thêm dữ liệu vào bảng Cart
INSERT INTO Cart (userId, pid, quantity, price) VALUES
(1, 1, 1, 13390000),
(2, 2, 2, 16590000);

-- Thêm dữ liệu vào bảng ProductCart
INSERT INTO ProductCart (pid, cartId) VALUES
(1, 1),
(2, 2);

-- Thêm dữ liệu vào bảng Order
INSERT INTO [Order] (userId, date, status, total) VALUES
(1, '2024-06-01', 'Delivered', 13390000),
(2, '2024-06-02', 'Processing', 33180000);

-- Thêm dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (oid, pid, price, quantity, total) VALUES
(1, 1, 13390000, 1, 13390000),
(2, 2, 16590000, 2, 33180000);

-- Thêm dữ liệu vào bảng Payment
INSERT INTO Payment (oid, type, date, amount) VALUES
(1, 1, '2024-06-01', 13390000),
(2, 2, '2024-06-02', 33180000);