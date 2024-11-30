# Online Event Registration System

## Description
The Online Event Registration System is a web application built using ASP.NET WebForms that allows users to browse, register for, and manage events. The application consists of two main modules: the **User Module** for attendees and the **Admin Module** for event organizers. Users can register, browse, and manage their event registrations, while admins can manage events and users.

## Features

### User Module:
- **Registration/Login**: Users can register and log in with email and password.
- **Event Browsing**: Users can view upcoming events with details like name, date, venue, and description.
- **Event Registration**: Users can register for events and view a list of their registrations.
- **Profile Management**: Users can update personal details like name, email, and contact information.

### Admin Module:
- **Event Management**: Admins can add, update, or delete events and view a list of attendees for each event.
- **User Management**: Admins can view details of all registered users.

### General Features:
- **Responsive Design**: Ensures a user-friendly experience across all devices.
- **Search and Filter**: Users can search and filter events by name, date, and location.
- **Error Handling**: Displays error messages for invalid actions such as duplicate registrations.
- **Data Validation**: Validates user inputs on both client and server sides.

## Technical Requirements

### Frontend:
- ASP.NET WebForms for UI components.
- HTML, CSS, Bootstrap for responsive design.
- JavaScript or AJAX for dynamic interactions.

### Backend:
- ASP.NET with C# for business logic.
- ADO.NET for database connectivity.

### Database:
- SQL Server to store user data, event details, and registration records.

### Additional Features:
- **ViewState** for managing data across postbacks.
- **Session** for user login management.
- **GridView** and **DataList** controls to display events and users.

## Learning Outcomes:
- Understanding the basics of ASP.NET WebForms.
- Practicing CRUD operations with ADO.NET.
- Learning user session management and authentication.
- Gaining experience in building a dynamic, data-driven web application.

## Installation:
1. Clone the repository.
2. Open the solution in Visual Studio.
3. Configure the SQL Server database connection.
4. Run the application.

## License:
This project is licensed under the MIT License.
