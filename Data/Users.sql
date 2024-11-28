CREATE DATABASE EventHub;

use EventHub;

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT 'User',
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME NULL,
    IsActive BIT NOT NULL DEFAULT 0
);

CREATE OR ALTER PROCEDURE GetUsers
AS
BEGIN
	SELECT * FROM Users;
END;

CREATE OR ALTER PROCEDURE GetUser
@id int
AS
BEGIN
	SELECT * FROM Users
	WHERE UserID=@id;
END;

CREATE OR ALTER PROCEDURE GetUserByEmail
@email NVARCHAR(100)
AS
BEGIN
	SELECT * FROM Users
	WHERE Email=@email;
END;

CREATE OR ALTER PROCEDURE Register
@name NVARCHAR(100),
@email NVARCHAR(100),
@password NVARCHAR(255)
AS
BEGIN
	INSERT INTO Users(FullName,Email,PasswordHash)
	VALUES(@name,@email,@password);
END;

--CREATE OR ALTER PROCEDURE Login
--@email NVARCHAR(100),
--@password NVARCHAR(255)
--AS
--BEGIN
--	-- Declare variables
--    DECLARE @UserId INT;
--	DECLARE @Result INT;

--	SELECT @UserId = UserId
--    FROM Users
--    WHERE Email = @Email AND PasswordHash=@password;

--	IF @UserId IS NOT NULL
--	BEGIN
--		UPDATE Users
--		SET LastLogin=GETDATE(), IsActive=1
--		WHERE UserID=@UserId;
--		SET @Result = 1;
--	END;
--	ELSE
--    BEGIN
--        SET @Result = 0; 
--    END

--    SELECT @Result AS LoginResult;
--END;

CREATE OR ALTER PROCEDURE Login
    @Email NVARCHAR(100),
    @Password NVARCHAR(255)
AS
BEGIN
    -- Declare variable for UserId
    DECLARE @UserId INT;

    -- Check if the user exists and get the UserId
    SELECT @UserId = UserId
    FROM Users
    WHERE Email = @Email AND PasswordHash = @Password;

    -- If the user exists, update LastLogin and IsActive, then return user details
    IF @UserId IS NOT NULL
    BEGIN
        -- Update LastLogin and IsActive fields
        UPDATE Users
        SET LastLogin = GETDATE(), IsActive = 1
        WHERE UserID = @UserId;

        -- Return the Email, Name, and Role of the user
        SELECT Email, FullName, Role
        FROM Users
        WHERE UserId = @UserId;
    END
    ELSE
    BEGIN
        -- If the user does not exist, return NULL values for the fields
        SELECT NULL AS Email, NULL AS Name, NULL AS Role;
    END
END;


EXEC GetUserByEmail 'ghouse@gmail.com';

EXEC Login 'ghouse@gmail.com','095a6369a0958ff1e596b4974550f109f00cb8cc2e35caf852692cd688073b1f';

SELECT * FROM Users WHERE Email='ghouse@gmail.com' AND PasswordHash='095a6369a0958ff1e596b4974550f109f00cb8cc2e35caf852692cd688073b1f'