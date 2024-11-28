// site.js

console.log("AdminMasterPage.js loaded");

window.onload = function () {
    alert("JavaScript is working!");
};
function confirmLogout() {
    var result = confirm("Are you sure you want to logout?");
    if (result) {
        window.location.href = 'Logout.aspx'; 
    }
}

