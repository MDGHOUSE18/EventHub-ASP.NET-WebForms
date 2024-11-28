window.onload = function () {
    alert("JavaScript is working!");
};

function ShowPassword(checkBox) {
    // Access the global passTextBoxID variable
    var PasswordTextBox = document.getElementById(window.passTextBoxID);

    if (PasswordTextBox) {
        if (checkBox.checked) {
            PasswordTextBox.setAttribute("type", "text");
        } else {
            PasswordTextBox.setAttribute("type", "password");
        }
    } else {
        console.error("Password TextBox not found.");
    }
}