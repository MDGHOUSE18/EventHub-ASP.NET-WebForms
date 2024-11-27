<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="EventHub.Pages.Shared.Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }

        .signup-container {
            background: #fff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h1 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }
        .event-title {
            font-family: 'Dancing Script', cursive; /* Apply the curly calligraphy font */
            font-size: 3em;
            color: black; /* Black color for the text */
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 3px;
            padding: 20px;
            background: transparent;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            /*margin-top: 30px;
            margin-bottom:10px;*/
            margin: 30px auto;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 4px rgba(0, 123, 255, 0.5);
        }

        .error-message {
            color: #d9534f;
            font-size: 12px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .bottom-text {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            color: #555;
        }

        .bottom-text a {
            color: #007bff;
            text-decoration: none;
        }

        .bottom-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <h1 class="event-title">EventHub</h1>
            <h1>Sign Up</h1>
            <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorFullName" runat="server" ControlToValidate="FullNameTextBox" Display="Dynamic" ErrorMessage="Please enter your full name" CssClass="error-message"></asp:RequiredFieldValidator>
                <label for="FullNameTextBox">Full Name</label>
                <asp:TextBox ID="FullNameTextBox" runat="server" placeholder="Enter your full name"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserTextBox" Display="Dynamic" ErrorMessage="Please enter your email" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="UserTextBox" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" Display="Dynamic" ErrorMessage="Please enter a valid email" ForeColor="Red" CssClass="error-message"></asp:RegularExpressionValidator>
                <label for="UserTextBox">Email (Username)</label>
                <asp:TextBox ID="UserTextBox" runat="server" placeholder="Enter your email" ></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PassTextBox" Display="Dynamic" ErrorMessage="Please enter a password" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="PasswordValidator" runat="server" ControlToValidate="PassTextBox" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" Display="Dynamic" ErrorMessage="Password must be at least 8 characters long and contain both letters and numbers" ForeColor="Red" CssClass="error-message"></asp:RegularExpressionValidator>
                <label for="PassTextBox">Password</label>
                <asp:TextBox ID="PassTextBox" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            </div>

            <div>
                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ConfirmPassTextBox" Display="Dynamic" ErrorMessage="Please confirm your password" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="ComparePasswordValidator" runat="server" ControlToValidate="ConfirmPassTextBox" ControlToCompare="PassTextBox" Display="Dynamic" ErrorMessage="Passwords do not match" ForeColor="Red" CssClass="error-message"></asp:CompareValidator>
                <label for="ConfirmPassTextBox">Confirm Password</label>
                <asp:TextBox ID="ConfirmPassTextBox" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
            </div>
            <asp:Button ID="Register" runat="server" OnClick="Register_Click" Text="Sign Up" CssClass="btn" />
            <div class="bottom-text">
                Already have an account? 
                <asp:HyperLink ID="LoginHere" runat="server" NavigateUrl="~/Pages/Shared/Signin.aspx">Login here</asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>
