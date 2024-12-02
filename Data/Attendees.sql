use EventHub;


CREATE TABLE Attendees (
    AttendeeID INT IDENTITY(1,1) PRIMARY KEY,        -- Unique identifier for the attendee
    EventID INT,                                     -- Foreign key linking to the Events table
    UserID INT,                                      -- Foreign key linking to the Users table (assuming you have a Users table)
    RegisteredAt DATETIME DEFAULT GETDATE(),          -- Date and time when the user registered for the event
    FOREIGN KEY (EventID) REFERENCES Events(EventID),-- Foreign key relationship with the Events table
    FOREIGN KEY (UserID) REFERENCES Users(UserID)    -- Foreign key relationship with the Users table
);

-- User 2 registrations
INSERT INTO Attendees (UserID, EventID) VALUES (2, 1);
INSERT INTO Attendees (UserID, EventID) VALUES (2, 2);
INSERT INTO Attendees (UserID, EventID) VALUES (2, 3);
INSERT INTO Attendees (UserID, EventID) VALUES (2, 4);
INSERT INTO Attendees (UserID, EventID) VALUES (2, 5);

-- User 3 registrations
INSERT INTO Attendees (UserID, EventID) VALUES (3, 6);
INSERT INTO Attendees (UserID, EventID) VALUES (3, 7);
INSERT INTO Attendees (UserID, EventID) VALUES (3, 8);
INSERT INTO Attendees (UserID, EventID) VALUES (3, 9);
INSERT INTO Attendees (UserID, EventID) VALUES (3, 10);

-- User 4 registrations
INSERT INTO Attendees (UserID, EventID) VALUES (4, 2);
INSERT INTO Attendees (UserID, EventID) VALUES (4, 4);
INSERT INTO Attendees (UserID, EventID) VALUES (4, 6);
INSERT INTO Attendees (UserID, EventID) VALUES (4, 8);
INSERT INTO Attendees (UserID, EventID) VALUES (4, 10);


-- User 5 registrations
INSERT INTO Attendees (UserID, EventID) VALUES (5, 1);
INSERT INTO Attendees (UserID, EventID) VALUES (5, 3);
INSERT INTO Attendees (UserID, EventID) VALUES (5, 5);
INSERT INTO Attendees (UserID, EventID) VALUES (5, 7);
INSERT INTO Attendees (UserID, EventID) VALUES (5, 9);


SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Attendees;



CREATE OR ALTER PROCEDURE GetAttendess
AS
BEGIN
	SELECT e.EventName,e.EventDate,u.FullName,u.Email,u.Role  FROM Users u
	INNER JOIN Attendees a ON u.userId=a.UserId
	INNER JOIN Events e ON e.EventID=a.EventID
	ORDER BY e.EventDate ASC;
END;

CREATE OR ALTER PROCEDURE GetTotalAttendessCount
AS
BEGIN
	SELECT Count(*) AS TotalAttendess FROM Attendees;
END;

CREATE OR ALTER PROCEDURE GetAttendessOfEachEvent
AS
BEGIN
	SELECT e.EventName,e.EventDate,u.FullName,u.Email,u.Role  FROM Users u
	INNER JOIN Events e ON e.EventID=a.EventID
	ORDER BY e.EventDate ASC;
END;

CREATE OR ALTER PROCEDURE GetAttendeesCountForEachEvent
AS
BEGIN
    SELECT 
        e.EventName,
        e.EventDate,
        COUNT(a.UserID) AS AttendeeCount
    FROM 
        Events e
    LEFT JOIN 
        Attendees a ON e.EventID = a.EventID
    GROUP BY 
        e.EventName, e.EventDate
    ORDER BY 
        e.EventDate ASC;
END;

CREATE OR ALTER PROCEDURE GetSummary
AS
BEGIN
	SELECT 
		(SELECT COUNT(DISTINCT a.AttendeeID) FROM Attendees a) AS RegisteredUsers,
		(SELECT COUNT(EventID) FROM Events) AS TotalEvents,
		(SELECT COUNT(UserID) FROM Users) AS TotalUsers;
END;

CREATE OR ALTER PROCEDURE RegisterEvent
	@EventId int,
	@UserId int
AS
BEGIN
	INSERT INTO Attendees(EventID,UserID)
	Values(@EventId,@UserId);
END;

CREATE OR ALTER PROCEDURE UnRegisterEvent
    @EventId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Delete the registration entry from the Attendees table to unregister the user from the event
    DELETE FROM Attendees
    WHERE EventID = @EventId AND UserID = @UserId;
END;



CREATE OR ALTER PROCEDURE CheckUserRegistration
    @UserID INT,
    @EventID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Attendees WHERE UserID = @UserID AND EventID = @EventID)
    BEGIN
        SELECT 1  -- User is registered
    END
    ELSE
    BEGIN
        SELECT 0  -- User is not registered
    END
END



CREATE PROCEDURE GetEventsWithPagination
    @StartIndex INT,
    @EndIndex INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY EventDate DESC) AS RowNum, *
        FROM Events
    ) AS RowConstrainedResult
    WHERE RowNum > @StartIndex AND RowNum <= @EndIndex
    ORDER BY RowNum;
END;

CREATE PROCEDURE MyEventsWithPagination
    @UserId INT,
	@StartIndex INT,
    @EndIndex INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY e.EventDate DESC) AS RowNum, e.*
    FROM Events e
    INNER JOIN Attendees a ON e.EventID = a.EventID
    WHERE a.UserID = @UserId
	) AS RowConstrainedResult
	WHERE RowNum > @StartIndex AND RowNum <= @EndIndex
	ORDER BY RowNum;
END;


