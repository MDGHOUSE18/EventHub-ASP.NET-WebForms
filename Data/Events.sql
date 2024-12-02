use EventHub;

CREATE TABLE Events (
    EventID INT IDENTITY(1,1) PRIMARY KEY,           -- Unique identifier for each event
    EventName NVARCHAR(255) NOT NULL,                 -- Name of the event
    EventDate DATETIME NOT NULL,                      -- Date and time of the event
    Description NVARCHAR(MAX),                        -- Description of the event
    Location NVARCHAR(255),                           -- Location of the event
	Images NVARCHAR(MAX),                   -- Link to images or image file paths
    CreatedAt DATETIME DEFAULT GETDATE(),             -- Date and time when the event was created
    UpdatedAt DATETIME DEFAULT GETDATE()              -- Date and time when the event was last updated
);





-- Insert 10 Real-time Events in India

INSERT INTO Events (EventName, EventDate, Description, Location) VALUES
('Tech Conference 2024', '2024-12-01', 'A gathering of the brightest minds in technology, showcasing the latest innovations and trends.', 'Bengaluru, Karnataka'),
('Delhi Music Festival', '2024-12-05', 'A grand musical event featuring famous Indian and international artists performing live.', 'New Delhi, Delhi'),
('Mumbai Marathon 2024', '2024-12-07', 'An annual marathon attracting thousands of runners from across the globe for a charity cause.', 'Mumbai, Maharashtra'),
('Startup Expo 2024', '2024-12-10', 'A business and networking event for startups to meet investors and showcase their products.', 'Hyderabad, Telangana'),
('National Food Festival', '2024-12-12', 'A celebration of India’s diverse culinary heritage with food stalls, live cooking shows, and more.', 'Chennai, Tamil Nadu'),
('Pune International Film Festival', '2024-12-15', 'A celebration of world cinema with screenings, panel discussions, and awards.', 'Pune, Maharashtra'),
('Goa Beach Party', '2024-12-20', 'A vibrant and lively beach party with DJ performances and beach activities.', 'Goa, Goa'),
('Kolkata Art Exhibition', '2024-12-25', 'An exhibition showcasing works of renowned artists, with interactive art sessions and workshops.', 'Kolkata, West Bengal'),
('Jaipur Literature Festival', '2024-12-30', 'India’s largest literature festival, attracting authors, poets, and thinkers from around the world.', 'Jaipur, Rajasthan'),
('Varanasi Spiritual Retreat', '2024-12-01', 'A serene and spiritual retreat offering yoga, meditation, and spiritual teachings on the banks of the Ganges.', 'Varanasi, Uttar Pradesh');
EXEC GetEvent 1;

CREATE OR ALTER PROCEDURE GetEvent
	@EventID INT
AS
BEGIN
    SELECT * FROM Events
	WHERE EventID = @EventID;
END;
CREATE OR ALTER PROCEDURE GetAllEvents
AS
BEGIN
    SELECT EventID, EventName, EventDate, Description, Location,Images
    FROM Events;
END

CREATE PROCEDURE DeleteEvent
    @EventID INT
AS
BEGIN
    DELETE FROM Events
    WHERE EventID = @EventID;
END
--For Updating Modal
CREATE OR ALTER PROCEDURE GetEventByID
    @EventID INT
AS
BEGIN
    SELECT 
        EventID, 
        EventName, 
        EventDate, 
        Description, 
        Location,
        Images -- Assuming the image is stored as VARBINARY
    FROM Events
    WHERE EventID = @EventID
END

CREATE OR ALTER PROCEDURE UpdateEvent
    @EventID INT,
    @EventName NVARCHAR(255),
    @EventDate DATETIME,
    @Description NVARCHAR(MAX),
    @Location NVARCHAR(255),
	@EventImage  NVARCHAR(MAX)
AS
BEGIN
    UPDATE Events
    SET 
        EventName = @EventName,
        EventDate = @EventDate,
        Description = @Description,
        Location = @Location,
		Images=@EventImage
    WHERE 
        EventID = @EventID;
END

CREATE OR ALTER PROCEDURE UpdateEvent
    @EventID INT,
    @EventName NVARCHAR(255),
    @EventDate DATETIME,
    @Description NVARCHAR(1000),
    @Location NVARCHAR(255)
AS
BEGIN
    -- Check if the event exists
    IF EXISTS (SELECT 1 FROM Events WHERE EventID = @EventID)
    BEGIN
        -- Update the event details
        UPDATE Events
        SET EventName = @EventName,
            EventDate = @EventDate,
            Description = @Description,
            Location = @Location
        WHERE EventID = @EventID;
        
        -- Return success result
        RETURN 1;
    END
    ELSE
    BEGIN
        -- Return failure if event not found
        RETURN 0;
    END
END


CREATE PROCEDURE DeleteEvent
    @EventID INT
AS
BEGIN
    DELETE FROM Events
    WHERE EventID = @EventID;
END

CREATE PROCEDURE AddEvent
    @EventName NVARCHAR(100),
    @EventDate DATETIME,
    @Description NVARCHAR(500),
    @Location NVARCHAR(200),
    @EventImage NVARCHAR(255)
AS
BEGIN
    INSERT INTO Events (EventName, EventDate, Description, Location, Images)
    VALUES (@EventName, @EventDate, @Description, @Location, @EventImage)
END


SELECT * FROM dbo.Events;


CREATE PROCEDURE GetAllEventsBYSort
    @SortExpression NVARCHAR(100),
    @SortDirection NVARCHAR(4)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX)

    SET @sql = 'SELECT * FROM Events ORDER BY ' + @SortExpression + ' ' + @SortDirection
    EXEC sp_executesql @sql
END


CREATE PROCEDURE GetAllEventsWithPagination
(
    @PageIndex INT,
    @PageSize INT
)
AS
BEGIN
    SELECT * FROM Events
    ORDER BY EventDate
    OFFSET @PageIndex * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END

