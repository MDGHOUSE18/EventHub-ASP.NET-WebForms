<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="EventHub.Pages.Shared.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="~/styles/styles.css" /> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
        function ShowPassword(checkBox) {
            //var PasswordTextBox = document.getElementById('PassTextBox');
            var PasswordTextBox = document.getElementById(checkBox.getAttribute("data-target"));
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
            <h1>Reset Password</h1>
            <div>
                <label for="UserTextBox">Email</label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserTextBox" Display="Dynamic" ErrorMessage="Please enter your email" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="UserTextBox" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" Display="Dynamic" ErrorMessage="Please enter a valid email" ForeColor="Red" CssClass="error-message"></asp:RegularExpressionValidator>
                <asp:TextBox ID="UserTextBox" runat="server" placeholder="Enter your email" ></asp:TextBox>
            </div>
            <div>    
                <label for="PassTextBox"  style="display: inline;">Password</label>
                <span class="small-text"style="margin-left: 225px;"><input type="checkbox" data-target="PassTextBox" onclick="ShowPassword(this)" /> Show</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="PassTextBox" Display="Dynamic" ErrorMessage="Please enter a password" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="PasswordValidator" runat="server" ControlToValidate="PassTextBox" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" Display="Dynamic" ErrorMessage="Password must be at least 8 characters long and contain both letters and numbers" ForeColor="Red" CssClass="error-message"></asp:RegularExpressionValidator>
                <asp:TextBox ID="PassTextBox" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            </div>
            <div>    
                <label for="ConfirmPassTextBox" style="display: inline;">Confirm Password</label>
                <span class="small-text" style="margin-left: 170px;"><input type="checkbox" data-target="ConfirmPassTextBox" onclick="ShowPassword(this)" /> Show</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ConfirmPassTextBox" Display="Dynamic" ErrorMessage="Please confirm your password" CssClass="error-message"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="ComparePasswordValidator" runat="server" ControlToValidate="ConfirmPassTextBox" ControlToCompare="PassTextBox" Display="Dynamic" ErrorMessage="Passwords do not match" ForeColor="Red" CssClass="error-message"></asp:CompareValidator>
                <asp:TextBox ID="ConfirmPassTextBox" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
            </div>

            <asp:Button ID="ResetPass" runat="server" Text="Reset Password" CssClass="btn btn-primary" OnClick="Reset_Click" />
            
            <div class="bottom-text">
                Don’t have an account? 
                <asp:HyperLink ID="Signup" runat="server" NavigateUrl="Signin.aspx">Sign In</asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>
