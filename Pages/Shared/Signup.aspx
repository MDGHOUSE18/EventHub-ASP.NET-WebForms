<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="EventHub.Pages.Shared.Signup"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>SignUp</title>
    <link rel="stylesheet" href="~/styles/styles.css" />
    <script>
        function ShowPassword(checkBox) {
            var PasswordTextBox = document.getElementById('PassTextBox');
            if (checkBox.checked == true) {
                PasswordTextBox.setAttribute("type", "text");
            } else {
                PasswordTextBox.setAttribute("type", "password");
            }
        }
    </script>
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
                <span class="small-text"><input type="checkbox" onclick="ShowPassword(this)" /> Show Password</span>
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
    <script src="~/script/custom.js"></script>
</body>
</html>
