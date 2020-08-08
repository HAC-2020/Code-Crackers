const username = document.getElementById("username");
const email = document.getElementById("email");
const pass = document.getElementById("pass");
const phone = document.getElementById("phone");
const dob = document.getElementById("dob");
const city = document.getElementById("city");
const state = document.getElementById("state");
const bg = document.getElementById("bg");
const bdonor = document.querySelector(".checkbox").checked;
const platdonor = document.getElementById("platdonor").checked;
const plasdonor = document.getElementById("plasdonor").checked;

var currentDate = new Date();
var date = currentDate.getDate();
var month = currentDate.getMonth();
var year = currentDate.getFullYear();
var time = currentDate.getHours();
var min = currentDate.getMinutes();

var dateString =
  date + "-" + (month + 1) + "-" + year + " at" + time + ":" + min;

const button1 = document.getElementById("button1");

const database = firebase.firestore();

const usersCollection = database.collection("users");

button1.addEventListener("click", (e) => {
  e.preventDefault();
  usersCollection.doc(email.value).set({
    Name: username.value,
    "Email Id": email.value,
    Password: pass.value,
    "Phone Number": phone.value,
    "Date Of Birth": dob.value,
    City: city.value,
    State: state.value,
    "Blood Group": bg.value,
    "Blood Donor": bdonor,
    "Platelets Donor": platdonor,
    "Plasma Donor": plasdonor,
    timestamp: dateString,
  });
});
