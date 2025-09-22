
-- 사용자 생성 (비밀번호는 원하는 걸로 바꾸세요)
CREATE USER 'user_name'@'localhost' IDENTIFIED BY 'password';

-- 데이터베이스 생성
CREATE DATABASE database_name CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 사용자에게 DB 전체 권한 부여
GRANT ALL PRIVILEGES ON database_name.* TO 'user_name'@'localhost';

-- 권한 적용
FLUSH PRIVILEGES;
CREATE TABLE users (
    email VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    nickname VARCHAR(100) NOT NULL DEFAULT '익명',
    profile_image_url TEXT DEFAULT 'https://yourdomain.com/default-profile.png',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

