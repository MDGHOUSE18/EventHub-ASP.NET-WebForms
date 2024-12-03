<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signin.aspx.cs" Inherits="EventHub.Pages.Shared.Signin"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>SignIn</title>
    <link rel="stylesheet" href="~/styles/styles.css" /> 
    <script type="text/javascript">
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
        <div class="login-container">
            <h1 class="event-title">EventHub</h1>
            <h1>Login</h1>
            <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserTextBox" Display="Dynamic" ErrorMessage="Please enter your email" CssClass="error-message"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="UserTextBox" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" Display="Dynamic" ErrorMessage="Please enter a valid email" ForeColor="Red" CssClass="error-message"></asp:RegularExpressionValidator>
                <label for="UserTextBox">Username</label>
                <asp:TextBox ID="UserTextBox" runat="server" placeholder="Enter your email" ></asp:TextBox>
            </div>
            <div>
                
                    <label for="PassTextBox" style="display: inline;">Password</label>
                    <span class="small-text" style="margin-left: 170px;"><input type="checkbox" onclick="ShowPassword(this)" /> Show Password</span>
                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PassTextBox" Display="Dynamic" ErrorMessage="Please enter a password" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:TextBox ID="PassTextBox" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            </div>

            <asp:Button ID="Login" runat="server" Text="Login" CssClass="btn" OnClick="Login_Click" />
            <div class="bottom-text">
                Forgot Password? 
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Pages/Shared/ForgotPassword.aspx">Click here</asp:HyperLink>
            </div>
            <div class="bottom-text">
                Don’t have an account? 
                <asp:HyperLink ID="Signup" runat="server" NavigateUrl="~/Pages/Shared/Signup.aspx">Sign up</asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>